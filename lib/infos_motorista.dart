// ignore_for_file: prefer_const_constructors

import 'package:connect_bus/profile_motorista.dart';
import 'package:connect_bus/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InfoMotorista extends StatefulWidget {
  const InfoMotorista({super.key});

  @override
  State<InfoMotorista> createState() => _InfoMotoristaState();
}

class _InfoMotoristaState extends State<InfoMotorista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              "Seu Perfil!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 30),

            //imagem do motorista
            ProfileWidget(
                imagePath:
                    "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg"),
            SizedBox(
              height: 40,
            ),

            //texto reputacao
            SizedBox(
              width: 300,
              height: 30,
              child: Text(
                "Reputação:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),

            //campo das estrelas
            RatingBar.builder(
                minRating: 1,
                itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (rating) {}),
            SizedBox(height: 20),

            //texto numero registro
            SizedBox(
                width: 300,
                height: 30,
                child: Text(
                  "Nº de registro:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            SizedBox(
              width: 300,
              height: 30,
              child: Text(
                "5948298591831",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(height: 300),

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
        ),
      )),
    );
  }
}
