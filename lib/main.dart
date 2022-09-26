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
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 52.0,
                width: 167.0,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                child: const Center(
                  child: Text('PASSAGEIRO', style: TextStyle(fontSize: 13.0)),
                )),
            Container(
              height: 52.0,
              width: 167.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: const Center(
                child: Text(
                  'MOTORISTA',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Comfortaa'),
      home: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/bus_home.png',
                  fit: BoxFit.cover,
                  width: 600,
                  height: 700,
                ),
                Container(
                  height: 700,
                  child: Center(
                    child: Text(
                      'CONNECT BUS',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ],
            ),
            buttonSection,
          ],
        ),
      ),
    );
  }
}
