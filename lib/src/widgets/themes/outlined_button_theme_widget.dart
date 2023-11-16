import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';

class OutlinedButtonThemeWidget {
  OutlinedButtonThemeWidget._();

  //* MODO CLARO *//
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const StadiumBorder(),
      foregroundColor: mainGreenColor,
      side: BorderSide(color: mainGreenColor),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),
    ),
  );

  //* MODO OSCURO *//
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const StadiumBorder(),
      foregroundColor: mainGreenColor,
      side: BorderSide(color: mainGreenColor),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}