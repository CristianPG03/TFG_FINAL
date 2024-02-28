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
  bool _isPasswordVisible = false;

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
                  userController.updateUserDetails2(context, imgUrl: userController.imgLink.isNotEmpty ? userController.imgLink : null);
                  // userController.updateUserDetails(context);
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
        body: SingleChildScrollView(
          child: Container(
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
                        //! AJUSTAR PARA QUE LA IMG OCUPE LO MISMO QUE EL FONDO
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
                          leading: Icon(
                            Icons.person,
                            color: mainGreenColor,
                            size: 40,
                          ),
                          title: TextFormField(
                            controller: userController.nameController,
                            style: const TextStyle(
                              fontSize: 18
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: const Text(
                                "Nombre",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              labelStyle: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: mainGreenColor,
                            size: 40
                          ),
                          title: TextFormField(
                            controller: userController.emailController,
                            style: const TextStyle(
                              fontSize: 18
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: const Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              labelStyle: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          leading: Icon(
                            Icons.info,
                            color: mainGreenColor,
                            size: 40
                          ),
                          title: TextFormField(
                            controller: userController.biographyController,
                            style: const TextStyle(
                              fontSize: 18
                            ),
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: const Text(
                                "Sobre mi",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              labelStyle: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: mainGreenColor,
                            size: 40,
                          ),
                          title: TextFormField(
                            controller: userController.passwordController,
                            style: const TextStyle(
                              fontSize: 18
                            ),
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: const Text(
                                "Contraseña",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              labelStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ]
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
      ),
    );
  }
}