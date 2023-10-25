import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:connect_bus/widgets/button.dart';

class LoginMotoristaPage extends StatefulWidget {
  const LoginMotoristaPage({Key? key}) : super(key: key);

  @override
  State<LoginMotoristaPage> createState() => _LoginMotoristaPageState();
}

class _LoginMotoristaPageState extends State<LoginMotoristaPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passToggle = true;
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
                image: AssetImage('assets/images/driver_bus_background.jpg'),
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
      String textIfFieldEmpty, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? passToggle : false,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return textIfFieldEmpty;
        }
        return null;
      },
      decoration: InputDecoration(
        suffix: isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    passToggle = !passToggle;
                  });
                },
                child:
                    Icon(passToggle ? Icons.visibility : Icons.visibility_off),
              )
            : null,
        labelText: labelText,
        border: OutlineInputBorder(),
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

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email não cadastrado.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha incorreta.'),
          ),
        );
      }
    }
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
          signInWithEmailAndPassword();
        }
      },
    );
  }
}
