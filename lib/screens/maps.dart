// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print, non_constant_identifier_names, unused_element

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  late GoogleMapController googleMapController;
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

  @override
  Widget build(BuildContext context) {
    //final markers = _buildMarkers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Connect Bus"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) async {
          googleMapController = controller;
          try {
            final posicaoAtual = await _posicaoAtual();
            // Movendo a camera do google maps para a localização do usuario
            googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target:
                        LatLng(posicaoAtual.latitude, posicaoAtual.longitude),
                    zoom: 16),
              ),
            );
            loadParadas();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Color.fromARGB(200, 202, 2, 2),
            ));
          }
        },
        markers: mapMarkers,
        initialCameraPosition: _rodoviariaLocalizacao,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Minha localização atual'),
        icon: const Icon(Icons.location_history),
        onPressed: () async {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Buscando localização atual...'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(30, 0, 0, 0),
          ));
          try {
            Position posicaoAtual = await _posicaoAtual();

            // Movendo a camera do google maps para a localização do usuario
            googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target:
                        LatLng(posicaoAtual.latitude, posicaoAtual.longitude),
                    zoom: 16),
              ),
            );

            // Adicionando marcador na posição atual do usuário
            mapMarkers.add(Marker(
                markerId: const MarkerId('currentLocation'),
                infoWindow: InfoWindow(title: 'Você está aqui!'),
                position: LatLng(posicaoAtual.latitude, posicaoAtual.longitude),
                onTap: () {
                  print('Clicou no marcador!');
                }));

            setState(() {});
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Color.fromARGB(200, 202, 2, 2),
            ));
          }
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

  Future<Position> _posicaoAtual() async {
    // #region: Verifica se o serviço de GPS do usuário esta ativo
    bool ativado;
    LocationPermission permissao;

    // Checando se o serviço de localização esta ativado no celular.
    ativado = await Geolocator.isLocationServiceEnabled();

    // Se o serviço de localização não estiver ativo retorne um erro.
    if (!ativado) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, habilite a localização do smartphone.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(200, 202, 2, 2),
      ));
    }

    permissao = await Geolocator.checkPermission();

    // Se o usuário negou a permissão de localização se sim requisita para o usuário a sua localização.
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      // Se mesmo solicitando o acesso o usuário negar, então mostre mensagem de erro.
      if (permissao == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Voce precisa autorizar o acesso a localização"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(200, 202, 2, 2),
        ));
      }
    }

    // Se o usuário tem a permissão de localização permanentemente desabilitada, então precisa orientá-lo
    // a ativar pelas configurações
    if (permissao == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Autorize o acesso à localização nas configurações.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(200, 202, 2, 2),
      ));
    }
    // #endregion

    Position posicaoAtual = await Geolocator.getCurrentPosition();

    return posicaoAtual;
  }

  loadParadas() async {
    FirebaseFirestore db = DB.get();
    try {
      final bairros = await db.collection('Bairros').get();
      for (var bairro in bairros.docs) {
        generateMarkers(bairro);
      }

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(200, 202, 2, 2),
      ));
    }
  }

  generateMarkers(bairro) {
    List paradas = bairro.get('paradas');
    paradas.forEach((parada) async {
      var paradaId = parada['id'];
      GeoPoint point = parada['geopoint'];

      mapMarkers.add(
        Marker(
          markerId: MarkerId(paradaId.toString()),
          position: LatLng(point.latitude, point.longitude),
          infoWindow: InfoWindow(title: bairro.get('nomeBairro')),
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
    setState(() {});
  }
}
