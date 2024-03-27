import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
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
    try {
      if (!passwordEquals()) {
        throw FirebaseAuthException(
          code: 'passwords-do-not-match',
          message: 'Las contraseñas no coinciden',
        );
      }

      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final User user = userCredential.user!;

      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection(collectionUser).doc(user.uid);

      await userDoc.set({
        'id': user.uid,
        'name': name.text.toString(),
        'email': email.text.toString(),
        'password': password.text.toString(),
        'biography': '',
        'profileImage': '',
      }, SetOptions(merge: true))
        .then((value){
          VxToast.show(
            context,
            msg: "Usuario registrado correctamente",
          );
        });

      // Se ha registrado correctamente
      Get.offAll(() => const Login());
    } catch (error) {
      String errorMessage = "Error desconocido al crear la cuenta";

      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'invalid-email':
            errorMessage = "Introduce un email válido";
            break;
          case 'invalid-password':
            errorMessage = "Longitud de al menos 6 caracteres";
            break;
          case 'email-already-in-use':
            errorMessage = "Otro usuario ya tiene este email";
            break;
          default:
            errorMessage = "Error inesperado al iniciar sesión, inténtelo más tarde";
        }
      }
      VxToast.show(
        context,
        msg: errorMessage,
        textColor: redColor,
      );
    }
  }

  //* Comprobar que las contraseñas son iguales
  bool passwordEquals() {
    return password.text.trim() == confirmPassword.text.trim();
  }
}