import 'package:connect_bus/screens/paradas_screen.dart';
import 'package:flutter/material.dart';

import 'package:connect_bus/cadastro_passageiro.dart';

class LoginPassageiroPage extends StatefulWidget {
  const LoginPassageiroPage({Key? key}) : super(key: key);

  @override
  State<LoginPassageiroPage> createState() => _LoginPassageiroPageState();
}

class _LoginPassageiroPageState extends State<LoginPassageiroPage> {
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getIcon(),
                _getTextLogin(),
                const SizedBox(height: 50),
                _getTextField(emailController, 'Email', false),
                const SizedBox(height: 20),
                _getTextField(passwordController, 'Senha', true),
                const SizedBox(height: 20),
                _getButtonLogin(),
                const SizedBox(height: 25),
                _getButtonCreateAccount(),
              ],
            ),
          ),
        ),
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

  _getTextField(
      TextEditingController? controller, String hintText, bool obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.black, width: 1)),
              hintText: hintText,
              contentPadding: const EdgeInsets.all(20.0)),
        ),
      ),
    );
  }

  _getButtonLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: signIn,
        child: Container(
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
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    email = emailController.text;
    senha = passwordController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ParadasScreen(),
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
  }

  _getButtonCreateAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const CadastroPassageiroPage()));
        },
        child: const Text(
          'Criar Conta',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
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
