// import 'package:connect_bus/cadastroPassageiro.dart';
// import 'package:connect_bus/login_passageiro.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:connect_bus/home_page.dart';
// import 'package:connect_bus/cadastro_passageiro.dart';

// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return const HomePage();
//           } else {
//             return CadastroPassageiroForm();
//           }
//         },
//       ),
//     );
//   }
// }
