import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/firebase_const.dart';

class NewsController extends GetxController {
  static NewsController get instance => Get.find();

  //* Obtener noticias
  Future<QuerySnapshot> getNews() async {
    return await firebaseFirestore.collection(collectionNews).get();
  }
}