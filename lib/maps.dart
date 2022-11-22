// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'autocomplete_predictions.dart';
import 'network_utility.dart';
import 'place_autocomplete_response.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Maps Demo',
//       home: MapSample(),
//     );
//   }
// }

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();
  List<AutocompletePrediction> placePredictions = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-23.288331355021306, -47.6521741838258),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex '),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-23.288005014742865, -47.65236675133978),
  );

  static final Marker _kLakeMarker = Marker(
    markerId: MarkerId('_kLakePlex'),
    infoWindow: InfoWindow(title: 'Google Plex '),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(-23.292608716064695, -47.65043051831898),
  );

  static final Polyline _kPolyline = Polyline(
    polylineId: PolylineId('_kPolyline'),
    points: const [
      LatLng(-23.288005014742865, -47.65236675133978),
      LatLng(-23.292608716064695, -47.65043051831898),
    ],
    width: 5,
  );

  static final Polygon _kPolygon = Polygon(
    polygonId: PolygonId('_kPolygon'),
    points: const [
      LatLng(-23.288005014742865, -47.65236675133978),
      LatLng(-23.292608716064695, -47.65043051831898),
      LatLng(-23.291812332267323, -47.64591929133111),
      LatLng(-23.28613798687782, -47.652327539612706),
    ],
    strokeWidth: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {_kGooglePlexMarker, _kLakeMarker},
              polylines: {_kPolyline},
              polygons: {_kPolygon},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(45.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _searchController,
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              print(value);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                hintText: 'Informe o local de partida',
                                contentPadding: EdgeInsets.all(20.0)),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                hintText: 'Informe o destino',
                                contentPadding: EdgeInsets.all(20.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //IconButton(onPressed: () {}, icon: Icon(Icons.search))
                ],
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        icon: Icon(Icons.menu),
        label: Text('Menu'),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
