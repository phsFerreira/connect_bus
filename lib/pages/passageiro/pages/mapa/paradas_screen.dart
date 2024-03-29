import 'dart:async';

import 'package:connect_bus/model/passageiro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:connect_bus/controllers/paradas_controller.dart';
import 'package:connect_bus/pages/passageiro/pages/mapa/onibus_linha.dart';
import 'package:connect_bus/widgets/menu_drawer.dart';

/// Mapa com as paradas de ônibus da cidade

GlobalKey<State<StatefulWidget>> paradaScreenContextKey = GlobalKey();

class ParadasScreen extends StatefulWidget {
  const ParadasScreen({
    Key? key,
    required this.passageiro,
    // required this.emailPassageiro,
    // required this.nomePassageiro,
  }) : super(key: key);
  // final String emailPassageiro;
  // final String nomePassageiro;
  final Passageiro passageiro;
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
        backgroundColor: const Color.fromARGB(255, 13, 106, 212),
        title: const Text('CONNECT BUS',
            style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),

      // Menu lateral
      drawer: MenuDrawer(passageiro: widget.passageiro),

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
                    // paradaController.loadOnibus();
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
              'Linha 001 AZUL',
              const Color.fromARGB(255, 3, 110, 197),
            ),
            _getCard(
              'Linha 002 (A) LARANJA',
              const Color.fromRGBO(247, 124, 0, 1),
            ),
            _getCard(
              'Linha 002 (B) LARANJA',
              const Color.fromRGBO(247, 124, 0, 1),
            ),
            _getCard(
              'Linha 003 VERDE',
              const Color.fromRGBO(0, 176, 80, 1),
            ),
            _getCard('Linha 004 VERMELHA', Colors.red),
            _getCard(
              'Linha 005 CORAL',
              const Color.fromRGBO(255, 51, 153, 1),
            ),
            _getCard(
              'Linha 006 LILÁS',
              const Color.fromRGBO(239, 25, 208, 1),
            ),
            _getCard(
              'Linha 007 (A) EXPRESSA',
              const Color.fromARGB(255, 3, 110, 197),
            ),
            _getCard(
              'Linha 007 (B) EXPRESSA',
              const Color.fromARGB(255, 3, 110, 197),
            ),
            _getCard(
              'Linha 008 PERIMETRAL',
              const Color.fromRGBO(51, 51, 51, 1),
            ),
            _getCard(
              'Linha 009 BRONZE',
              const Color.fromRGBO(217, 108, 31, 1),
            ),
            _getCard(
              'Linha 010 PRATA',
              const Color.fromRGBO(95, 95, 95, 1),
            ),
            _getCard(
              'Linha 011 TURÍSTICA',
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
