// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print, non_constant_identifier_names

import 'dart:async';

import 'package:connect_bus/headerDrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:connect_bus/main.dart';
import 'package:connect_bus/profile_passageiro.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'autocomplete_predictions.dart';

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

  Widget DrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(),
        ],
      ),
    );
  }

  Widget menuItem() {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.home,
            size: 25,
            color: Colors.black,
          ),
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            size: 25,
            color: Colors.black,
          ),
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PassageiroPage()));
          },
        ),
        SizedBox(height: 60),

        //emergencia button
        SizedBox(
          width: 230,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(width: 1, color: Colors.black))),
              onPressed: () {
                final number = '+55190';
                FlutterPhoneDirectCaller.callNumber(number);
              },
              child: Text(
                'Emergência',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ),

        SizedBox(height: 20),

        //ajuda button
        SizedBox(
          width: 230,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(width: 1, color: Colors.black))),
              onPressed: () {},
              child: Text(
                'Ajuda',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ),

        SizedBox(height: 100),

        //sair button
        SizedBox(
          width: 230,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Color.fromARGB(255, 82, 9, 9),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(width: 1, color: Colors.red))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
              child: Text(
                'sair',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Connect Bus"),
      ),
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   icon: Icon(Icons.menu),
      //   label: Text('Menu'),
      // ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [HeaderDrawer(), DrawerList()],
          ),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

//MENU DRAWER

