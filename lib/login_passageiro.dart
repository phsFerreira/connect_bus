// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:connect_bus/cadastro_passageiro.dart';
import 'package:connect_bus/maps.dart';
import 'package:connect_bus/passageiro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email = "", senha = "", nomePassageiro="";

  //methods
  
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
                      key: ValueKey('emailField'),
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
                      key: ValueKey('passwordField'),
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
                    onTap: () async {
                      email=emailController.text;
                      senha=passwordController.text;
                      
                      if(await loginPassageiro(email, senha)){
                        nomePassageiro= await buscaNomePassageiro(email);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MapSample(), settings: RouteSettings(arguments: ScreenArguments(email, nomePassageiro))));
                      }else{
                        Fluttertoast.showToast(msg: "error");
                      }
                    },
                    child: Container(
                      key: ValueKey('loginButton'),
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

                //create account button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CadastroPassageiroForm()));
                    },
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenArguments{
  final String email;
  final String nome;

  ScreenArguments(this.email, this.nome);
}
