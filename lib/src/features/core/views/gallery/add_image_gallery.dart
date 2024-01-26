import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';
import 'package:path/path.dart' as Path;

class AddImageGallery extends StatefulWidget {
  const AddImageGallery({super.key});

  @override
  State<AddImageGallery> createState() => _AddImageGalleryState();
}

class _AddImageGalleryState extends State<AddImageGallery> {
  final userController = Get.put(UserController());
  bool uploading = false;
  double val = 0;  
  CollectionReference<Map<String, dynamic>> imgRef = FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('imageURLs');
  List<File> _image = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(
        appBarTitle: "AÑADIR IMAGEN",
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                uploading = true;
              });
              uploadImageToGallery().whenComplete(() => Get.back());
            },
            child: Text("SUBIR")
          )
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
            itemCount: _image.length+1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              return index == 0
                ? Center(
                  child: IconButton(
                    onPressed: () => !uploading ? chooseImage() : null,
                    icon: Icon(Icons.add, size: 40,)
                  ),
                )
                : Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_image[index-1]),
                      fit: BoxFit.cover
                    )
                  ),
                );
            }
          ),
          uploading ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    'subiendo...',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                CircularProgressIndicator(
                  value: val,
                  valueColor: AlwaysStoppedAnimation<Color>(mainGreenColor),
                )
              ],
            ),
          )
          : Container()
        ]
      ),
    );
  }

  //! SEPARAR FUNCIONES A OTRO FILE

  //! COMPROBACION/ACCION DE SI NO ELIGE NINGUNA IMAGEN
  // chooseImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image.add(File(pickedFile!.path));
  //   });

  //   if(pickedFile?.path == null) {
  //     retrieveLostData();
  //   }
  // }

  chooseImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _image.add(File(pickedFile.path));
    });
  } else {
    // El usuario no seleccionó ninguna imagen
    print('No se seleccionó ninguna imagen.');
  }
}

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();

    if(response.isEmpty) {
      return;
    }

    if(response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  //! SI ESTO FUNCIONA, CAMBIAR LA FUNCION UPLOAD IMAGE (USER_CONTROLLER) CON LO DE WHENCOMPLETE()...
  //* Subir imagen/es al storage de Firebase
  uploadImageToGallery() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });

      var name = Path.basename(img.path);
      var destination = '${currentUser!.uid}/$name';
      Reference ref = firebaseStorage.ref().child(destination);
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
          
          i++;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    imgRef = FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('imageURLs');
  }
}