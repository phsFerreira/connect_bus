import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connect_bus/cadastro_passageiro.dart';
import 'package:connect_bus/passageiro.dart';
import 'package:connect_bus/screens/paradas_screen.dart';
import 'package:connect_bus/widgets/button.dart';

class LoginPassageiroPage extends StatefulWidget {
  const LoginPassageiroPage({Key? key}) : super(key: key);

  @override
  State<LoginPassageiroPage> createState() => _LoginPassageiroPageState();
}

class _LoginPassageiroPageState extends State<LoginPassageiroPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email = "", senha = "", nomePassageiro = "";

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
      body: _getForm(),
    );
  }

  _getForm() {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/passenger_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color.fromRGBO(255, 255, 255, 0.7),
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: OverflowBar(
                  overflowSpacing: 20,
                  children: [
                    // _getIcon(),
                    _getTextLogin(),
                    _getTextFormField(
                        emailController, 'Email', 'Email vazio', false),
                    _getTextFormField(
                        passwordController, 'Senha', 'Senha vazia', true),
                    _getButtonLogin(),
                    _getButtonCreateAccount(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getIcon() {
    return const Icon(
      Icons.bus_alert,
      size: 40,
    );
  }

  _getTextLogin() {
    return const Text(
      'Login',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
    );
  }

  _getTextFormField(TextEditingController? controller, String labelText,
      String textIfFieldEmpty, bool obscureText) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return textIfFieldEmpty;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 2, style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 2, style: BorderStyle.solid),
        ),
      ),
    );
  }

  _getButtonLogin() {
    return ButtonWidget(
      textButton: 'LOGIN',
      colorTextButton: Colors.white,
      widthButton: double.infinity,
      borderButton: Colors.black,
      backgroundButton: Colors.black,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          signIn();
        }
      },
    );
  }

  Future signIn() async {
    email = emailController.text;
    senha = passwordController.text;

    try {
      var loginSuccess = await loginPassageiro(email, senha);
      print('Login deu sucesso? ===> $loginSuccess');

      if (loginSuccess) {
        nomePassageiro = await buscaNomePassageiro(email);
        _pageRedirect();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "error ==> $e");
    }
  }

  _getButtonCreateAccount() {
    return ButtonWidget(
      textButton: 'CRIAR CONTA',
      colorTextButton: Colors.black,
      widthButton: double.infinity,
      borderButton: Colors.black,
      backgroundButton: Colors.white,
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CadastroPassageiroPage()));
      },
    );
  }

  void _pageRedirect() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ParadasScreen(),
        settings: RouteSettings(
          arguments: ScreenArguments(email, nomePassageiro),
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
