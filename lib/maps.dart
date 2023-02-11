// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print, non_constant_identifier_names, unused_element

import 'dart:async';

import 'package:connect_bus/headerDrawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:connect_bus/main.dart';
import 'package:connect_bus/profile_passageiro.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'autocomplete_predictions.dart';

final Set<Marker> mapMarkers = {
  Marker(
      markerId: const MarkerId('parada_test_nvmundo1'),
      position: LatLng(-23.261009142007083, -47.671992198992314)),
  Marker(
      markerId: const MarkerId('parada_test_centro'),
      position: LatLng(-23.2860909, -47.6741624)),
  Marker(
      markerId: const MarkerId('parada_test_grupao'),
      position: LatLng(-23.2821963,-47.6723522)),
  Marker(
      markerId: const MarkerId('parada_test_grupao'),
      position: LatLng(-23.2777673,-47.6731613)),
  Marker(
      markerId: const MarkerId('parada_test_nvmundo2'),
      position: LatLng(-23.2625092, -47.6716789)),
  Marker(
      markerId: const MarkerId('parada_test_nvmundo3'),
      position: LatLng(-23.2644994, -47.6712476)),
  Marker(
      markerId: const MarkerId('parada_test_nvmundo4'),
      position: LatLng(-23.2661207, -47.6709187)),
  Marker(
      markerId: const MarkerId('parada_test_nvmundo5'),
      position: LatLng(-23.2668392, -47.6702893)),
};

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController googleMapController;
  List<AutocompletePrediction> placePredictions = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-23.28452854478957, -47.675545745249664),
    zoom: 14.4746,
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
                const number = '+55190';
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
              onPressed: () {
                Fluttertoast.showToast(
                    msg:
                        "Solicitação enviada ao suporte. Logo entraremos em contato.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    fontSize: 20.0);
              },
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

  /*Set<Marker> _buildMarkers(){
    for(int i = 0; i <= mapMarkers.length; i++){

    }
  }*/

  @override
  Widget build(BuildContext context) {
    // final _markers = _buildMarkers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Connect Bus"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: mapMarkers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          print('Buscando localização atual...');
          try {
            Position position = await _determinePosition();

            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 16)));

            mapMarkers.add(Marker(
                markerId: const MarkerId('currentLocation'),
                position: LatLng(position.latitude, position.longitude),
                onTap: () {
                  print('Clicou no marcador!');
                }));

            setState(() {});
          } catch (error) {
            print(error);
          }
        },
        label: const Text('Minha localização atual'),
        icon: const Icon(Icons.location_history),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [HeaderDrawer(), DrawerList()],
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    // #region: Verifica se o serviço de GPS do usuário esta ativo
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Serviço de localização esta desabilitado');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Permissão de localização negada");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão de localização permanentemente negada');
    }
    // #endregion

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
