import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/controllers/sign_up_controller.dart';
import 'package:tfg/src/features/auth/models/user_model.dart';
import 'package:tfg/src/features/auth/views/logIn/log_in.dart';
import 'package:tfg/src/utils/validateEmail/validate_email.dart';
import 'package:tfg/src/widgets/textFieldInput/text_field_input_widget.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final firebase = FirebaseFirestore.instance;
  final signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = true;

  //! ERROR INESPERADO PUEDE SALTAR SI EL CORREO USADO ES EL MISMO DE UN USUARIO 
  //! QUE YA ESTA AUTENTICADO (AUTHENTICATION) PERO SE HA BORRADO DE FIRESTORE!!!

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: heightSize - 10),
        child: Column(
          children: [
            TextFieldInputWidget(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Este campo no puede quedar vacío";
                } else if (value.length < 6) {
                  return "El nombre tiene que tener al menos 6 caracteres";
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
              validator: validateEmail,
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
                  return "La contraseña tiene que tener al menos 6 caracteres";
                } else if (value != signUpController.confirmPassword.text) {
                  return "Las contraseñas no coinciden";
                }
                return null;
              },
              controller: signUpController.password,
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
              isPass: true,
            ),
            const SizedBox(height: heightSize - 20,),
            //! HACER LAS COMPROBACIONES DE QUE LAS DOS CONTRASEÑAS SON IGUALES
            TextFieldInputWidget(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Este campo no puede quedar vacío";
                } else if (value.length < 6) {
                  return "La contraseña tiene que tener al menos 6 caracteres";
                }
                return null;
              },
              controller: signUpController.confirmPassword,
              labelText: repeatPassword,
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
              isPass: true,
            ),
            const SizedBox(height: heightSize),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final name = signUpController.name.text.trim();
                  final email = signUpController.email.text.trim();
                  final password = signUpController.password.text.trim();

                  if (_formKey.currentState!.validate()) {
                    // final user = UserModel(
                    //   //id: signUpController.userRepository.currentUser.uid,
                    //   id: "id",
                    //   name: name,
                    //   email: email,
                    //   password: password,
                    //   biography: "Explorando...",
                    //   profileImage: "",
                    //   // lastActive: "",
                    //   // pushToken: ""
                    // );
                    
                    signUpController.signUp(context)
                    .then((value) => Get.offAll(() => const Login()));
                  }

                  /*try {
                    //! UTILIZAR TAMBIEN LA AUTHENTICATION DE FIREBASE JUNTO A 
                    //! FIRESTORE?
                    /*await AuthService.firebase()
                        .signUp(email: email, password: password)
                        .then((value) {
                          //createUser();

                          //! DONDE COLOCAR ESTE SNACK BAR PARA QUE SOLO SALTE SI
                          //! HA TERMINADO CORRECTAMENTE?
                          /*showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.success(
                              message: "Cuenta creada correctamente"
                            )
                          );*/

                          final user = UserModel(
                            name: name,
                            email: email,
                            password: password
                          );

                          //! MANERA DE NOTIFICAR CON UN SHOWTOPSNACKBAR DE QUE SE 
                          //! HA CREADO LA CUENTA CORRECTAMENTE?
                          

                          Get.offAllNamed(loginRoute);
                        });*/

                    final user = UserModel(
                      name: name,
                      email: email,
                      password: password
                    );

                    SignUpController.instance.createUser(user);
                  } on EmailExistsAuthException {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "EL CORREO INTRODUCIDO YA PERTENECE A OTRO USUARIO"
                      )
                    );
                    /*await showErrorDialog(context,
                        'EL CORREO INTRODUCIDO YA PERTENECE A OTRO USUARIO');*/
                  } on InvalidEmailAuthException {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "EL CORREO INTRODUCIDO NO ES VÁLIDO"
                      )
                    );
                    /*await showErrorDialog(context,
                        'EL CORREO INTRODUCIDO NO ES VÁLIDO');*/
                  } on InvalidPasswordAuthException {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "LA CONTRASEÑA INTRODUCIDA NO ES VÁLIDA (MÍNIMO 6 CARACTERES)"
                      )
                    );
                    /*await showErrorDialog(context,
                        'LA CONTRASEÑA INTRODUCIDA NO ES VÁLIDA (MÍNIMO 6 CARACTERES)');*/
                  } on EmptyFieldsException {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "RELLENE TODOS LOS CAMPOS"
                      )
                    );
                    /*await showErrorDialog(
                        context, 'RELLENE TODOS LOS CAMPOS');*/
                  } on GenericAuthException {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "ERROR AL REGISTRARSE"
                      )
                    );
                    /*await showErrorDialog(
                        context, 'ERROR AL REGISTRARSE');*/
                  }*/
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
  void dispose() {
    signUpController.dispose();
    super.dispose();
  }
}