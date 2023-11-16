import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';

class TextFormFieldThemeWidget {
  TextFormFieldThemeWidget._();

  //* MODO CLARO *//
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder(),
    prefixIconColor: mainGrayColor,
    suffixIconColor: mainGrayColor,
    floatingLabelStyle: TextStyle(color: darkColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: mainGreenColor
      )
    )
  );

  //* MODO OSCURO *//
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder(),
    prefixIconColor: mainGrayColor,
    suffixIconColor: mainGrayColor,
    floatingLabelStyle: TextStyle(color: lightColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: mainGreenColor
      )
    )
  );
}