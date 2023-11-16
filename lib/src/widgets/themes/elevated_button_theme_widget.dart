import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';

class ElevatedButtonThemeWidget {
  //* MODO CLARO *//
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const StadiumBorder(),
      foregroundColor: whiteColor,
      backgroundColor: mainGreenColor,
      side: BorderSide(color: mainGreenColor),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
      )
    ),
  );

  //* MODO OSCURO *//
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const StadiumBorder(),
      foregroundColor: whiteColor,
      backgroundColor: mainGreenColor,
      side: BorderSide(color: mainGreenColor),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
      )
    ),
  );
}