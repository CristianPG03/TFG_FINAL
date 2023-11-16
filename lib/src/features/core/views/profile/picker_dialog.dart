import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg/src/constants/colors.dart';

Widget pickerDialog(context, controller) {
  var listTitle = ["Cámara", "Galería", "Cancelar"];
  var icons = [Icons.camera_alt_rounded, Icons.photo_size_select_actual_rounded, Icons.cancel];

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16)
    ),
    child: Container(
      padding: const EdgeInsets.all(12),
      color: darkColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Selecciona un método",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: whiteColor
            ),
          ),
          const SizedBox(height: 10,),
          Divider(
            color: mainGrayColor,
            thickness: 2
          ),
          const SizedBox(height: 10,),
          ListView(
            shrinkWrap: true,
            children: List.generate(3, (index) => ListTile(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.back();
                    controller.pickImage(context, ImageSource.camera);
                    break;
                  case 1:
                    Get.back();
                    controller.pickImage(context, ImageSource.gallery);
                    break;
                  case 2:
                    Get.back();
                    break;
                  default:
                }
              },
              leading: Icon(icons[index], color: whiteColor,),
              title: Text(listTitle[index]),
              titleTextStyle: TextStyle(
                fontSize: 24,
                color: whiteColor
              ),
            ))
          )
        ],
      ),
    ),
  );
}