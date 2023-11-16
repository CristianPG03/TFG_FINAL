import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/widgets/fadeInAnimation/fade_in_animation_controller.dart';
import 'package:tfg/src/widgets/fadeInAnimation/fade_in_animation_model.dart';

class FadeInAnimationWidget extends StatelessWidget {
  FadeInAnimationWidget({
    super.key,
    required this.durationInMs,
    this.animatePosition,
    required this.child,
  });

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final AnimatePosition? animatePosition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedPositioned(
      duration: Duration(milliseconds: durationInMs),
      top: controller.animate.value ? animatePosition!.topAfter : animatePosition!.topBefore,
      right: controller.animate.value ? animatePosition!.rightAfter : animatePosition!.rightBefore,
      bottom: controller.animate.value ? animatePosition!.bottomAfter : animatePosition!.bottomBefore,
      left: controller.animate.value ? animatePosition!.leftAfter : animatePosition!.leftBefore,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: durationInMs),
        opacity: controller.animate.value ? 1 : 0,
        child: child,
      ),
    ));
  }
}