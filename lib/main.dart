import 'package:connect_bus/login_motorista.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:connect_bus/login_passageiro.dart';

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
  ]).then((value) => runApp(const MyApp()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonSection = Container(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(builder: (context) {
              return GestureDetector(
                key: const ValueKey('keyPassageiro'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: _buildButton('PASSAGEIRO', Colors.black, 167.0,
                    Colors.black, Colors.white),
              );
            }),
            Builder(builder: (context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPageMotorista()));
                },
                child: _buildButton(
                    'MOTORISTA', Colors.white, 167, Colors.black, Colors.black),
              );
            }),
          ],
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect Bus', // Nome do aplicativo nos recentes
      theme: ThemeData(fontFamily: 'Comfortaa'),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/bus_home.png',
                    fit: BoxFit.cover,
                    width: 600,
                    height: 700,
                  ),
                  const SizedBox(
                    height: 700,
                    child: Center(
                      child: Text(
                        'CONNECT BUS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              buttonSection,
            ],
          ),
        ),
      ),
    );
  }

  // Método privado auxiliar que retorna um botão ao passar os dados por parâmetros
  Container _buildButton(String textButton, Color colorTextButton,
      double widthButton, Color borderButton, Color backgroundButton) {
    return Container(
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
    );
  }
}
