import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/images.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/widgets/fadeInAnimation/animation_design.dart';
import 'package:tfg/src/widgets/fadeInAnimation/fade_in_animation_controller.dart';
import 'package:tfg/src/widgets/fadeInAnimation/fade_in_animation_model.dart';

//* Definición de la pantalla de carga inicial
class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  //*Instancia del controller de SplashSceenController
  //*Usar Get.put() hace la clase entre paréntesis disponible para todas las
  //*rutas "hijas" que estén en esta clase
  //final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    final fadeInController = Get.put(FadeInAnimationController());
    fadeInController.startSplashAnimation();
    
    return Scaffold(
      body: Stack(
        children: [
          FadeInAnimationWidget(
            durationInMs: 1200,
            animatePosition: AnimatePosition(
              topBefore: -30, topAfter: 30,
              leftBefore: -30, leftAfter: defaultSize,
            ),
            child: const Image(image: AssetImage(imageGameOver), width: 100,)
          ),
          FadeInAnimationWidget(
            durationInMs: 1200,
            animatePosition: AnimatePosition(
              topBefore: 150, topAfter: 130,
              leftBefore: -80, leftAfter: defaultSize,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appName, style: Theme.of(context).textTheme.displaySmall,),
                Text(appTagLine, style: Theme.of(context).textTheme.displayLarge,),
              ],
            )
          ),
          FadeInAnimationWidget(
            durationInMs: 1200,
            animatePosition: AnimatePosition(
              bottomBefore: 0, bottomAfter: 100,
            ),
            child: Image(
              image: const AssetImage(imageTourist),
              width: MediaQuery.of(context).size.width,
            )
          ),
          FadeInAnimationWidget(
            durationInMs: 1200,
            animatePosition: AnimatePosition(
              rightBefore: defaultSize, rightAfter: defaultSize,
              bottomBefore: 0, bottomAfter: 60,
            ),
            child: Container(
              width: heightSize,
              height: heightSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: mainGreenColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*@override
  void initState() {
    super.initState();
    _endSplashScreen();
  }

  Future _endSplashScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(bgSplashScreen), fit: BoxFit.fill)),
      child: Image.asset(logoSplashScreen),
    );
  }*/
}
