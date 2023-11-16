import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';

class ImageSlider extends StatefulWidget {
  ImageSlider({super.key, required this.destination, required this.currentImage});
  final DestinationModel destination;
  int currentImage;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentImage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: widget.destination.image.length,
            pageController: _pageController,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(widget.destination.image[index]),
                initialScale: PhotoViewComputedScale.contained * 0.8,
              );
            },
            onPageChanged: (index) {
              widget.currentImage = index;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 30.0, right: 12.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);  
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
          )
        ],
      )
    );
  }
}