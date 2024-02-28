import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/firebase_options.dart';
import 'package:tfg/src/features/auth/views/splashScreen/splash_screen.dart';
import 'package:tfg/src/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const App());
}

//! PONER CIRCULOS DE CARGA AL EJECUTAR ACCIONES
//! MANTENER SESION INICIADA

class App extends StatelessWidget {
  const App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      //! HACER PARA QUE SI YA TIENE CUENTA Y NO HA CERRADO SESIÓN QUE ENTRE 
      //! DIRECTAMENTE A START
      home: SplashScreen()
      //home: const IsLogged(),
      /*home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),*/
      /*routes: {
        welcomeRoute: (context) => const Welcome(),
        loginRoute: (context) => const Login(),
        signupRoute: (context) => const SignUp(),
        newsRoute: (context) => const News(),
        //forgetPasswordEmailRoute: (context) => const ForgetPasswordEmail(),
        //otpCodeRoute: (context) => const OTPScreen(),
        editProfileRoute:(context) => const EditProfile(),
      },*/
    );
  }
}