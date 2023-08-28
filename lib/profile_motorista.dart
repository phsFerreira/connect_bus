import 'package:connect_bus/screens/motorista/linha.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:connect_bus/infos_motorista.dart';
import 'package:connect_bus/main.dart';
import 'package:connect_bus/profile_widget.dart';
import 'package:connect_bus/repositories/onibus_repository.dart';
import 'package:connect_bus/status_page.dart';

class MotoristaPage extends StatefulWidget {
  final String? codigoOnibus;
  const MotoristaPage({super.key, this.codigoOnibus});

  @override
  State<MotoristaPage> createState() => _MotoristaPageState();
}

class _MotoristaPageState extends State<MotoristaPage> {
  Location? _location;
  OnibusRepository? onibusRepository;

  @override
  void initState() {
    _init();
    print('Código de onibus de rastreio ====> ${widget.codigoOnibus}');

    super.initState();
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

  /// Função responsável por ouvir o movimento da posição do celular do Motorista.
  void _listenLocation() {
    _location?.onLocationChanged.listen((newLocation) async {
      print('NOVA POSICAO ${newLocation.latitude}, ${newLocation.longitude}');

      // Alterando a posição do onibus no Firebase.
      onibusRepository!.updateLatLgn(
          widget.codigoOnibus!, newLocation.latitude!, newLocation.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _getGreeting(),
          const SizedBox(height: 40),
          _getPhoto(),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _getGreySquareButton(
                  Icons.bus_alert, "Ônibus", const StatusPage()),
              _getGreySquareButton(
                  Icons.person, "Perfil", const InfoMotorista()),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _getGreySquareButton(Icons.alarm, "Emergência", null),
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
          const SizedBox(height: 30),
          _getButtonLogOut(),
        ],
      ),
    );
  }

  /// Widget que mostra mensagem 'Ola, Motorista'.
  _getGreeting() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Center(
        child: Text(
          "Olá, motorista!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }

  /// Widget que mostra foto do motorista
  _getPhoto() {
    return const ProfileWidget(
        imagePath:
            "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg");
  }

  /// Widget que gera um botão quadrado cinza

  _getGreySquareButton(IconData icon, String text, Widget? pageRedirect) {
    return SizedBox(
      width: 150,
      height: 130,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => pageRedirect!));
        },
        icon: Icon(
          icon,
          color: Colors.black,
          size: 24.0,
        ),
        label: Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  _getButtonLogOut() {
    return SizedBox(
      width: 150,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 82, 9, 9),
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  side: BorderSide(width: 1, color: Colors.red))),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyApp()));
          },
          child: const Text(
            'SAIR',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }

  _getButtonEnableTracking() {
    return SizedBox(
      width: 150,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[500],
                padding: const EdgeInsets.symmetric(horizontal: 30),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    side: BorderSide(width: 1, color: Colors.green))),
            onPressed: () {
              _listenLocation();
            },
            child: const Text(
              'Ativar Rastreio',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
      ),
    );
  }
}
