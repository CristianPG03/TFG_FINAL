import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/images.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/views/logIn/log_in.dart';
import 'package:tfg/src/features/auth/views/signUp/sign_up.dart';
import 'package:tfg/src/widgets/fadeInAnimation/animation_design.dart';
import 'package:tfg/src/widgets/fadeInAnimation/fade_in_animation_controller.dart';
import 'package:tfg/src/widgets/fadeInAnimation/fade_in_animation_model.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final fadeInController = Get.put(FadeInAnimationController());
    fadeInController.startAnimation();

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
      body: Stack(
        children: [
          FadeInAnimationWidget(
            durationInMs: 1200,
            animatePosition: AnimatePosition(
              bottomBefore: -100, bottomAfter: 0,
              rightBefore: 0, rightAfter: 0,
              topBefore: 0, topAfter: 0,
              leftBefore: 0, leftAfter: 0,
            ),
            child: Container(
              padding: const EdgeInsets.all(defaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: const AssetImage(imageWelcome),
                    height: height * 0.5,
                  ),
                  Column(
                    children: [
                      Text(
                        welcomeTitle,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        welcomeSubtitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.to(const Login()),
                          child: Text(loginText.toUpperCase())
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.to(const SignUp()),
                          child: Text(signupText.toUpperCase())
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: const AssetImage(imageBgSplashScreen),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.srcOver),
      )),
    );
  }*/
}
