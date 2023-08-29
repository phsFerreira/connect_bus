import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:connect_bus/login_motorista.dart';
import 'package:connect_bus/login_passageiro.dart';

final mainPageContextKey = GlobalKey();

Future main() async {
  // Garantir que nao tenha o erro de inicialização.
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega todas as variáveis de ambiente em `main.dart`
  await FlutterConfig.loadEnvVariables();

  await Firebase.initializeApp();

// Bloqueando a tela para ser exibida apenas no modo retrato,
// ou seja, verticalmente (para cima ou para baixo),
// mesmo que o telefone seja girado no modo paisagem.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MainPage()));

  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect Bus', // Nome do aplicativo nos recentes
      theme: ThemeData(fontFamily: 'Comfortaa'),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        key: mainPageContextKey,
        body: _getMainPage(),
      ),
    );
  }

  _getMainPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              _getImage(),
              _getTitle(),
            ],
          ),
          getButtons(),
        ],
      ),
    );
  }

  Container getButtons() {
    return Container(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _buildButton('PASSAGEIRO', Colors.black, 167.0, Colors.black,
              Colors.white, const LoginPassageiroPage()),
          _buildButton('MOTORISTA', Colors.white, 167, Colors.black,
              Colors.black, const LoginMotoristaPage()),
        ]),
      ),
    );
  }

  // Método privado auxiliar que retorna um botão ao passar os dados por parâmetros
  _buildButton(String textButton, Color colorTextButton, double widthButton,
      Color borderButton, Color backgroundButton, Widget pageRedirect) {
    return GestureDetector(
      onTap: () {
        Navigator.push(mainPageContextKey.currentState!.context,
            MaterialPageRoute(builder: (context) => pageRedirect));
      },
      child: Container(
        height: 52.0,
        width: widthButton,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: backgroundButton,
          border: Border.all(color: borderButton, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Center(
          child: Text(
            textButton,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w900,
              color: colorTextButton,
            ),
          ),
        ),
      ),
    );
  }

  _getImage() {
    return Image.asset(
      'assets/images/bus_home.png',
      fit: BoxFit.cover,
      width: 600,
      height: 700,
    );
  }

  _getTitle() {
    return const SizedBox(
      height: 700,
      child: Center(
        child: Text(
          'CONNECT BUS',
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
