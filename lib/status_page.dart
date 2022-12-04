// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:connect_bus/profile_motorista.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Text(
            "O que houve?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 60),

          //onibus quebrou button
          SizedBox(
            width: 300,
            height: 60,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffE85BC0).withOpacity(0.75),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
                onPressed: () {},
                child: Text(
                  "Ônibus quebrou",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
          ),
          SizedBox(height: 30),

          //acidente button
          SizedBox(
            width: 300,
            height: 60,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffFA1B1B).withOpacity(0.75),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
                onPressed: () {},
                child: Text(
                  "Acidente",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
          ),
          SizedBox(height: 40),

          //congestionamento button
          SizedBox(
            width: 300,
            height: 60,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffFCB937).withOpacity(0.75),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
                onPressed: () {},
                child: Text(
                  "Congestionamento",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
          ),
          SizedBox(height: 200),

          //voltar button
          SizedBox(
            width: 320,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MotoristaPage()));
                },
                child: Text(
                  "Voltar",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
          )
        ],
      ))),
    );
  }
}
