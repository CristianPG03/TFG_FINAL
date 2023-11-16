import 'package:flutter/material.dart';

class TextFieldInputWidget extends StatelessWidget {
  final bool isPass;
  final String labelText;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  //final TextEditingController controller;
  final TextInputType keyboard;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const TextFieldInputWidget(
      {super.key,
      this.isPass = false,
      required this.labelText,
      required this.prefixIcon,
      this.suffixIcon,
      //required this.controller,
      required this.keyboard,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        label: Text(labelText),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboard,
      obscureText: isPass,
      enableSuggestions: !isPass,
      autocorrect: false,
    );
  }
}