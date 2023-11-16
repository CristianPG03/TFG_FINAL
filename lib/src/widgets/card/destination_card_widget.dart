import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';

class DestinationCardWidget extends StatefulWidget {
    DestinationCardWidget({
    super.key,
    required this.destinationModel
  });

  DestinationModel destinationModel;

  @override
  State<DestinationCardWidget> createState() => _DestinationCardWidgetState();
}

class _DestinationCardWidgetState extends State<DestinationCardWidget> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultSize),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(widget.destinationModel.image.first),
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
          gradient: const LinearGradient(
            colors: [Colors.transparent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        padding: const EdgeInsets.symmetric(horizontal: space),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.destinationModel.name,
              style: TextStyle(
                color: whiteColor,
                fontSize: defaultSize - 10,
                fontWeight: FontWeight.bold
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.destinationModel.place,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.destinationModel.description,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}