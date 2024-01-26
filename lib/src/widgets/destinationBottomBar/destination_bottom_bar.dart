import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/google_const.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/features/core/views/listDestinations/infoDestination/image_slider.dart';
import 'package:tfg/src/features/core/views/mapPage/navigation_screen.dart';
import 'package:tfg/src/widgets/card/destination_card_widget.dart';
import 'package:tfg/src/widgets/card/image_slider_card.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationBottomBar extends StatefulWidget {
  DestinationBottomBar({
    super.key,
    required this.destinationModel
  });
  
  DestinationModel destinationModel;

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
                  widget.destinationModel.name,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  widget.destinationModel.place,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Divider(
                  height: 30,
                  thickness: 2,
                ),
                Text(
                  widget.destinationModel.description,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      var lat = widget.destinationModel.latitude;
                      var lng = widget.destinationModel.longitude;
                      //Get.to(NavigationScreen(lat: double.parse("23"), lng: double.parse("72")));
                      int radius = 5000;

                      //! CONSEGUIR HACER PARA MOSTRAR LOS RESTAURANTES/HOTELES ETC CERCANOS A UBICACION

                      // await launchUrl(Uri.parse(
                      //   'google.navigation:q=$lat,$lng&radius=$radius&type=restaurants&key=$googleMapAndroidKey'
                      // ));
                      await launchUrl(Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&type=restaurant&key=$googleMapAndroidKey'));
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
                //! CAMBIAR CAROUSEL POR SLIDER PARA PODER CLICKAR Y AMPLIAR?
                //! SEGUIR PROBANDO CON EL CAROUSEL?
                CarouselSlider.builder(
                  itemCount: widget.destinationModel.image.length,
                  itemBuilder: (context, index, id) {
                    return ImageSliderCardWidget(
                      destinationModel: widget.destinationModel,
                      imageIndex: index,
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16/9,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 4)     
                  )
                ),
                // Container(
                //   height: size.height/2,
                //   width: size.width,
                //   color: blueColor,
                //   child: PhotoViewGallery.builder(
                //     customSize: Size.fromHeight(size.height/3),
                //     itemCount: widget.destinationModel.image.length,
                //     builder: (context, index) {
                //       return PhotoViewGalleryPageOptions(
                //         imageProvider: AssetImage(widget.destinationModel.image[index]),
                //         initialScale: PhotoViewComputedScale.contained*0.8,
                //       );
                //     },
                //   ),
                // ),
                //! ERROR DE TAMAÑO POR QUE??
                // Container(
                //   height: size.height/2,
                //   width: size.width,
                //   child: ListView.builder(
                //     itemCount: widget.destinationModel.image.length,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         color: blueColor,
                //         // child: Text("${widget.destinationModel.description[index]}"),
                //         height: 100,
                //         width: size.width,
                //         child: Image.asset(
                //           widget.destinationModel.image[index]),
                //       );
                //     },
                //   ),
                // ),
                // Container(
                //   height: size.height/2,
                //   width: size.width,
                //   child: PhotoView(
                //     imageProvider: AssetImage(widget.destinationModel.image[0]),
                //   ),
                // ),
                const SizedBox(height: 20,),
              ],
            ),
          )
        ],
      ),
    );
  }
}