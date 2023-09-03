import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

import 'package:connect_bus/pages/motorista/pages/bus_status_page.dart';
import 'package:connect_bus/pages/motorista/login_motorista.dart';
import 'package:connect_bus/main.dart';
import 'package:connect_bus/pages/motorista/pages/profile_motorista.dart';
import 'package:connect_bus/profile_widget.dart';
import 'package:connect_bus/repositories/onibus_repository.dart';
import 'package:connect_bus/pages/motorista/pages/linha.dart';
import 'package:connect_bus/widgets/button.dart';

class HomeMotoristaPage extends StatefulWidget {
  final String? codigoOnibus;
  const HomeMotoristaPage({super.key, this.codigoOnibus});

  @override
  State<HomeMotoristaPage> createState() => _HomeMotoristaPage();
}

class _HomeMotoristaPage extends State<HomeMotoristaPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
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

              /// TODO: Foto do motorista tem que ser obtida do banco
              ClipOval(
                child: Material(
                  child: Ink.image(
                    image: const NetworkImage(
                        "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg"),
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),

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

  _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// Widget que mostra mensagem 'Ola, Motorista'.
  _getGreeting() {
    return const Text(
      "Olá, motorista!",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }

  /// Widget que mostra foto do motorista
  _getPhoto() {
    return const ProfileWidget(
      imagePath:
          "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg",
      width: 10,
      height: 10,
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginMotoristaPage()));
      },
    );
  }

  //signout function
  signOut(BuildContext context) async {
    await auth.signOut();
    if (context.mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    }
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

  _getButtonEnableTracking() {
    return ButtonWidget(
      textButton: 'ATIVAR RASTREIO',
      colorTextButton: Colors.white,
      widthButton: double.infinity,
      borderButton: Colors.green.shade900,
      backgroundButton: Colors.green.shade900,
      onPressed: () {
        Fluttertoast.showToast(msg: "Rastreio ligado com sucesso.");
        _listenLocation();
      },
    );
  }
}
