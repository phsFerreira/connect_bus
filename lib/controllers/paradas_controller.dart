import 'dart:async';

import 'package:connect_bus/constants/markers.dart';
import 'package:connect_bus/model/parada.dart';
import 'package:connect_bus/repositories/onibus_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../repositories/paradas_repository.dart';
import '../pages/passageiro/pages/mapa/paradas_detalhes_screen.dart';
import '../pages/passageiro/pages/mapa/paradas_screen.dart';

// //
// // Controller baseado no video https://www.youtube.com/watch?v=l_nLqPK7K6Q
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

  getPosicaoAtualUsuario(Completer<GoogleMapController> controller) async {
    _mapsController = await controller.future;

    print('BUSCANDO POSIÇÃO ATUAL DO USUARIO...');
    try {
      Position posicao = await posicaoAtual();
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      // print('latitude: $latitude, longitude: $longitude');
      latlgnPositionPassenger = LatLng(latitude, longitude);

      // Movendo a camera do google maps para a localizaçaõ do usuario
      await _mapsController.animateCamera(
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
    var paradaRepository = ParadasRepository();
    var paradaMarkers = await paradaRepository.getParadas();
    print(paradaMarkers);
    for (var parada in paradaMarkers) {
      addMarker(parada);
      print(parada);
    }

    // (método de ChangeNotifier) usado para notificar qualquer um que esteja assistindo ParadasController
    notifyListeners();
  }

  loadOnibus() async {
    var onibusRepository = OnibusRepository();
    // onibusRepository.getLocalizationsOnibus();

    // (método de ChangeNotifier) usado para notificar qualquer um que esteja assistindo ParadasController
    notifyListeners();
  }

  addMarker(Parada parada) async {
    var latitude = parada.latitude;
    var longitude = parada.longitude;

    markers.add(
      Marker(
        markerId: MarkerId(parada.latitude.toString()!),
        position: LatLng(parada.latitude!, parada.longitude!),
        infoWindow: InfoWindow(title: parada.bairro),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/images/bus-stop_64_orange.png'),
        onTap: () => {
          Navigator.push(
            paradaScreenContextKey.currentState!.context,
            MaterialPageRoute(
              builder: (context) => ParadaDetalhesScreen(parada: parada),
            ),
          )
        },
      ),
    );
    // (método de ChangeNotifier) usado para notificar qualquer um que esteja assistindo ParadasController
    notifyListeners();
  }
}
