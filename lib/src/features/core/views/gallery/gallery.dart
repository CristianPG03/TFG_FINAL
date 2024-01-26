//! ELIMINAR IMAGEN?

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/features/core/views/gallery/add_image_gallery.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final userController = Get.put(UserController());
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: (){
                          Get.to(const AddImageGallery());
                        },
                        child: const Text("AÑADIR IMAGEN")),
                    )
                  ],
                ),
              ),
              const Divider(),
              SafeArea(
                bottom: false,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('imageURLs').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: LoadingAnimation(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Text("No hay imágenes");
                          } else {
                            return SafeArea(
                              bottom: false,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical, // Hacer el GridView scrollable horizontalmente
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(), // Para deshabilitar el desplazamiento de GridView dentro de SingleChildScrollView
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Número de columnas en la cuadrícula
                                    crossAxisSpacing: 8, // Espaciado horizontal entre elementos de la cuadrícula
                                    mainAxisSpacing: 8, // Espaciado vertical entre elementos de la cuadrícula
                                    childAspectRatio: 1, // Hacer que las celdas sean cuadradas
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
                                        fit: BoxFit.cover, // Ajustar la imagen para cubrir toda la celda
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarPopupConfirmacion(BuildContext context, String imageId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Eliminar imagen"),
          content: Text("¿Estás seguro de que deseas eliminar esta imagen?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el popup
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el popup
                _eliminarImagen(imageId); // Eliminar la imagen
              },
              child: Text("Eliminar"),
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