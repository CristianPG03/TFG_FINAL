import 'package:flutter/material.dart';
import 'package:tfg/src/widgets/themes/elevated_button_theme_widget.dart';
import 'package:tfg/src/widgets/themes/input_decoration_theme_widget.dart';
import 'package:tfg/src/widgets/themes/outlined_button_theme_widget.dart';
import 'package:tfg/src/widgets/themes/themes_widget.dart';

class AppTheme {
  const AppTheme._();

  //* MODO CLARO *//
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextThemeWidget.lightTextTheme,
    outlinedButtonTheme: OutlinedButtonThemeWidget.lightOutlinedButtonTheme,
    elevatedButtonTheme: ElevatedButtonThemeWidget.lightElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldThemeWidget.lightInputDecorationTheme,
  );

  //* MODO OSCURO *//
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextThemeWidget.darkTextTheme,
    outlinedButtonTheme: OutlinedButtonThemeWidget.darkOutlinedButtonTheme,
    elevatedButtonTheme: ElevatedButtonThemeWidget.darkElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldThemeWidget.darkInputDecorationTheme,
  );
}