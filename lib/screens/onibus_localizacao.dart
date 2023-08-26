import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Tela que mostra o onibus da respectiva Linha se movimentando
/// em tempo real.

class OnibusLocalizacao extends StatefulWidget {
  const OnibusLocalizacao({Key? key, required this.nomeDalinha})
      : super(key: key);
  final String nomeDalinha;

  @override
  OnibusLocalizacaoState createState() => OnibusLocalizacaoState();
}

class OnibusLocalizacaoState extends State<OnibusLocalizacao> {
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  bool _added = false;
  BitmapDescriptor myIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();

    // Carregando a ícone do ônibus e atribuiundo a variável `myIcon`
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/images/bus-moving.png')
        .then((onValue) {
      myIcon = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeDalinha.toString()),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('location').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (_added) {
            newCameraPosition(snapshot);
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            mapType: MapType.normal,
            markers: {
              Marker(
                  position: LatLng(
                    snapshot.data!.docs.singleWhere((element) =>
                        element.id == widget.nomeDalinha)['latitude'],
                    snapshot.data!.docs.singleWhere((element) =>
                        element.id == widget.nomeDalinha)['longitude'],
                  ),
                  markerId: const MarkerId('id'),
                  icon: myIcon),
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(
                  snapshot.data!.docs.singleWhere((element) =>
                      element.id == widget.nomeDalinha)['latitude'],
                  snapshot.data!.docs.singleWhere((element) =>
                      element.id == widget.nomeDalinha)['longitude'],
                ),
                zoom: 10),
            onMapCreated: (GoogleMapController controller) async {
              setState(() {
                googleMapController.complete(controller);
                _added = true;
              });
            },
          );
        },
      ),
    );
  }

  Future<void> newCameraPosition(AsyncSnapshot<QuerySnapshot> snapshot) async {
    GoogleMapController mapsController;
    mapsController = await googleMapController.future;
    await mapsController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.nomeDalinha)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.nomeDalinha)['longitude'],
            ),
            zoom: 16)));
  }
}
