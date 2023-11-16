import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/features/core/views/listDestinations/infoDestination/image_slider.dart';

class ImageSliderCardWidget extends StatefulWidget {
    ImageSliderCardWidget({
    super.key,
    required this.destinationModel,
    required this.imageIndex
  });

  DestinationModel destinationModel;
  int imageIndex;

  @override
  State<ImageSliderCardWidget> createState() => _ImageSliderCardWidgetState();
}

class _ImageSliderCardWidgetState extends State<ImageSliderCardWidget> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    List<String> listImages = widget.destinationModel.image;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultSize),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(listImages[widget.imageIndex]),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultSize),
          border: Border.all(
            color: isDarkMode ? lightColor : darkColor,
            width: 2
          ),
        ),
      ),
    );
  }
}