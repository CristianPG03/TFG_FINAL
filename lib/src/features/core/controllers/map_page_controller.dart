import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageController extends ChangeNotifier {
  //* Instancia de la clase para poder acceder desde otro fichero
  static MapPageController get instance => Get.find();

  //* Se crea un marker de tipo map para usarlo en los mapas
  final Map<MarkerId, Marker> _markers = {};

  //* Se crea un get para obtener el valor del marker
  Set<Marker> get markers => _markers.values.toSet();

  //* Se crea un controller del marker para poder "actuar" sobre él
  final _markerController = StreamController<String>.broadcast();

  //* Y un método para cuando se hace click sobre un marker
  Stream<String> get onMarkerTap => _markerController.stream;

  //* Posición inicial de prueba
  CameraPosition initialGoogleCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664,-122.085749655962),
    zoom: 15
  );

  void onTap(LatLng position) {
    //* Para que el ID sea único, hago que sea el mismo que el número de markers colocados
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final marker = Marker(
      markerId: markerId,
      position: position,
      draggable: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      onTap: () {
        _markerController.sink.add(id);
      },
      onDragEnd: (newPosition) {
        print("Nueva posicion: $newPosition");
      },
    );

    //* Añadimos al map de makers un marker con markerId como MarkerId y marker como Marker
    _markers[markerId] = marker;

    //* Para "notificar" y ejecutar los cambios hechos, en este caso, añadir un marker al mapa
    notifyListeners();
  }

  @override
  void dispose() {
    _markerController.close();
    super.dispose();
  }
}