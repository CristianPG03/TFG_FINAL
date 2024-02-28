import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toCamelCase() {
    return split(' ').map((word) => word.capitalizeFirstLetter()).join('');
  }

  String capitalizeAll() {
    return toUpperCase();
  }

  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  Widget toColoredText(Color color) {
    return Text(
      this,
      style: TextStyle(
        color: color
      ),
    );
  }
}