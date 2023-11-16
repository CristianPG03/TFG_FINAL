import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/images.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/controllers/log_in_controller.dart';
import 'package:tfg/src/widgets/textFieldInput/text_field_input_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

//! CAMBIAR CORREO QUE LLEGA AL CLICKAR EN ENVIAR

class _ForgotPasswordState extends State<ForgotPassword> {
  final logInController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: mainGreenColor,
              size: defaultSize,
            )
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultSize,),
                Column(
                  children: [
                    Text(
                      forgotYourPassword,
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Image(
                      image: AssetImage(imageSendEmail),
                      width: 250,
                    ),
                  ],
                ),
                const SizedBox(height: defaultSize,),
                TextFieldInputWidget(
                  controller: logInController.forgotPasswordEmail,
                  labelText: email,
                  prefixIcon: const Icon(Icons.email),
                  keyboard: TextInputType.emailAddress
                ),
                const SizedBox(height: defaultSize,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      logInController.forgotPasswordReset(context);
                    },
                    child: Text(send.toUpperCase())
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    logInController.dispose();
    super.dispose();
  }
}