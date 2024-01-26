import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:tfg/src/constants/colors.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:tfg/src/constants/google_const.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationScreen extends StatefulWidget {
  final double lat;
  final double lng;

  const NavigationScreen({super.key, required this.lat, required this.lng});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  LatLng curLocation = LatLng(37.4221, -122.0853);
  StreamSubscription<loc.LocationData?>? locationSubscription;

  @override
  void initState() {
    super.initState();
    getNavigation();
    addMarker();
  }

  // @override
  // void dispose() {
  //   locationSubscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sourcePosition == null
        ? const Center(child: LoadingAnimation())
        : Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(polylines.values),
              initialCameraPosition: CameraPosition(
                target: curLocation,
                zoom: 15
              ),
              markers: {sourcePosition!, destinationPosition!},
              onTap: (latLng) {
                print(latLng);
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              top: 30,
              left: 15,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back),
              )
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: blueColor
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      await launchUrl(Uri.parse(
                        'google.navigation:q=${widget.lat},${widget.lng}&key=$googleMapAndroidKey'
                      ));
                    },
                    icon: Icon(
                      Icons.navigation_outlined,
                      color: whiteColor,
                    )
                  ),
                ),
              )
            )
          ],
        )
    );
  }

  getNavigation() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    _serviceEnabled = await location.serviceEnabled();

    if(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if(!_serviceEnabled) {
        //! AÑADIR ALGO PARA QUE SI O SI ACEPTE
        return;
      }
    }

    _permissionGranted = await location.hasPermission();

    if(_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if(_permissionGranted != PermissionStatus.granted) {
        //! AÑADIR ALGO PARA QUE SI O SI ACEPTE
        return;
      }
    }

    if(_permissionGranted == PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      curLocation = LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription = location.onLocationChanged.listen((LocationData currentLocation) {
        controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
            zoom: 15
          ))
        );
        
        if(mounted) {
          controller?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));

          setState(() {
            curLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
            sourcePosition = Marker(
              markerId: MarkerId(currentLocation.toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(
                title: double.parse(
                  (getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2))).toString()
              ),
              onTap: () {
                print("Marker tapped");
              }
            );
          });
          getDirections(LatLng(widget.lat, widget.lng));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapAndroidKey,
      PointLatLng(curLocation.latitude, curLocation.longitude),
      PointLatLng(dst.latitude, dst.longitude),
      travelMode: TravelMode.driving
    );

    if(result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      //! CAMBIAR POR TOAST
      print(result.errorMessage);
    }
    addPolyline(polylineCoordinates);
  }

  addPolyline(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: blueColor,
      points: polylineCoordinates,
      width: 3
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lng1, lat2, lng2) {
    var p = 0.017453292519943295; //Grados a radianes
    var c = cos;
    var a = 0.5 - c((lat2-lat1)*p) / 2 + c(lat1*p) * c(lat2*p) * (1-c((lng2-lng1)*p)) / 2;

    //! SABER DE DONDE VIENE EL 12742
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destPosition) {
    return calculateDistance(
      curLocation.latitude,
      curLocation.longitude,
      destPosition.latitude,
      destPosition.longitude
    );
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: MarkerId('origen'),
        position: curLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
      );
      destinationPosition = Marker(
        markerId: MarkerId('destino'),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)
      );
    });
  }
}