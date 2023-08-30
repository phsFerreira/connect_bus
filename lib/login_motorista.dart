import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connect_bus/screens/codigo_onibus.dart';

class LoginMotoristaPage extends StatefulWidget {
  const LoginMotoristaPage({Key? key}) : super(key: key);

  @override
  State<LoginMotoristaPage> createState() => _LoginMotoristaPageState();
}

class _LoginMotoristaPageState extends State<LoginMotoristaPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          MaterialPageRoute(builder: (context) => const CodigoOnibusPage()));
    }
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
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          )),
        ),
      ),
    );
  }
}
