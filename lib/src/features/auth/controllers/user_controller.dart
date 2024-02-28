import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/features/auth/models/user_model.dart';
import 'package:tfg/src/features/auth/views/welcome/welcome.dart';
import 'package:tfg/src/features/core/views/start/start.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart' as Path;

//! AÑADIR TRY CATCH
class UserController extends GetxController {
  static UserController get instance => Get.find();
  
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var biographyController = TextEditingController();

  var imgPath = ''.obs;
  var imgLink = '';

  //* Obtener información de un usuario
  getUserDetails(String id) {
    return firebaseFirestore.collection(collectionUser).where('id', isEqualTo: id).get();
  }

  //! SE UTILIZA?
  //* Obtener información de todos los usuarios
  getAllUsersDetails() {
    return firebaseFirestore.collection(collectionUser).snapshots();
  }

  //* Actualizar información de un usuario
  //! COMPROBAR SI FUNCIONA IGUAL USANDO EN LOS DOS LADOS LA UPDATEUSERDETAILS2
  updateUserDetails(context) async {
    var store = firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);

    await store.set({
      'name' : nameController.text,
      'email' : emailController.text,
      'password' : passwordController.text,
      'biography' : biographyController.text,
      // imgLink sera vacio si no se selecciona ninguna imagen
      'profileImage' : imgLink
    }, SetOptions(merge: true));

    VxToast.show(context, msg: "Perfil actualizado correctamente");
  }

  updateUserDetails2(BuildContext context, {String? imgUrl}) async {
    var store = firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);

    Map<String, dynamic> data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'biography': biographyController.text,
    };

    if (imgUrl != null) {
      data['profileImage'] = imgUrl;
    }

    await store.set(data, SetOptions(merge: true));

    VxToast.show(context, msg: "Perfil actualizado correctamente");
  }


  //* Seleccionar imagen
  pickImage(context, source) async {
    //! AÑADIR PEDIR PERMISOS Y COMPROBACION POR SI NO SE SELECCIONA NADA
    try {
      // source dependerá de la elección del usuario
      final img = await ImagePicker().pickImage(source: source, imageQuality: 80);
      imgPath.value = img!.path;
      
      // Si la imagen es seleccionada
      // img.path contiene la ruta de la imagen
      VxToast.show(context, msg: "Imagen seleccionada correctamente");
    } on PlatformException catch (e) {
      VxToast.show(context, msg: "Error al seleccionar la imagen");
    }
    // Obtener permisos del usuario
    // var photoPermissionStatus = await Permission.photos.request(); 
    // var cameraPermissionStatus = await Permission.camera.request();

    // // Gestionar status
    // if (photoPermissionStatus.isGranted && cameraPermissionStatus.isGranted) {
    //   try {
    //     // source dependerá de la elección del usuario
    //     final img = await ImagePicker().pickImage(source: source, imageQuality: 80);
    //     if (img != null) {
    //       // Si la imagen es seleccionada
    //       // img.path contiene la ruta de la imagen seleccionada
    //       print(img.path);
    //     }
    //   } on PlatformException catch (e) {
    //     VxToast.show(context, msg: "Error al seleccionar la imagen");
    //   }
    // } else {
    //   print("Permisos denegados");
    //   VxToast.show(context, msg: "Permisos denegados");
    // }
  }

  //* Subir imagen de perfil
  uploadImage() async {
    // Añadir path de la imagen seleccionada
    var name = Path.basename(imgPath.value);
    // Se crea un nuevo apartado en la coleccion images,
    // en la carpeta del usuario actual y se guarda la imagen
    var destination = 'images/${currentUser!.uid}/$name';
    Reference ref = firebaseStorage.ref().child(destination);
    // Actualizando el fichero
    await ref.putFile(File(imgPath.value));
    // Obteniendo la url del fichero y guardarlo en la variable imgUrl
    var imgUrl = await ref.getDownloadURL();
    imgLink = imgUrl;
  }

  //! NECESARIA ESTA FUNCION?
  //! MIRAR OTRA MANERA DE HACER ESTA FUNCION
  //* Actualizar foto perfil
  Future<String> uploadImageToStorage(String childName, File file) async {
    Reference ref = firebaseStorage.ref().child(childName).child("${DateTime.now()}jpg");
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    
    //* Para guardar las imágenes de un usuario en una colección a parte
    /*_db.collection("wallpaper").doc(DateTime.now().toString()).set({
      "id": currentUser!.uid,
      "email": currentUser!.email,
      "profileImage": imageUrl,

    });*/

    return imageUrl;
  }

  //* Eliminar a un usuario
  Future<void> deleteUser(context) async {
    try {  
      await firebaseFirestore.collection(collectionUser).doc(currentUser!.uid).delete();
      await firebaseFirestore.collection(collectionUser).doc(currentUser!.uid).collection("imageURLs").doc().delete();
      await currentUser!.delete();
      //! EL PROBLEMA ES QUE NO ENCUENTRA LOS DOCS, MIRAR COMO ACCEDER
      await firebaseStorage.ref().child('gallery/${currentUser!.uid}').delete();
      await firebaseStorage.ref().child('images/${currentUser!.uid}').delete();
    } catch(error) {
      // VxToast.show(context, msg: "Problema al eliminar el usuario. \nInténtelo otra vez más tarde");
      VxToast.show(context, msg: "${error}");
    }
  }

  // Future<void> deleteUser(BuildContext context) async {
  //   try {
  //     if (currentUser != null) {
  //       await firebaseFirestore.collection(collectionUser).doc(currentUser!.uid).delete();
        
  //       try {
  //         await currentUser!.delete();
  //         await firebaseStorage.ref().child("gallery/${currentUser!.uid}").delete();
  //         await firebaseStorage.ref().child("images/${currentUser!.uid}").delete();
  //         VxToast.show(context, msg: "Usuario eliminado correctamente");
  //       } catch (deleteUserError) {
  //         if (deleteUserError is FirebaseAuthException) {
  //           if (deleteUserError.code == 'requires-recent-login') {
  //             VxToast.show(context, msg: "El usuario necesita volver a autenticarse antes de eliminar su cuenta.");
  //           } else {
  //             VxToast.show(context, msg: "Error al eliminar el usuario. Inténtelo otra vez más tarde.");
  //           }
  //         } else {
  //           VxToast.show(context, msg: "Error al eliminar el usuario. Inténtelo otra vez más tarde.");
  //         }
  //       }
  //     } else {
  //       VxToast.show(context, msg: "No se pudo eliminar el usuario. Usuario no autenticado.");
  //     }
  //   } catch (error) {
  //     VxToast.show(context, msg: "Problema al eliminar el usuario. Inténtelo otra vez más tarde.");
  //   }
  // }
}