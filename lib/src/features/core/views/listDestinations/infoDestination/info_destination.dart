import 'package:flutter/material.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';
import 'package:tfg/src/widgets/destinationBottomBar/destination_bottom_bar.dart';

class InfoDestination extends StatelessWidget {
  final DestinationModel destination;
  const InfoDestination({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(destination.image.first),
          fit: BoxFit.cover,
          opacity: 0.7
        )
      ),
      child: Scaffold(
        appBar: AppBarGeneric(appBarTitle: destination.name),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: DestinationBottomBar(destinationModel: destination),
      ),
    );
  }
}