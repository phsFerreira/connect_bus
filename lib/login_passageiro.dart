import 'package:connect_bus/screens/paradas_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connect_bus/cadastro_passageiro.dart';
import 'package:connect_bus/passageiro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email = "", senha = "", nomePassageiro = "";

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
                const Icon(
                  Icons.bus_alert,
                  size: 40,
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                const SizedBox(height: 50),

                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: TextField(
                      key: const ValueKey('emailField'),
                      controller: emailController,
                      decoration: const InputDecoration(
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
                const SizedBox(height: 20),

                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: TextField(
                      key: const ValueKey('passwordField'),
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
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
                const SizedBox(height: 20),

                //login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GestureDetector(
                    onTap: () async {
                      email = emailController.text;
                      senha = passwordController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapSample(),
                          settings: RouteSettings(
                            arguments: ScreenArguments(email, nomePassageiro),
                          ),
                        ),
                      );

                      // if (await loginPassageiro(email, senha)) {
                      //   nomePassageiro = await buscaNomePassageiro(email);
                      // } else {
                      //   Fluttertoast.showToast(msg: "error");
                      // }
                    },
                    child: Container(
                      key: const ValueKey('loginButton'),
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: const Center(
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
                const SizedBox(height: 25),

                //create account button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const CadastroPassageiroForm()));
                    },
                    child: const Text(
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

class ScreenArguments {
  final String email;
  final String nome;

  ScreenArguments(this.email, this.nome);
}
