import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class BusStopsController extends ChangeNotifier {
  double latitude = 0.0;
  double longitude = 0.0;
  String erro = '';

  BusStopsController() {
    getPosicaoAtualUsuario();
  }

  getPosicaoAtualUsuario() async {
    try {
      Position posicao = await _posicaoAtual();
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      // _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    // #region: Verifica se o serviço de GPS do usuário esta ativo
    LocationPermission permissao;

    // Checando se o serviço de localização esta ativado no celular.
    bool ativado = await Geolocator.isLocationServiceEnabled();

    // Se o serviço de localização não estiver ativo retorne um erro.
    if (!ativado) {
      return Future.error('Por favor, habilite a localização do smartphone.');
    }

    permissao = await Geolocator.checkPermission();

    // Se o usuário negou a permissão de localização se sim requisita para o usuário a sua localização.
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      // Se mesmo solicitando o acesso o usuário negar, então mostre mensagem de erro.
      if (permissao == LocationPermission.denied) {
        return Future.error("Voce precisa autorizar o acesso a localização");
      }
    }

    // Se o usuário tem a permissão de localização permanentemente desabilitada, então precisa orientá-lo
    // a ativar pelas configurações
    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Autorize o acesso à localização nas configurações.');
    }
    // #endregion

    Position posicaoAtual = await Geolocator.getCurrentPosition();

    return posicaoAtual;
  }
}
