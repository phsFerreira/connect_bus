// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:connect_bus/infos_motorista.dart';
import 'package:connect_bus/main.dart';
import 'package:connect_bus/profile_widget.dart';
import 'package:connect_bus/status_page.dart';
import 'package:flutter/material.dart';

class MotoristaPage extends StatefulWidget {
  const MotoristaPage({super.key});

  @override
  State<MotoristaPage> createState() => _MotoristaPageState();
}

class _MotoristaPageState extends State<MotoristaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: Text(
              "Olá, motorista!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),

        SizedBox(height: 40),
        ProfileWidget(
            imagePath:
                "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg"),
        SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //onibus button
            SizedBox(
              width: 150,
              height: 130,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StatusPage()));
                  },
                  icon: Icon(
                    Icons.bus_alert,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  label: Text(
                    "Ônibus",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            ),

            //perfil button
            SizedBox(
              width: 150,
              height: 130,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InfoMotorista()));
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  label: Text(
                    "Perfil",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            ),
          ],
        ),
        SizedBox(height: 40),
        SizedBox(
          width: 150,
          height: 130,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {},
                icon: Icon(
                  Icons.alarm,
                  color: Colors.black,
                  size: 24.0,
                ),
                label: Text(
                  "Emergência",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
          ),
        ),
        SizedBox(height: 30),

        //sair button
        SizedBox(
          width: 150,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Color.fromARGB(255, 82, 9, 9),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        side: BorderSide(width: 1, color: Colors.red))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyApp()));
                },
                child: Text(
                  'SAIR',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
          ),
        )
      ],
    ));
  }
}
