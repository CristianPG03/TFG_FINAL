import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/views/logIn/log_in.dart';
import 'package:tfg/src/features/auth/views/signUp/sign_up_form_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _repeatPassword;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _repeatPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _repeatPassword.dispose();
    super.dispose();
  }

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
                      children: [
                        Text(
                          appTagLine,
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SignupForm(),
                        TextButton(
                          onPressed: () => Get.to(const Login()),
                          child: Text.rich(
                            TextSpan(
                              text: alreadyAccount,
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: const [
                                TextSpan(
                                  text: loginText,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ]
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                )
          
                /*Container(
                  height: 525,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(5, 5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Preparado/a para descubrir Galicia?',
                        style: fontSlogan,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                          controller: _name,
                          keyboard: TextInputType.text,
                          labelText: 'Nombre',
                          icon: const Icon(FontAwesomeIcons.signature)),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                          controller: _email,
                          keyboard: TextInputType.emailAddress,
                          labelText: 'Email',
                          icon: const Icon(FontAwesomeIcons.envelope)),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                          isPass: true,
                          controller: _password,
                          keyboard: TextInputType.text,
                          labelText: 'Contraseña',
                          icon: const Icon(FontAwesomeIcons.eyeSlash)),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                          isPass: true,
                          controller: _repeatPassword,
                          keyboard: TextInputType.text,
                          labelText: 'Repita la contraseña',
                          icon: const Icon(FontAwesomeIcons.eyeSlash)),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            //final name = _name.text;
                            final email = _email.text;
                            final password = _password.text;
                            //final repeatPassword = _repeatPassword.text;
          
                            try {
                              await AuthService.firebase()
                                  .signUp(email: email, password: password);
                              AuthService.firebase().sendEmailVerification();
                              Navigator.of(context).pushNamed(verifyEmailRoute);
                            } on EmailExistsAuthException {
                              await showErrorDialog(context,
                                  'EL CORREO INTRODUCIDO YA PERTENECE A OTRO USUARIO');
                            } on InvalidEmailAuthException {
                              await showErrorDialog(context,
                                  'EL CORREO INTRODUCIDO NO ES VÁLIDO');
                            } on InvalidPasswordAuthException {
                              await showErrorDialog(context,
                                  'LA CONTRASEÑA INTRODUCIDA NO ES VÁLIDA (MÍNIMO 6 CARACTERES)');
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
                            'Registrarse',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
