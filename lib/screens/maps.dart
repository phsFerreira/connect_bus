// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print, non_constant_identifier_names, unused_element

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_bus/controllers/paradas_controller.dart';
import 'package:connect_bus/headerDrawer.dart';
import 'package:connect_bus/screens/bus_stop_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:connect_bus/main.dart';
import 'package:connect_bus/profile_passageiro.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../autocomplete_predictions.dart';
import '../constants/markers.dart';
import '../database/db.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final paradasController = Get.put(ParadasController());
  List<AutocompletePrediction> placePredictions = [];

  final Set<Marker> mapMarkers = {};

  static final CameraPosition _rodoviariaLocalizacao = CameraPosition(
    target: LatLng(-23.28452854478957, -47.675545745249664),
    zoom: 14.4746,
  );

  //#region: MENU DRAWER
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
  } //#endregion: MENU DRAWER

  Future<Set<Marker>> _buildMarkers() async {
    String nomeBairro = '';
    List paradas = [];
    // final Set<Marker> setMarkerBusStops = {};
    // for (int i = 0; i < paradasController.paradas.length; i++) {
    //   final busStopItem = mapMarkerBusStops[i];
    //   setMarkerBusStops.add(
    //     Marker(
    //         markerId: const MarkerId(''),
    //         position: busStopItem.latlgnPosition,
    //         onTap: () {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) =>
    //                       const BusStopDetails(neighborhood: 'Novo Mundo')));
    //         }),
    //   );
    // }

    FirebaseFirestore db = DB.get();
    try {
      final bairros = await db.collection('Bairros').get();
      for (var bairro in bairros.docs) {
        {
          nomeBairro = bairro.get('nomeBairro');
          paradas = bairro.get('parada');
        }
      }
    } catch (e) {
      // todo: Tratar o erro
      printError(info: e.toString());
    }

    paradas.forEach((parada) async {
      var paradaId = parada['id'];
      var position = parada['position'];
      GeoPoint point = position['geopoint'];

      mapMarkers.add(
        Marker(
          markerId: MarkerId(paradaId.toString()),
          position: LatLng(point.latitude, point.longitude),
          infoWindow: InfoWindow(title: nomeBairro),
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(), 'assets/images/bus-stop.png'),
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const BusStopDetails(neighborhood: 'Novo Mundo')))
          },
        ),
      );
    });
    return mapMarkers;
  }

  @override
  Widget build(BuildContext context) {
    final markers = _buildMarkers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Connect Bus"),
      ),
      body: GetBuilder<ParadasController>(
        init: paradasController,
        builder: (controller) => GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          onMapCreated: controller.onMapCreated,
          markers: mapMarkers,
          initialCameraPosition: _rodoviariaLocalizacao,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Minha localização atual'),
        icon: const Icon(Icons.location_history),
        onPressed: () async {
          print('Buscando localização atual...');
          paradasController.getPosicaoAtualUsuario();

          mapMarkers.add(Marker(
              markerId: const MarkerId('currentLocation'),
              infoWindow: InfoWindow(title: 'Você está aqui!'),
              position: LatLng(paradasController.latitude.value,
                  paradasController.longitude.value),
              onTap: () {
                print('Clicou no marcador!');
              }));

          setState(() {});
        },
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
}
