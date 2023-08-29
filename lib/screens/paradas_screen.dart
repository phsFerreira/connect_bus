import 'dart:async';

import 'package:connect_bus/screens/passageiro/onibus_linha.dart';
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
            _getCard(
              'Linha 001 Azul',
              const Color.fromARGB(255, 3, 110, 197),
            ),
            _getCard(
              'Linha 002 (A) Laranja',
              const Color.fromRGBO(247, 124, 0, 1),
            ),
            _getCard(
              'Linha 002 (B) Laranja',
              const Color.fromRGBO(247, 124, 0, 1),
            ),
            _getCard(
              'Linha 003 Verde',
              const Color.fromRGBO(0, 176, 80, 1),
            ),
            _getCard('Linha 004 Vermelha', Colors.red),
            _getCard(
              'Linha 005 Coral',
              const Color.fromRGBO(255, 51, 153, 1),
            ),
            _getCard(
              'Linha 006 Lilas',
              const Color.fromRGBO(239, 25, 208, 1),
            ),
            _getCard(
              'Linha 007 (A) Expressa',
              const Color.fromARGB(255, 3, 110, 197),
            ),
            _getCard(
              'Linha 007 (B) Expressa',
              const Color.fromARGB(255, 3, 110, 197),
            ),
            _getCard(
              'Linha 008 Perimetral',
              const Color.fromRGBO(51, 51, 51, 1),
            ),
            _getCard(
              'Linha 009 Bronze',
              const Color.fromRGBO(217, 108, 31, 1),
            ),
            _getCard(
              'Linha 010 Prata',
              const Color.fromRGBO(95, 95, 95, 1),
            ),
            _getCard(
              'Linha 011 Turistica',
              const Color.fromRGBO(116, 85, 189, 1),
            ),
          ],
        ),
      ),
    );
  }

  _getCard(String nomeLinha, Color corCard) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnibusLinhaPage(nomeLinha: nomeLinha),
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
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: 'Roboto'),
          )),
        ),
      ),
    );
  }
}
