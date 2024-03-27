import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/controllers/sign_up_controller.dart';
import 'package:tfg/src/utils/validateEmail/validate_email.dart';
import 'package:tfg/src/widgets/textFieldInput/text_field_input_widget.dart';

//* Definición del widget que contiene el formulario de registro
class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final signUpController = Get.put(SignUpController()); // Controlador de la vista de registro
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Clave global para el formulario
  bool showPassword = true; // Variable para mostrar/ocultar la contraseña
  bool showPassword2 = true; // Variable para mostrar/ocultar la contraseña repetida

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Asigna la clave global al formulario
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: heightSize - 10),
        child: Column(
          // Campos del formulario
          children: [
            TextFieldInputWidget(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Este campo no puede quedar vacío";
                } else if (value.length < 6) {
                  return "Longitud de al menos 6 caracteres";
                }
                return null;
              },
              controller: signUpController.name,
              labelText: name,
              prefixIcon: const Icon(Icons.person_outline_rounded),
              keyboard: TextInputType.text,
              isPass: false,
            ),
            const SizedBox(height: heightSize - 20,),
            TextFieldInputWidget(
              validator: validateEmail, // Función para validar si el email es correcto
              controller: signUpController.email,
              labelText: email,
              prefixIcon: const Icon(Icons.mail),
              keyboard: TextInputType.emailAddress,
              isPass: false,
            ),
            const SizedBox(height: heightSize - 20,),
            TextFieldInputWidget(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Este campo no puede quedar vacío";
                } else if (value.length < 6) {
                  return "Longitud de al menos 6 caracteres";
                } else if (value != signUpController.confirmPassword.text) {
                  return "Las contraseñas no coinciden";
                }
                return null;
              },
              controller: signUpController.password,
              labelText: password,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () { // Ocultar/mostrar contraseña
                  setState(() {
                    showPassword = !showPassword;
                  });
                  FocusScope.of(context).unfocus();
                },
                child: Icon(showPassword == true ? Icons.visibility : Icons.visibility_off), // Icono para mostrar/ocultar la contraseña
              ),
              keyboard: TextInputType.text,
              isPass: showPassword,
            ),
            const SizedBox(height: heightSize - 20,),
            TextFieldInputWidget(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Este campo no puede quedar vacío";
                } else if (value.length < 6) {
                  return "Longitud de al menos 6 caracteres";
                }
                return null;
              },
              controller: signUpController.confirmPassword,
              labelText: repeatPassword,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () { // Ocultar/mostrar contraseña
                  setState(() {
                    showPassword2 = !showPassword2;
                  });
                  FocusScope.of(context).unfocus();
                },
                child: Icon(showPassword2 == true ? Icons.visibility : Icons.visibility_off), // Icono para mostrar/ocultar la contraseña
              ),
              keyboard: TextInputType.text,
              isPass: showPassword2,
            ),
            const SizedBox(height: heightSize),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    signUpController.signUp(context);
                  }
                },
                child: Text(signupText.toUpperCase())
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  // Liberación de los recursos del controlador al destruir el estado
  void dispose() {
    signUpController.dispose();
    super.dispose();
  }
}