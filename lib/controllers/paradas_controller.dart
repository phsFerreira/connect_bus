import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../repositories/paradas_repository.dart';
import '../screens/paradas_detalhes.dart';
import '../screens/paradas_screen.dart';

// //
// // Controller baseado no video https://www.youtube.com/watch?v=N5MsMDbz6_w&t=1133s
// //

// ChangeNotifier significa que pode notificar os outros sobre suas mudanças. O
// estado é criado e fornecido para todo o aplicativo usando um ChangeNotifierProvider
// (consulte o código acima em MyApp). Isso permite que qualquer widget no aplicativo
// obtenha o estado.
class ParadasController extends ChangeNotifier {
  double latitude = 0.0;
  double longitude = 0.0;
  String erroMessage = '';
  Set<Marker> markers = <Marker>{};

  // Responsavel por movimentar o mapa, adicionar e remover marcadores e assim por diante...
  late GoogleMapController _mapsController;

  // getter do atributo _mapsController
  get mapsController => _mapsController;

  getPosicaoAtualUsuario(GoogleMapController controller) async {
    _mapsController = controller;

    print('BUSCANDO POSIÇÃO ATUAL DO USUARIO...');
    try {
      Position posicao = await posicaoAtual();
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      print('latitude: $latitude, longitude: $longitude');

      // Movendo a camera do google maps para a localizaçaõ do usuario
      _mapsController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 16),
        ),
      );
    } catch (e) {
      erroMessage = e.toString();
    }
    // (método de ChangeNotifier) usado para notificar qualquer um que esteja assistindo ParadasController
    notifyListeners();
  }

  Future<Position> posicaoAtual() async {
    // #region: Verifica se o serviço de GPS do usuário esta ativo
    LocationPermission permissao;

    // Checando se o serviço de localização esta ativado no celular.
    bool ativado = await Geolocator.isLocationServiceEnabled();

    // Se o serviço de localização não estiver ativo retorne um erro.
    if (!ativado) {
      ScaffoldMessenger.of(paradaScreenContextKey.currentState!.context)
          .showSnackBar(const SnackBar(
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
        ScaffoldMessenger.of(paradaScreenContextKey.currentState!.context)
            .showSnackBar(const SnackBar(
          content: Text("Voce precisa autorizar o acesso a localização"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(200, 202, 2, 2),
        ));
      }
    }

    // Se o usuário tem a permissão de localização permanentemente desabilitada, então precisa orientá-lo
    // a ativar pelas configurações
    if (permissao == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(paradaScreenContextKey.currentState!.context)
          .showSnackBar(const SnackBar(
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
    final paradas = ParadasRepository().paradas;
    for (var parada in paradas) {
      markers.add(
        Marker(
          markerId: MarkerId(parada.id),
          position: LatLng(parada.latitude, parada.longitude),
          icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(),
            'assets/images/bus-stop.png',
          ),
          onTap: () => {
            // showModalBottomSheet(
            //   context: paradaScreenContextKey.currentState!.context,
            //   builder: (context) => ParadaDetalhes(parada: parada),
            // )
            Navigator.push(
              paradaScreenContextKey.currentState!.context,
              MaterialPageRoute(
                builder: (context) => ParadaDetalhes(parada: parada),
              ),
            )
          },
        ),
      );
    }

    // Parada parada;
    // FirebaseFirestore db = FirebaseFirestore.instance;
    // try {
    //   final bairros = await db.collection('Bairros').get();
    //   for (var bairro in bairros.docs) {
    //     {
    //       parada.bairro = bairro.get('nomeBairro');
    //       paradas = bairro.get('parada');
    //     }
    //   }
    // } catch (e) {
    //   // todo: Tratar o erro
    //   printError(info: e.toString());
    // }

    // (método de ChangeNotifier) usado para notificar qualquer um que esteja assistindo ParadasController
    notifyListeners();
  }
}