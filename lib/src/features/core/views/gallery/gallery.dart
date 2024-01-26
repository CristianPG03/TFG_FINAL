//! ELIMINAR IMAGEN?

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/features/core/views/gallery/add_image_gallery.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

//! ARREGLAR PARA QUE LAS IMAGENES SE VEAN POR DEBAJO DE LA APPBAR
class _GalleryState extends State<Gallery> {
  final userController = Get.put(UserController());
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(const AddImageGallery());
                  },
                  child: const Text("AÑADIR IMAGEN")),
              )
            ],
          ),
          Divider(
            color: mainGrayColor,
            indent: space,
            thickness: 2,
            endIndent: space,
          ),
          SizedBox(
            width: size.width,
            height: size.height-230,
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('imageURLs').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: LoadingAnimation(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return const Text("No hay imágenes");
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(), // Para deshabilitar el desplazamiento de GridView dentro de SingleChildScrollView
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final imageURL = snapshot.data!.docs[index]['url'];
                          return GestureDetector(
                            onLongPress: () {
                              _mostrarPopupConfirmacion(context, snapshot.data!.docs[index].id);
                            },
                            child: Image.network(
                              imageURL,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _mostrarPopupConfirmacion(BuildContext context, String imageId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar imagen"),
          content: const Text("¿Estás seguro de que deseas eliminar esta imagen?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el popup
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el popup
                _eliminarImagen(imageId); // Eliminar la imagen
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  void _eliminarImagen(String imageId) async {
    try {
      await FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('imageURLs').doc(imageId).delete();
      // Aquí podrías mostrar un mensaje de éxito o actualizar la interfaz de usuario de alguna manera
      print("Imagen eliminada");
    } catch (error) {
      // Manejar cualquier error que pueda ocurrir durante la eliminación
      print("Error al eliminar la imagen: $error");
    }
  }
}