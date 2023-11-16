import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/constants/images.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/features/auth/models/user_model.dart';
import 'package:tfg/src/features/core/views/profile/picker_dialog.dart';
import 'package:tfg/src/utils/theme/theme.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

//! COMO RECARGAR PAGE PARA MOSTRAR LA INFORMACIÓN ACTUALIZADA DEL USUARIO CUANDO
//! SE MODIFICA EN EDITAR PERFIL?

class _ProfileState extends State<Profile> {
  final userController = Get.put(UserController());

  //! HACER PERFIL YA DIRECTAMENTE PARA PODER EDITAR (COMO EN VIDEO)
  //! Y LA OPCION DE LAS ESTADISTICAS EN OTRA PESTAÑA A PARTE DEL NAVBAR

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBarGeneric(
          appBarTitle: profileText,
          actions: [
            TextButton(
              onPressed: () async {
                if (userController.imgPath.isEmpty) {
                  userController.updateUserDetails(context); 
                } else {
                  await userController.uploadImage();
                  userController.updateUserDetails(context);
                }
              },
              child: Text(
                "Guardar",
                style: Theme.of(context).textTheme.bodyLarge,
              )
            )
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: userController.getUserDetails(currentUser!.uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  //* docs[0] ya que snapshot solo contendra un elemento (el currentUser)
                  var data = snapshot.data!.docs[0];
                  userController.nameController.text = data['name'];
                  userController.emailController.text = data['email'];
                  userController.biographyController.text = data['biography'];
                  userController.passwordController.text = data['password'];

                  return Column(
                    children: [
                      //! AJUSTAR PARA OCUPAR LOS MISMO QUE EL FONDO
                      Obx(() => CircleAvatar(
                          radius: 80,
                          backgroundColor: mainGreenColor,
                          child: Stack(
                            children: [
                              userController.imgPath.isEmpty && data['profileImage'] == ''
                              ? Image.asset(imageUserProfile)
                              : userController.imgPath.isNotEmpty
                                ? Image.file(
                                  File(userController.imgPath.value)
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(
                                  data['profileImage']
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: InkWell(
                                  onTap: () {
                                    Get.dialog(pickerDialog(context, userController));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: mainGreenColor,
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Divider(thickness: 1,),
                      const SizedBox(height: 20,),
                      ListTile(
                        leading: Icon(Icons.person, color: whiteColor,),
                        title: TextFormField(
                          controller: userController.nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: const Text("Nombre"),
                            labelStyle: Theme.of(context).textTheme.bodyLarge,
                            suffixIcon: Icon(Icons.edit, color: whiteColor,)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ListTile(
                        leading: Icon(Icons.email, color: whiteColor,),
                        title: TextFormField(
                          controller: userController.emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: const Text("Email"),
                            labelStyle: Theme.of(context).textTheme.bodyLarge,
                            suffixIcon: Icon(Icons.edit, color: whiteColor,)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ListTile(
                        leading: Icon(Icons.info, color: whiteColor,),
                        title: TextFormField(
                          controller: userController.biographyController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: const Text("Sobre mi"),
                            labelStyle: Theme.of(context).textTheme.bodyLarge,
                            suffixIcon: Icon(Icons.edit, color: whiteColor,)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      //! OCULTAR POR DEFECTO LA CONTRASEÑA
                      ListTile(
                        leading: Icon(Icons.lock, color: whiteColor,),
                        title: TextFormField(
                          controller: userController.passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: const Text("Contraseña"),
                            labelStyle: Theme.of(context).textTheme.bodyLarge,
                            suffixIcon: Icon(Icons.edit, color: whiteColor,)
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  //! MOSTRAR OTRO MENSAJE DE ERROR, UN SNACKBAR
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("Algo ha salido mal. Inténtalo de nuevo"),
                  );
                }
              } else {
                return const Center(
                  child: LoadingAnimation(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}