import 'package:flutter/material.dart';
import 'package:tfg/src/constants/images.dart';

//! NECESARIO??

class NewsModel {
  final String title;
  //final String content;
  final String author;
  final String image;
  final String date;
  final VoidCallback? onTap;

  NewsModel(this.title, this.author, this.image, this.date, this.onTap);

  static List<NewsModel> listNews = [
    NewsModel("Noticia 1", "Nombre 1", imageGameOver, "15-05-2001", null),
    NewsModel("Noticia 2 con un titulo más largo", "Nombre 2", imageTourist, "02-03-1998", null),
    NewsModel("Noticia 3 con un titulo muchísimo más largo", "Nombre 3", imageGameOver, "11-11-2022", null),
    NewsModel("Noticia 4", "Nombre 4", imageTourist, "30-09-1856", null),
    NewsModel("Noticia 5", "Nombre 5", imageGameOver, "04-10-2019", null),
  ];
}