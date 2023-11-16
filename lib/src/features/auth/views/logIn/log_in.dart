import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/views/logIn/log_in_form_widget.dart';
import 'package:tfg/src/features/auth/views/signUp/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    
    return SafeArea(
      bottom: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: mainGreenColor,
              size: defaultSize,
            )
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: isDarkMode ? darkColor : lightColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  appName,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  shadowColor: isDarkMode ? lightColor : darkColor,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          appTagLine,
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const LoginForm(),
                        TextButton(
                          onPressed: () => Get.to(const SignUp()),
                          child: Text.rich(
                            TextSpan(
                              text: noAccount,
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: const [
                                TextSpan(
                                  text: signupText,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ]
                            )
                          )
                        ),
                        /*SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              final email = _email.text;
                              final password = _password.text;
                  
                              try {
                                await AuthService.firebase()
                                    .logIn(email: email, password: password);
                                final user = AuthService.firebase().currentUser;
                                //Comprobamos si el usuario ha verificado el email
                                if (user?.isEmailVerified ?? false) {
                                  //Si lo ha hecho, se envía a la ventana de news
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      newsRoute, (route) => false);
                                } else {
                                  //Si no, se envía a la pantalla de verificación
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      verifyEmailRoute, (route) => false);
                                }
                              } on UserNotFoundAuthException {
                                await showErrorDialog(context,
                                    'EL CORREO INTRODUCIDO NO PERTENECE A NINGÚN USUARIO');
                              } on WrongPasswordAuthException {
                                await showErrorDialog(
                                    context, 'LA CONTRASEÑA NO ES CORRECTA');
                              } on GenericAuthException {
                                await showErrorDialog(
                                    context, 'ERROR INESPERADO');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainGreenColor,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                side: const BorderSide(
                                    width: 0.5, color: Colors.black)),
                            child: const Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                signupRoute, (route) => false);
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: 'No tienes cuenta? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16
                              ),
                              children: [
                                TextSpan(
                                  text: 'Regístrate',
                                  style: TextStyle(color: Colors.blue),
                                )
                              ]
                            )
                          )
                        ),*/
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}