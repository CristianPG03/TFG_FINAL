import 'package:flutter/material.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

//! HACER QUE CARGUE MÁS RAPIDO LA VISTA?
class Chores extends StatelessWidget {
  const Chores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _getUserLocation(),
      builder: (BuildContext context, AsyncSnapshot<Position?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingAnimation());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userLocation = snapshot.data!;
          final lat = userLocation.latitude;
          final lng = userLocation.longitude;
          const radius = 2000;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: SafeArea(
                bottom: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      choresText,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10,),
                    _buildListItem(
                      context,
                      Icon(Icons.hiking),
                      'Actividades',
                      Colors.red,
                      () async {
                        await launchUrl(Uri.parse(
                          'https://www.google.com/maps/search/activities/@$lat,$lng,$radius'
                        ));
                      }
                     ),
                    const SizedBox(height: 10,),
                    _buildListItem(context, Icon(Icons.hotel), 'Hoteles', Colors.blue, () async {
                      await launchUrl(Uri.parse(
                        'https://www.google.com/maps/search/hotels/@$lat,$lng,$radius'
                      ));
                    }),
                    const SizedBox(height: 10,),
                    _buildListItem(context, Icon(Icons.restaurant), 'Restaurantes', Colors.brown, () async {
                      await launchUrl(Uri.parse(
                        'https://www.google.com/maps/search/restaurants/@$lat,$lng,$radius'
                      ));
                    }),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  //! HACE VARIAS VECES LA PREGUNTA DE PERMISOS? QUE PASA SI NO ESTAN ACTIVADOS?
  Future<Position?> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Localización del usuario desactivada';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Permisos de localización denegados';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Permisos de localización permanentemente denegados, no es posible acceder a la ubicación';
    }

    return await Geolocator.getCurrentPosition();
  }

  Widget _buildListItem(BuildContext context, Icon icon, String title, Color color, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 7,
          shadowColor: Colors.black,
          color: color,
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
