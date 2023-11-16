import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/features/core/models/news_model.dart';
import 'package:tfg/src/widgets/card/destination_card_widget.dart';
import 'package:tfg/src/widgets/card/news_card_widget.dart';

class NewsRecommendations extends StatefulWidget {
  const NewsRecommendations({super.key});

  @override
  State<NewsRecommendations> createState() => _NewsRecommendationsState();
}

class _NewsRecommendationsState extends State<NewsRecommendations> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //final brightness = MediaQuery.of(context).platformBrightness;
    //final isDarkMode = brightness == Brightness.dark;

    final listNews = NewsModel.listNews;
    final listDestinations = DestinationModel.listDestinations;

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
            /*SizedBox(
              height: searchBarHeight,
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search, size: defaultSize,),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchDestiny,
                  hintStyle: Theme.of(context).textTheme.labelMedium
                ),
              ),
            ),*/

            //! CORREGIR POSICIONAMIENTO DEL CARD Y PROBAR GETWIDGET PACKAGE
            /*VxSwiper.builder(
              itemCount: listNews.length,
              itemBuilder: (context, index) => 
                NewsCardWidget(newsModel: listNews[index])

                /*return GenericCardWidget(
                  title: listNews[index].title,
                  info: listNews[index].info,
                  image: listNews[index].image,
                  date: listNews[index].date,
                );*/
                /*return GFListTile(
                  titleText: listNews[index].title,
                  subTitleText: listNews[index].content,
                  color: mainGreenColor,
                );*/
            ),*/

            //! DOCTOR CODE - FLUTTER NEWS APP UI TUTORIAL:
            //! DESIGN AND BUILD A STUNNING NEWS APP INTERFACE - 17:23
            //! AJUSTAR COLORES DEL TEXTO CUANDO HAGA LA LLAMADA DE LA API/JSON
            Text(
              newsText,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            CarouselSlider.builder(
              itemCount: listNews.length,
              itemBuilder: (context, index, id) {
                return NewsCardWidget(newsModel: listNews[index]);
              },
              options: CarouselOptions(
                aspectRatio: 16/9,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 3)      
              )
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
            CarouselSlider.builder(
              itemCount: listDestinations.length,
              itemBuilder: (context, index, id) {
                return DestinationCardWidget(destinationModel: listDestinations[index]);
              },
              options: CarouselOptions(
                aspectRatio: 16/9,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 3)      
              )
            ),
          ],
        )
      ),
    );
  }
}