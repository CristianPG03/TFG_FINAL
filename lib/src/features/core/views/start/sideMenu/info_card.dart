import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/constants/images.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({
    super.key,
    required this.email,
    this.profileImage
  });
  
  final String email;
  final String? profileImage;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  var controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getUserDetails(currentUser!.uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasData) {
            var data = snapshot.data!.docs[0];

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 32,
                child: ClipOval(
                  child: controller.imgPath.isEmpty && data['profileImage'] == ''
                    ? Image.asset(imageUserProfile)
                    : controller.imgPath.isNotEmpty
                      ? Image.file(
                        File(controller.imgPath.value)
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.network(
                        data['profileImage']
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                ),
              ),
              title: Text(
                controller.nameController.text,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            );
          } else if (snapshot.hasError) {
            //! MOSTRAR OTRO MENSAJE DE ERROR, UN VxToast
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
      }
    );
  }
}