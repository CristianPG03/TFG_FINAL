import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/google_const.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/features/core/views/listDestinations/infoDestination/image_slider.dart';
import 'package:tfg/src/features/core/views/mapPage/navigation_screen.dart';
import 'package:tfg/src/widgets/card/destination_card_widget.dart';
import 'package:tfg/src/widgets/card/image_slider_card.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationBottomBar extends StatefulWidget {
  DestinationBottomBar({super.key, required this.destination});
  
  final QueryDocumentSnapshot<Object?> destination;

  @override
  State<DestinationBottomBar> createState() => _DestinationBottomBarState();
}

class _DestinationBottomBarState extends State<DestinationBottomBar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Container(
      height: size.height/1.5,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? darkColor : whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        )
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.destination["place"],
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  widget.destination["province"],
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Divider(
                  height: 30,
                  thickness: 2,
                ),
                Text(
                  widget.destination["description"],
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      var lat = widget.destination["latitude"];
                      var lng = widget.destination["longitude"];
                      //Get.to(NavigationScreen(lat: double.parse("23"), lng: double.parse("72")));
                      int radius = 5000;

                      //*BOTON NAVEGACION
                      await launchUrl(Uri.parse(
                        'google.navigation:q=$lat,$lng&radius=$radius&key=$googleMapAndroidKey'
                      ));
                    },
                    child: const Text(
                      "Ver en el mapa",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 30,),
                Text(
                  "Imágenes",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20,),
                // CarouselSlider.builder(
                //   itemCount: widget.destination["images"].length,
                //   itemBuilder: (context, index, id) {
                //     return Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(defaultSize),
                //         image: DecorationImage(
                //           fit: BoxFit.fill,
                //           image: NetworkImage(widget.destination["images"]["img${index+1}"]),
                //         ),
                //       ),
                //       child: Container(
                //         width: MediaQuery.of(context).size.width,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(defaultSize),
                //           border: Border.all(
                //             color: isDarkMode ? lightColor : darkColor,
                //             width: 2
                //           ),
                //         ),
                //       ),
                //     );

                //   //   return GestureDetector(
                //   //     onTap: () {
                //   //       Navigator.push(
                //   //         context,
                //   //         MaterialPageRoute(
                //   //           builder: (context) => _FullScreenImage(
                //   //             imageURL: widget.destination["images"]["img${index+1}"],
                //   //           ),
                //   //         ),
                //   //       );
                //   //     },
                //   //     child: ImageSliderCardWidget(
                //   //       destinationModel: widget.destinationModel,
                //   //       imageIndex: index,
                //   //     ),
                //   //   );
                //   },
                //   options: CarouselOptions(
                //     height: 200,
                //     aspectRatio: 16 / 9,
                //     enableInfiniteScroll: true,
                //     enlargeCenterPage: true,
                //     autoPlay: true,
                //     autoPlayAnimationDuration: const Duration(seconds: 4),
                //   ),
                // ),
                CarouselSlider.builder(
                  itemCount: widget.destination["images"].length,
                  itemBuilder: (context, index, id) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _FullScreenImage(
                              imageURL: widget.destination["images"]["img${index + 1}"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultSize),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.destination["images"]["img${index + 1}"]),
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defaultSize),
                            border: Border.all(
                              color: isDarkMode ? lightColor : darkColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 4),
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FullScreenImage extends StatelessWidget {
  final String imageURL;

  const _FullScreenImage({required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Hero(
          tag: imageURL,
          child: PhotoView(
            imageProvider: NetworkImage(imageURL),
          ),
        ),
      ),
    );
  }
}