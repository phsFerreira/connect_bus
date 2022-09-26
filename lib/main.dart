// ignore_for_file: prefer_const_constructors, unused_import

import 'package:connect_bus/home_page.dart';
import 'package:connect_bus/login_motorista.dart';
import 'package:flutter/material.dart';
import 'cadastro_passageiro.dart';
import 'login_passageiro.dart';
import 'main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonSection = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: Text('Passageiro'),
          ),
        ],
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Image.asset(
                'images/bus_home.png',
                fit: BoxFit.cover,
              ),
            ),
            buttonSection,
          ],
        ),
      ),
    );
  }
}
