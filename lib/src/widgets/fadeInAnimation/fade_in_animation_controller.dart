import 'package:get/get.dart';
import 'package:tfg/src/features/auth/views/welcome/welcome.dart';

//*Controlador del widget encargado de la animación Fade In
class FadeInAnimationController extends GetxController {
  //*Creación de la instacia de esta clase
  static FadeInAnimationController get find => Get.find();

  //*RxBool hace que esta variable sea observable desde todas las vistas 
  RxBool animate = false.obs;

  //*Método encargado de iniciar la animación
  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    animate.value = true;
  }

  //*Método encargado de iniciar la animación del Splash screen
  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 1200));
    Get.offAll(() => const Welcome());
  }
}