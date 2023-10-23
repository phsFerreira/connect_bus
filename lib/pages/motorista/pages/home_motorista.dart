import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

import 'package:connect_bus/pages/motorista/pages/bus_status_page.dart';
import 'package:connect_bus/pages/motorista/pages/linha.dart';
import 'package:connect_bus/pages/motorista/pages/profile_motorista.dart';
import 'package:connect_bus/repositories/onibus_repository.dart';
import 'package:connect_bus/widgets/button.dart';

class HomeMotoristaPage extends StatefulWidget {
  final String? codigoOnibus;
  const HomeMotoristaPage({super.key, this.codigoOnibus});

  @override
  State<HomeMotoristaPage> createState() => _HomeMotoristaPage();
}

class _HomeMotoristaPage extends State<HomeMotoristaPage> {
  Location? _location;
  StreamSubscription<LocationData>? _locationSubscription;
  OnibusRepository? onibusRepository;

  @override
  void initState() {
    super.initState();
    _init();
    print('Código de onibus de rastreio ====> ${widget.codigoOnibus}');
  }

  /// Função responsável por atribuir valor para o atributo '_location'
  /// e para 'onibusRepository'
  _init() async {
    onibusRepository = OnibusRepository();
    _location = Location();
    // O argumento [accuracy] controla a precisão da localização.
    // O [interval]controla a frequência com que um novo local é enviado
    // por meio de [onLocationChanged].
    _location!.changeSettings(interval: 30, accuracy: LocationAccuracy.high);
    // Ativa o serviço em segundo plano.
    _location!.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getHomePage(),
    );
  }

  _getHomePage() {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: OverflowBar(
            overflowSpacing: 30,
            overflowAlignment: OverflowBarAlignment.center,
            children: [
              _getGreeting(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getGreySquareButton(Icons.bus_alert, "Ônibus",
                      BusStatusPage(codigoOnibus: widget.codigoOnibus)),
                  _getGreySquareButton(
                      Icons.person, "Perfil", const ProfileMotorista()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getGreySquareButton(Icons.policy, "Emergência", null),
                  _getGreySquareButton(
                      Icons.route,
                      "Linha",
                      LinhaPage(
                        codigoOnibus: widget.codigoOnibus,
                      )),
                ],
              ),
              const SizedBox(height: 30),
              _getButtonEnableTracking(),
              _getButtonLogOut(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget que mostra mensagem 'Ola, Motorista'.
  _getGreeting() {
    return const Text(
      "Olá, motorista!",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }

  /// Widget que gera um botão quadrado cinza
  _getGreySquareButton(IconData icon, String text, Widget? pageRedirect) {
    return GestureDetector(
      onTap: () {
        if (pageRedirect != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => pageRedirect));
        } else {
          const number = '+55190';
          FlutterPhoneDirectCaller.callNumber(number);
        }
      },
      child: Container(
        width: 150,
        height: 130,
        color: Colors.grey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
            ),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  _getButtonLogOut(BuildContext context) {
    return ButtonWidget(
      textButton: 'SAIR',
      colorTextButton: Colors.white,
      widthButton: double.infinity,
      borderButton: Colors.red.shade900,
      backgroundButton: Colors.red.shade900,
      onPressed: () {
        _signOut();
      },
    );
  }

  _signOut() async {
    try {
      _stopListeningLocation();
      await FirebaseAuth.instance.signOut();
      // Navigate to the login screen or home screen
      Navigator.of(context).pushReplacementNamed('/main');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error during logout: $e');
    }
  }

  void _stopListeningLocation() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  /// Função responsável por ouvir o movimento da posição do celular do Motorista.
  void _listenLocation() {
    _locationSubscription =
        _location?.onLocationChanged.listen((newLocation) async {
      print('NOVA POSICAO ${newLocation.latitude}, ${newLocation.longitude}');

      // Alterando a posição do onibus no Firebase.
      onibusRepository!.updateLatLgn(
          widget.codigoOnibus!, newLocation.latitude!, newLocation.longitude!);
    });
  }

  _getButtonEnableTracking() {
    return ButtonWidget(
      textButton: 'ATIVAR RASTREIO',
      colorTextButton: Colors.white,
      widthButton: double.infinity,
      borderButton: Colors.green.shade900,
      backgroundButton: Colors.green.shade900,
      onPressed: () {
        _locationPermission();
      },
    );
  }

  void _locationPermission() async {
    if (_location == null) {
      _location = new Location();
    }
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Retorna um booleano para saber se o Serviço de Localização está habilitado ou se o usuário o desativou manualmente.
    _serviceEnabled = await _location!.serviceEnabled();
    if (!_serviceEnabled) {
      // Mostre uma caixa de diálogo de alerta para solicitar que o usuário ative o serviço de localização.
      _serviceEnabled = await _location!.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Retorne um PermissionStatus para saber o estado da permissão de localização.
    _permissionGranted = await _location!.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      Fluttertoast.showToast(
          msg: "Por favor, ative sua localização.",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 19,
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER);

      // Solicite a permissão de localização. Retorne um PermissionStatus para saber se a permissão foi concedida.
      _permissionGranted = await _location!.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Fluttertoast.showToast(
            msg: "Por favor, ative sua localização.",
            toastLength: Toast.LENGTH_LONG,
            fontSize: 19,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER);
        return;
      }
    }
    Fluttertoast.showToast(
        msg: "Rastreio ligado com sucesso.",
        toastLength: Toast.LENGTH_LONG,
        fontSize: 19,
        backgroundColor: Colors.green.shade900,
        gravity: ToastGravity.CENTER);

    _locationData = await _location!.getLocation();
    // Alterando a posição do onibus no Firebase.
    onibusRepository!.updateLatLgn(widget.codigoOnibus!,
        _locationData.latitude!, _locationData.longitude!);
    _listenLocation();
  }
}
