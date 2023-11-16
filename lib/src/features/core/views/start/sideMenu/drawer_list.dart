import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/views/welcome/welcome.dart';
import 'package:tfg/src/features/core/views/profile/profile.dart';
import 'package:tfg/src/features/core/views/start/start.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          menuItem(1, "Ver Perfil", Icons.person,),
          menuItem(2, "Ajustes", Icons.settings,),
          menuItem(3, "Contacto", Icons.contacts,),
          menuItem(4, "Enviar destino", Icons.travel_explore,),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: miniSpace,
              horizontal: largeSpace
            ),
            child: Divider(thickness: 2,),
          ),
          menuItem(5, "Cerrar Sesión", Icons.logout,),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon,) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    
    return Material(
      child: InkWell(
        onTap: () {
          Get.back();
          setState(() {
            switch(id) {
              case 1: 
                Get.to(const Profile());
                break;
              case 2: 
                break;
              case 3: 
                Alert(
                  context: context,
                  type: AlertType.none,
                  style: const AlertStyle(
                    titleStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                    descStyle: TextStyle(
                      fontSize: 18
                    ),
                    isCloseButton: false
                  ),
                  title: "ENVIAR UN CORREO",
                  desc: "Póngase en contacto a través de un correo electrónico",
                  buttons: [
                    DialogButton(
                      onPressed: () async {
                        String? encodeQueryParameters(Map<String, String> params) {
                          return params.entries.map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                            .join('&');
                        }

                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: contactEmail,
                          query: encodeQueryParameters(<String, String>{
                            'subject': subjectEmail,
                          }),
                        );

                        try {
                          await launchUrl(emailUri);
                          //! CORREGIR LOS SEGUNDOS PERO QUE SE VEA BIEN
                          Get.showSnackbar(GetSnackBar(
                            message: "Correo enviado correctamente",
                            duration: const Duration(seconds: 8),
                            backgroundColor: mainGreenColor.withOpacity(0.5),
                            snackPosition: SnackPosition.TOP,
                          ));
                          Get.offAll(const Start());
                        } catch(e) {
                          Get.showSnackbar(GetSnackBar(
                            message: "Ha ocurrido un error. Inténtelo de nuevo",
                            duration: const Duration(seconds: 2),
                            backgroundColor: redColor.withOpacity(0.5),
                            snackPosition: SnackPosition.TOP,
                          ));
                        }
                      },
                      width: 220,
                      child: const Text(
                        "ESCRIBIR CORREO",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ).show();
                break;
              case 4:
              //! HACER UNA VISTA PARA ENVIAR POR CAMPOS LA INFO EN VEZ DE EN CORREO?
              
                Alert(
                  context: context,
                  type: AlertType.none,
                  style: const AlertStyle(
                    titleStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                    descStyle: TextStyle(
                      fontSize: 18
                    ),
                    isCloseButton: false
                  ),
                  title: "ENVIAR DESTINO",
                  desc: "Añada toda la información posible en el correo (Descripción, historia, fotos, coordenadas...). Dicho destino se añadirá en la siguiente actualización. Muchas gracias ^^",
                  buttons: [
                    DialogButton(
                      onPressed: () async {
                        String? encodeQueryParameters(Map<String, String> params) {
                          return params.entries.map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                            .join('&');
                        }

                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: contactEmail,
                          query: encodeQueryParameters(<String, String>{
                            'subject': subjectInfoEmail,
                          }),
                        );

                        try {
                          await launchUrl(emailUri);
                          //! CORREGIR LOS SEGUNDOS PERO QUE SE VEA BIEN
                          Get.showSnackbar(GetSnackBar(
                            message: "Correo enviado correctamente",
                            duration: const Duration(seconds: 8),
                            backgroundColor: mainGreenColor.withOpacity(0.5),
                            snackPosition: SnackPosition.TOP,
                          ));
                          Get.offAll(const Start());
                        } catch(e) {
                          Get.showSnackbar(GetSnackBar(
                            message: "Ha ocurrido un error. Inténtelo de nuevo",
                            duration: const Duration(seconds: 2),
                            backgroundColor: redColor.withOpacity(0.5),
                            snackPosition: SnackPosition.TOP,
                          ));
                        }
                      },
                      width: 220,
                      child: const Text(
                        "ESCRIBIR CORREO",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ).show();
                break;
              case 5: 
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Cerrar Sesión",
                  desc: "Estás seguro/a?",
                  buttons: [
                    DialogButton(
                      onPressed: () => Get.back(),
                      color: mainGrayColor,
                      child: Text(
                        "NO",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 18
                        ),
                      )
                    ),
                    DialogButton(
                      onPressed: () {
                        //* Cerrar Sesión
                        FirebaseAuth.instance.signOut()
                        .then((value) => Get.offAll(() => const Welcome()));
                      },
                      color: mainGreenColor,
                      child: Text(
                        "SI",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 18
                        ),
                      )
                    )
                  ]
                ).show();
                break;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: space),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 34,
                    color: id == 5 ? redColor : mainGreenColor //isDarkMode ? lightColor : darkColor,
                )
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: id == 5 ? redColor : isDarkMode ? lightColor : darkColor,
                    fontSize: 24
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}