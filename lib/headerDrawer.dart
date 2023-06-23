// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:connect_bus/login_passageiro.dart';
import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {

  String email;
  String nome;

  HeaderDrawer({super.key, required this.email, required this.nome});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {

  @override
  Widget build(BuildContext context) {

    final args=ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    String nomePassageiro=args.nome;
    String emailPassageiro=args.email;

    return Container(
      color: Colors.grey[700],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg"))),
          ),
          Text(
            nomePassageiro,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            emailPassageiro,
            style: TextStyle(color: Colors.grey[200], fontSize: 14),
          )
        ],
      ),
    );
  }
}
