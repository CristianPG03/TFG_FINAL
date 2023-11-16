import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/features/auth/models/user_model.dart' as model;
import 'package:tfg/src/features/auth/views/logIn/log_in.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userRepository = Get.put(UserController());

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  //* Crear autenticación de usuario y añadirlo a la base de datos
  Future signUp(context) async {
    if (passwordEquals()) {
      final User? user = (await auth.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim()
      )).user;
      
      if (user != null) {
        DocumentReference store = firebaseFirestore.collection(collectionUser).doc(user.uid);
        
        // model.UserModel userModel = model.UserModel(
        //     id: store.id,
        //     name: name.text.toString(),
        //     email: email.text.toString(),
        //     password: password.text.toString(),
        //     biography: '',
        //     profileImage: '',
        //     followers: [],
        //     following: []
        //   );
        // await store.set(userModel.toJson());

        await store.set({
          'id' : user.uid,
          'name' : name.text.toString(),
          'email' : email.text.toString(),
          'password' : password.text.toString(),
          'biography' : '',
          'profileImage' : ''
        }, SetOptions(merge: true));
      } else {
        VxToast.show(context, msg: "Hola", position: VxToastPosition.top);
      }
    }
  }

  //* Comprobar que las contraseñas son iguales
  bool passwordEquals() {
    if (password.text.trim() == confirmPassword.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
}