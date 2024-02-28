import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tfg/src/constants/firebase_const.dart';

class DestinationController extends GetxController {
  static DestinationController get instance => Get.find();

  //* Obtener destinos de cada provincia
  Future<QuerySnapshot> getDestinations(String province) async {
    return await firebaseFirestore.collection(province).get();
  }

  //! SE USA ESTA FUNCION?
  //* Obtener imágenes de destinos Ourense
  getImagesDestinations(String province) async {
    return await firebaseFirestore.collection(province).doc().collection('images').snapshots();
  }
}