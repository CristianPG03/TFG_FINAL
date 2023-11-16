import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tfg/src/features/auth/views/splashScreen/splash_screen.dart';
import 'package:tfg/src/features/core/views/start/start.dart';

class IsLogged extends StatelessWidget {
  const IsLogged({super.key});

  //! HACER QUE GUARDE LA SESIÓN, SI PROBLEMAS CON ESTA VISTA, ELIMINARLA Y HACERLO
  //! DE OTRA FORMA

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Start();
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}