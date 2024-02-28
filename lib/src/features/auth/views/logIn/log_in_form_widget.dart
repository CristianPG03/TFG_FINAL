import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/controllers/log_in_controller.dart';
import 'package:tfg/src/features/auth/views/logIn/forgotPassword/forgot_password.dart';
import 'package:tfg/src/utils/validateEmail/validate_email.dart';
import 'package:tfg/src/widgets/textFieldInput/text_field_input_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final logInController = Get.put(LogInController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: heightSize - 10),
        child: Column(
          children: [
            TextFieldInputWidget(
              validator: validateEmail,
              controller: logInController.email,
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
                }
                return null;
              },
              controller: logInController.password,
              labelText: password,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                  FocusScope.of(context).unfocus();
                },
                child: Icon(showPassword == true ? Icons.visibility : Icons.visibility_off),
              ),
              keyboard: TextInputType.text,
              isPass: showPassword,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(const ForgotPassword()),
                child: const Text(forgotPassword)
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // final email = logInController.email.text.trim();
                  // final password = logInController.password.text.trim();

                  //! PARA VALIDAR LOS TEXTFIELDS CON VALIDATOR: X
                  if (_formKey.currentState!.validate()) {
                    logInController.logIn(context);
                  }
                },
                child: Text(loginText.toUpperCase())
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    //! AL REGISTRAR USUARIO, EL LOGINCONTROLLER.DISPOSE() SIEMPRE DA ERROR
    //! CON EL COMENTADO PASA ALGO?? CORREGIRLO
    // logInController.dispose();
    super.dispose();
  }
}