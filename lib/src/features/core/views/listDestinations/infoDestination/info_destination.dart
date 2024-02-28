import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tfg/src/extensions/string_extension.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';
import 'package:tfg/src/widgets/destinationBottomBar/destination_bottom_bar.dart';

class InfoDestination extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> destination;
  const InfoDestination({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          //! AJUSTAR IMAGEN AL FONDO Y TITULO
          image: NetworkImage(destination["images"]["img1"]),
          fit: BoxFit.cover,
          opacity: 1
        )
      ),
      child: Scaffold(
        appBar: AppBarGeneric(appBarTitle: destination["place"]),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: DestinationBottomBar(destination: destination),
      ),
    );
  }
}