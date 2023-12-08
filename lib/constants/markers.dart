import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkerBusStop {
  MapMarkerBusStop({
    required this.id,
    required this.neighborhood,
    required this.latlgnPosition,
  });
  final String id;
  final LatLng latlgnPosition;
  final String neighborhood;
}

LatLng latlgnPositionPassenger = LatLng(0, 0);

final mapMarkerBusStops = [
  MapMarkerBusStop(
      id: '11',
      neighborhood: 'Novo Mundo',
      latlgnPosition: LatLng(-23.2609126, -47.6720064)),
  MapMarkerBusStop(
      id: '12',
      neighborhood: 'Novo Mundo',
      latlgnPosition: LatLng(-23.2625092, -47.6716789)),
];
