import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/features/auth/views/logIn/forgotPassword/email_sent.dart';
import 'package:tfg/src/features/core/views/start/start.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  final _auth = FirebaseAuth.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  final forgotPasswordEmail = TextEditingController();

  final userRepository = Get.put(UserController());

  //* Iniciar sesión con autenticación
  Future logIn() async {
    await _auth.signInWithEmailAndPassword(
      email: email.text.trim(), password: password.text.trim()
    ).then((value) => Get.offAll(() => const Start()));
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