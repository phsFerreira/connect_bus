// ignore_for_file: prefer_const_constructors

import 'package:connect_bus/homepage.dart';
import 'package:connect_bus/login_motorista.dart';
import 'package:flutter/material.dart';
import 'cadastro_passageiro.dart';
import 'login_passageiro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
