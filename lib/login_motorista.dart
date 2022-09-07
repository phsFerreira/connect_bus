// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LoginPageMotorista extends StatefulWidget {
  const LoginPageMotorista({Key? key}) : super(key: key);

  @override
  State<LoginPageMotorista> createState() => _LoginPageMotoristaState();
}

class _LoginPageMotoristaState extends State<LoginPageMotorista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        //login text
        children: [
          Icon(Icons.bus_alert, size: 40),
          Text('Login Motorista',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
          SizedBox(height: 50),

          //email textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    hintText: 'Email',
                    contentPadding: EdgeInsets.all(20.0)),
              ),
            ),
          ),
          SizedBox(height: 20),

          //password textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    hintText: 'Senha',
                    contentPadding: EdgeInsets.all(20.0)),
              ),
            ),
          ),
          SizedBox(height: 20),

          //login button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
            ),
          ),
          SizedBox(height: 25),
        ],
      ))),
    );
  }
}
