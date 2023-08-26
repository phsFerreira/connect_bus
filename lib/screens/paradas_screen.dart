import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:connect_bus/controllers/paradas_controller.dart';
import 'package:connect_bus/screens/onibus_localizacao.dart';
import 'package:connect_bus/widgets/menu_drawer.dart';

/// Mapa com as paradas de ônibus da cidade

final paradaScreenContextKey = GlobalKey();

class ParadasScreen extends StatefulWidget {
  const ParadasScreen({Key? key}) : super(key: key);

  @override
  State<ParadasScreen> createState() => ParadasScreenState();
}

class ParadasScreenState extends State<ParadasScreen> {
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  /// Ponto inicial da camera do google maps caso a localização do usuario esteja
  /// desativada.
  static const CameraPosition _rodoviariaLocalizacao = CameraPosition(
    target: LatLng(-23.28452854478957, -47.675545745249664),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Recupera o contexto do Scaffold e manda para a ParadasController
      key: paradaScreenContextKey,

      // Barra superior
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text('Connect Bus'),
      ),

      // Menu lateral
      drawer: const MenuDrawer(),

      // Mapa com as paradas de onibus
      body: ChangeNotifierProvider<ParadasController>(
        create: (context) => ParadasController(),
        child: Builder(builder: (context) {
          final paradaController = context.watch<ParadasController>();
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  initialCameraPosition: _rodoviariaLocalizacao,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController.complete(controller);

                    // Quando o mapa for criado pegue a posição atual do usuário
                    paradaController
                        .getPosicaoAtualUsuario(googleMapController);
                    paradaController.loadParadas();
                    paradaController.loadOnibus();
                  },
                  markers: paradaController.markers,
                ),
              ),
              _listCardsHorizontal(),
            ],
          );
        }),
      ),

      // Botão 'Minha localização atual'
      floatingActionButton: ChangeNotifierProvider<ParadasController>(
        create: (context) => ParadasController(),
        child: Builder(builder: (context) {
          final paradaController = context.watch<ParadasController>();

          return FloatingActionButton.extended(
              label: const Text('Minha localização atual'),
              icon: const Icon(Icons.location_history),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Buscando sua localização...'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color.fromARGB(30, 0, 0, 0),
                ));
                try {
                  paradaController.getPosicaoAtualUsuario(googleMapController);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(error.toString()),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color.fromARGB(200, 202, 2, 2),
                  ));
                }
              });
        }),
      ),
    );
  }

  _listCardsHorizontal() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 60.0),
        height: 110.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const SizedBox(width: 10.0),
            _lineBusCard('Linha 001 Azul', Colors.blue[400]!),
            const SizedBox(width: 10.0),
            _lineBusCard('Linha 002(A) Laranja', Colors.orange[400]!),
          ],
        ),
      ),
    );
  }

  _lineBusCard(String nomeLinha, Color corCard) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const OnibusLocalizacao(nomeDalinha: 'user1'),
            ),
          );
        },
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: corCard,
          ),
          child: Center(
              child: Text(
            nomeLinha,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
