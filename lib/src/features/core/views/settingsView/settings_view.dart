import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/features/auth/views/welcome/welcome.dart';
import 'package:tfg/src/features/core/views/start/start.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final userController = Get.put(UserController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(appBarTitle: "Ajustes"),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text(
              'Idioma de la aplicación',
              style: TextStyle(
                fontSize: 20
              ),
            ),
            onTap: () {
              // Agrega aquí la lógica para cambiar el idioma de la aplicación
              // Puedes abrir un diálogo o navegar a una nueva pantalla para seleccionar el idioma
            },
          ),
          Divider(
              color: mainGrayColor,
              indent: space,
              thickness: 2,
              endIndent: space,
            ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text(
              'Eliminar cuenta',
              style: TextStyle(
                fontSize: 20
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('¿Estás seguro de que deseas eliminar tu cuenta?'),
                  content: Text('Esta acción no se puede deshacer.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        userController.deleteUser(context).whenComplete(() {
                          Get.offAll(const Welcome());
                        });
                      },
                      child: Text('Eliminar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}