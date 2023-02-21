// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_bus/cadastro_passageiro.dart';
import 'package:connect_bus/home_page.dart';
import 'package:connect_bus/screens/maps.dart';
import 'package:connect_bus/profile_motorista.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPageMotorista extends StatefulWidget {
  const LoginPageMotorista({Key? key}) : super(key: key);

  @override
  State<LoginPageMotorista> createState() => _LoginPageMotoristaState();
}

class _LoginPageMotoristaState extends State<LoginPageMotorista> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    if (emailController.text.isEmpty | passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Preencha todos os campos.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.black);
    } else {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MotoristaPage()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //login text
              children: [
                Icon(
                  Icons.bus_alert,
                  size: 40,
                ),
                Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                SizedBox(height: 50),

                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
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
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          hintText: 'Senha',
                          contentPadding: EdgeInsets.all(20.0)),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GestureDetector(
                    onTap: signIn,
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
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
