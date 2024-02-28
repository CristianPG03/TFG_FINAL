import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/features/auth/views/logIn/forgotPassword/email_sent.dart';
import 'package:tfg/src/features/core/views/start/start.dart';
import 'package:velocity_x/velocity_x.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  final _auth = FirebaseAuth.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  final forgotPasswordEmail = TextEditingController();

  final userRepository = Get.put(UserController());

  //* Iniciar sesión con autenticación
  // Future logIn() async {
  //   await _auth.signInWithEmailAndPassword(
  //     email: email.text.trim(), password: password.text.trim()
  //   ).then((value) => Get.offAll(() => const Start()));
  // }

  // Future logIn(context) async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(
  //       email: email.text.trim(), password: password.text.trim()
  //     ).then((value) => Get.offAll(() => const Start()));
  //   } catch (error) {
  //     String errorMessage = "Error desconocido al iniciar sesión";
  //     if (error is FirebaseAuthException) {
  //       switch (error.code) {
  //         case 'invalid-email':
  //           errorMessage = "Introduce un email válido";
  //           break;
  //         case 'invalid-password':
  //           errorMessage = "Longitud de al menos 6 caracteres";
  //           break;
  //         case 'invalid-credential':
  //           errorMessage = "El usuario introducido no existe";
  //           VxToast.show(
  //             context,
  //             msg: errorMessage,
  //             textColor: redColor,
  //           );
  //           break;
  //         default:
  //           errorMessage = "Error inesperado al iniciar sesión: ${error.code}";
  //       }
  //     }
  //     // Mostrar mensaje de error al usuario
  //     print(errorMessage);
  //   }
  // }

  Future logIn(context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text.trim(), password: password.text.trim()
      ).then((value) {
        Get.offAll(() => const Start());
      });
    } catch (error) {
      String errorMessage = "Error desconocido al iniciar sesión";
      if (error is FirebaseAuthException) {
        switch (error.code) {
          //! NECESARIOS ESTOS DOS?
          // case 'invalid-email':
          //   errorMessage = "Introduce un email válido";
          //   break;
          // case 'invalid-password':
          //   errorMessage = "Longitud de al menos 6 caracteres";
          //   break;
          case 'invalid-credential':
            errorMessage = "El usuario introducido no existe";
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


  //* Enviar correo para cambiar la contraseña (olvidada)
  Future forgotPasswordReset(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: forgotPasswordEmail.text.trim())
      .then((value) => Get.to(const EmailSent()));
    } on FirebaseAuthException catch (e) {
      return Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: e.message
      ).show();
    }
  }
}