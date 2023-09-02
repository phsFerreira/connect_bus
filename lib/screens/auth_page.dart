import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:connect_bus/login_motorista.dart';
import 'package:connect_bus/screens/codigo_onibus.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return const CodigoOnibusPage();
            } else {
              return const LoginMotoristaPage();
            }
          }),
    );
  }
}
