import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:connect_bus/login_passageiro.dart';
import 'package:connect_bus/screens/auth_page.dart';
import 'package:connect_bus/widgets/button.dart';

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
    return Column(
      children: [
        Flexible(
          flex: 6,
          fit: FlexFit.tight,
          child: Stack(
            children: [
              _getImage(),
              _getTitle(),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: getButtons(),
        ),
      ],
    );
  }

  Container getButtons() {
    return Container(
      padding: const EdgeInsets.all(25.0),
      child: const Center(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ButtonWidget(
            textButton: 'PASSAGEIRO',
            colorTextButton: Colors.black,
            widthButton: 167.0,
            borderButton: Colors.black,
            backgroundButton: Colors.white,
            pageRedirect: LoginPassageiroPage(),
          ),
          ButtonWidget(
            textButton: 'MOTORISTA',
            colorTextButton: Colors.white,
            widthButton: 167.0,
            borderButton: Colors.black,
            backgroundButton: Colors.black,
            pageRedirect: AuthPage(),
          ),
        ]),
      ),
    );
  }

  _getImage() {
    return Image.asset(
      'assets/images/bus_home.png',
      fit: BoxFit.cover,
      width: 600,
    );
  }

  _getTitle() {
    return const SizedBox(
      // height: 700,
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
