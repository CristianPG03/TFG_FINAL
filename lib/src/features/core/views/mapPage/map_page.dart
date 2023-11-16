import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/map_const.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // LatLng? currentPosition;
  // LatLng currentPosition = const LatLng(43.36700861624196, -8.406778960226438);

  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  
  CameraPosition initialGoogleCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664,-122.085749655962),
    zoom: 15
  );
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialGoogleCameraPosition,
              mapType: MapType.normal,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController mapController) {
                controllerGoogleMap = mapController;
                googleMapCompleterController.complete(controllerGoogleMap);
              },
            ),
          ],
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.map),
        onPressed: () {
          getCurrentLocation(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: currentPosition == null
        ? const Center(child: LoadingAnimation(),)
        : FlutterMap(
        options: MapOptions(
          initialCenter: currentPosition!,
          minZoom: 5,
          maxZoom: 25,
          initialZoom: 15 
        ),
        children: [
          TileLayer(
            // urlTemplate: "https://api.mapbox.com/styles/v1/cpgomez18/clozpg860017p01qm3hkx21qu.html?title=view&access_token=pk.eyJ1IjoiY3Bnb21lejE4IiwiYSI6ImNsb3pucnVvNzAyajcybHF2N242c2dxZmwifQ.ZK8pMthYJmklP4c-Kg7Lfw&zoomwheel=true&fresh=true#11.37/42.8239/-8.5015",
            urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
            additionalOptions: const {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': "mapbox/streets-v12"
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: currentPosition!,
                child: Icon(
                  Icons.location_on,
                  color: redColor,
                  size: 30,
                )
              )
            ]
          )
        ]
      )
    );
  }*/

  /*@override
  void initState() {
    getCurrentLocation(context);
    super.initState();
  }

  Future<Position> determinePosition(context) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      while(permission == LocationPermission.denied) {
        VxToast.show(context, msg: "Para usar la app es necesario permitir la localización");
        permission = await Geolocator.requestPermission();
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation(context) async {
    Position position = await determinePosition(context);
    
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      print(currentPosition);
    });
    
    print(position.latitude);
    print(position.longitude);
  }*/
}