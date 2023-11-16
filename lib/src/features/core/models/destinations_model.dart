import 'package:flutter/material.dart';
import 'package:tfg/src/constants/images.dart';

class DestinationModel {
  final String name;
  final String place;
  final List<String> image;
  final String description;
  final double latitude;
  final double longitude;
  final int indexProvince;
  bool isVisited;
  //final VoidCallback? onTap;

  DestinationModel(this.name, this.place, this.image, this.description, this.latitude, this.longitude, this.indexProvince, this.isVisited);

  static List<DestinationModel> listProvinces = [
    DestinationModel("A Coruña", "A Coruña", [imageMap, imageTourist, imageMap], "Provincia de A Coruña", 43.36700861624196, -8.406778960226438, 0, false),
    DestinationModel("Lugo", "Lugo", [imageTourist, imageMap, imageTourist], "Provincia de Lugo", 43.00952029901943, -7.5564144374643085, 1, false),
    DestinationModel("Ourense", "Ourense", [imageMap, imageTourist, imageMap], "Provincia de Ourense", 42.33556438893197, -7.863600915043332, 2, false),
    DestinationModel("Pontevedra", "Pontevedra", [imageTourist, imageMap, imageTourist], "Provincia de Pontevedra", 42.429677853956015, -8.644667322149948, 3, false),
  ];

  static List<DestinationModel> listDestinations = [
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Fervenzas do Barosa", "Pontevedra", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.55994147283614, -8.629436225004333, 3, false),
    DestinationModel("Fervenzas do Barosa", "Pontevedra", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.55994147283614, -8.629436225004333, 3, false),
    DestinationModel("Fervenzas do Barosa", "Pontevedra", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.55994147283614, -8.629436225004333, 3, false),
  ];

  static List<DestinationModel> listCorunha = [
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
    DestinationModel("Fervenza do Ézaro", "A Coruña", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.912870073064084, -9.11639832449214, 0, false),
  ];

  static List<DestinationModel> listLugo = [
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
    DestinationModel("Praia das Catedrais", "Lugo", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 43.55397393416972, -7.157929093185388, 1, false),
  ];

  static List<DestinationModel> listOurense = [
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
    DestinationModel("Pozas de Melón", "Ourense", [imageMap, imageTourist, imageMap], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.267224418421314, -8.214090094207709, 2, false),
  ];

  static List<DestinationModel> listPontevedra = [
    DestinationModel("Fervenzas do Barosa", "Pontevedra", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.55994147283614, -8.629436225004333, 3, false),
    DestinationModel("Fervenzas do Barosa", "Pontevedra", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.55994147283614, -8.629436225004333, 3, false),
    DestinationModel("Fervenzas do Barosa", "Pontevedra", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.55994147283614, -8.629436225004333, 3, false),
    DestinationModel("Fervenzas do Barosa", "Pontevedra", [imageTourist, imageMap, imageTourist], "Este destino es perfecto para visitar en un fin de semana ya que hay varios puntos de interés muy próximos unos de los otros", 42.55994147283614, -8.629436225004333, 3, false),
  ];
}