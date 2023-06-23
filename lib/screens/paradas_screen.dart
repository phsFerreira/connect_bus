import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:connect_bus/controllers/paradas_controller.dart';
import 'package:connect_bus/widgets/menu_drawer.dart';

final paradaScreenContextKey = GlobalKey();

class ParadasScreen extends StatefulWidget {
  const ParadasScreen({Key? key}) : super(key: key);

  @override
  State<ParadasScreen> createState() => _ParadasScreenState();
}

class _ParadasScreenState extends State<ParadasScreen> {
  late GoogleMapController googleMapController;

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
          return GoogleMap(
            initialCameraPosition: _rodoviariaLocalizacao,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;

              // Quando o mapa for criado pegue a posição atual do usuário
              paradaController.getPosicaoAtualUsuario(googleMapController);
              paradaController.loadParadas();
            },
            markers: paradaController.markers,
          );
        }),
      ),

      // Minha localização atual
      floatingActionButton: ChangeNotifierProvider<ParadasController>(
        create: (context) => ParadasController(),
        child: Builder(
          builder: (context) {
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
              },
            );
          },
        ),
      ),
    );
  }
}
