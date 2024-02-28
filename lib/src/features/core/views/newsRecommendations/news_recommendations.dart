import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/core/controllers/destination_controller.dart';
import 'package:tfg/src/features/core/controllers/news_controller.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/features/core/models/news_model.dart';
import 'package:tfg/src/features/core/views/listDestinations/infoDestination/info_destination.dart';
import 'package:tfg/src/widgets/card/destination_card_widget.dart';
import 'package:tfg/src/widgets/card/news_card_widget.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';


class NewsRecommendations extends StatefulWidget {
  const NewsRecommendations({super.key});

  @override
  State<NewsRecommendations> createState() => _NewsRecommendationsState();
}

class _NewsRecommendationsState extends State<NewsRecommendations> {
  final destinationController = Get.put(DestinationController());
  final newsController = Get.put(NewsController());
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //final brightness = MediaQuery.of(context).platformBrightness;
    //final isDarkMode = brightness == Brightness.dark;

    final listNews = NewsModel.listNews;
    // final listDestinations = DestinationModel.listDestinations;

    var listProvince = ["coruña", "pontevedra", "lugo", "ourense"];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      //color: isDarkMode ? darkColor : lightColor,
      width: size.width,
      height: size.height,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              newsText,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            FutureBuilder(
              future: newsController.getNews(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index, id) {
                        var data = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () async{
                            await FlutterWebBrowser.openWebPage(
                              url: data["url"],
                            );
                          },
                          child: NewsCardWidget(news: data,)
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 16/9,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 3)      
                      )
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
            Divider(
              color: mainGrayColor,
              indent: space,
              thickness: 2,
              endIndent: space,
            ),
            Text(
              recommendedDestinations,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            FutureBuilder(
              future: destinationController.getDestinations(_getRandomProvince(listProvince)),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index, id) {
                        var data = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(InfoDestination(destination: data));
                          },
                          child: DestinationCardWidget(destination: data)
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 16/9,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 3)      
                      )
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
            )
          ],
        )
      ),
    );
  }

  String _getRandomProvince(List list) {
    // var listProvince = ["coruña", "pontevedra", "lugo", "ourense"];
    return list[_random.nextInt(list.length)];
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }
}