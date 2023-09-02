import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:connect_bus/pages/motorista/login_motorista.dart';
import 'package:connect_bus/pages/motorista/pages/codigo_onibus.dart';

/// Controlador de Login, responsável por deixar o motorista logado no app,
/// (funcionalidade fornecida pelo [FirebaseAuth]).

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Enquanto estiver conectando ao Firebase, exiba um icone de carregamento.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            // Caso já Motorista ja tenha efetuado o login e não realizado o logout,
            // irá redirecioná-lo para a pagina de codigo do onibus.
            else if (snapshot.hasData) {
              return const CodigoOnibusPage();
            }
            // Caso Motorista não tenha realizado login nenhum vez no app,
            // ou caso o Motorista clique do botão de logout em [HomeMotoristaPage]
            //então o rediciona para a pagina de login.
            else {
              return const LoginMotoristaPage();
            }
          }),
    );
  }
}
