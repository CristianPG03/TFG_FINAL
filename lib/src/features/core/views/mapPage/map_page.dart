// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tfg/src/constants/google_const.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

//! NECESARIA O ELIMINAR?

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  late GoogleMapController mapController;
  List<Marker> markers = [];

  LatLng? _currentP = null;
  PointLatLng _originPoly = PointLatLng(37.42796133580664,-122.085749655962);
  PointLatLng _destinationPoly = PointLatLng(37.40,-122.08);
  LatLng _destination = LatLng(37.40,-122.08);

  Map<PolylineId, Polyline> polylines = {};

  CameraPosition initialGoogleCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664,-122.085749655962),
    zoom: 10
  );

  @override
  void initState() {
    super.initState();
    getLocationUdates().then((_) => {
      getPolylinesPoints().then((coordinates) => {
        generatePolylineFromPoints(coordinates)
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await launchUrl(Uri.parse(
              'google.navigation:q=37,-122&key=$googleMapAndroidKey'
            ));
          },
          child: const Icon(Icons.map),
        ),
        body: _currentP == null
        ? const Center(child: LoadingAnimation(),)
        : GoogleMap(
          // onMapCreated: ((GoogleMapController controller) =>_mapController.complete(controller)),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: initialGoogleCameraPosition,
          mapType: MapType.normal,
          myLocationEnabled: true,
          markers: Set<Marker>.from(markers),
          // markers: {
          //   Marker(
          //     markerId: MarkerId("posición actual"),
          //     icon: BitmapDescriptor.defaultMarker,
          //     position: _currentP!
          //   ),
          //   Marker(
          //     markerId: MarkerId("posición destino"),
          //     icon: BitmapDescriptor.defaultMarker,
          //     position: _destination
          //   ),
          // },
          polylines: Set<Polyline>.of(polylines.values),
        ),
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;

    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);

    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();

    if(_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      //! HACER ALGO EN EL ELSE?
      return;
    }

    _permissionGranted = await _locationController.hasPermission();

    if(_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();

      if(_permissionGranted != PermissionStatus.granted) {
        //! HACER ALGO AQUI, UN BUCLE INFINITO O ALGO PARA QUE LO ACEPTE SI O SI
        return;
      }
    }

    //! COMPROBAR QUE LA CAMARA SIGUE AL MARKER DEL USER MOVIENDOSE!!!!!!!!!!!!!

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if(currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinesPoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapAndroidKey,
      _originPoly,
      _destinationPoly,
      travelMode: TravelMode.driving
    );

    if(result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      //! CAMBIARLO POR UN TOAST
      print(result.errorMessage);
    }

    return polylineCoordinates;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 8
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<void> showNearbyRestaurants(double latitude, double longitude) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=500&type=restaurant&key=$googleMapAndroidKey';

    try {
      // Realizar una solicitud HTTP para obtener datos de lugares cercanos
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Analizar la respuesta JSON de la API
        var data = json.decode(response.body);

        // Obtener resultados de lugares cercanos
        List<dynamic> results = data['results'];

        // Crear marcadores para cada lugar cercano
        List<Marker> newMarkers = results.map((result) {
          Map<String, dynamic> location = result['geometry']['location'];
          double lat = location['lat'];
          double lng = location['lng'];

          return Marker(
            markerId: MarkerId(result['place_id']),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: result['name']),
          );
        }).toList();

        // Actualizar el estado para mostrar los nuevos marcadores en el mapa
        if (mounted) {
          setState(() {
            markers = newMarkers;
          });
        }
      } else {
        print('Error al obtener lugares cercanos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  //! SOLICITAR PERMISOS DE UBICACION
  // Future<void> _requestLocationPermission() async {
  //   var status = await Permission.location.request();
  //   if (status == PermissionStatus.granted) {
  //     print("Permiso de ubicación concedido");
  //   } else {
  //     _requestLocationPermission();
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _requestLocationPermission();
  // }

  // LatLng? currentPosition;
  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider<MapPageController>(
  //     create: (_) {
  //       final controller = MapPageController();

  //       //! PODEMOS USAR EL CONTEXTO PARA NAVEGAR A UNA PAGINA ESPECIFICA SI LE PASAMOS UN NAVEGADOR
  //       controller.onMarkerTap.listen((id) {
  //         print("MARKER ID: $id");
  //       });

  //       return controller;
  //     },
  //     child: SafeArea(
  //       child: Scaffold(
  //         floatingActionButton: FloatingActionButton(
  //           onPressed: () {
              
  //           },
  //           child: const Icon(Icons.map),
  //         ),
  //         body: Stack(
  //           children: [
  //             Consumer<MapPageController>(
  //               builder: (_, controller, __) => GoogleMap(
  //                 markers: controller.markers,
  //                 initialCameraPosition: controller.initialGoogleCameraPosition,
  //                 mapType: MapType.normal,
  //                 myLocationEnabled: true,
  //                 // onMapCreated: (GoogleMapController mapController) {
  //                 //   controllerGoogleMap = mapController;
  //                 //   googleMapCompleterController.complete(controllerGoogleMap);
  //                 // },
  //                 onTap: controller.onTap,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
