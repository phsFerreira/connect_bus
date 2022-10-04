// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'passageiro.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   //database
//   late DatabaseReference db;

//   @override
//   void initState() {
//     super.initState();
//     db = FirebaseDatabase.instance.ref().child('ConnectBus-Usuarios');
//   }

//   final nomeController = TextEditingController();
//   final cpfController = TextEditingController();
//   final enderecoControler = TextEditingController();
//   final telefoneController = TextEditingController();
//   final nomeUsuarioController = TextEditingController();
//   final emailController = TextEditingController();
//   final senhaController = TextEditingController();

//   // void registrarPassageiro() {
//   //   Map<String, String> passageiros = {
//   //     'nomeCompleto': nomeController.text.toString().trim(),
//   //     'cpf': cpfController.text.toString().trim(),
//   //   };
//   //   db.push().set(passageiros);
//   }

//   // // Pessoa pessoaToAdd = Pessoa(
//   // //   nome: "teste",
//   // //   CPF: "12345",
//   // //   telefone: "1413234",
//   // //   nomeUsuario: "testePessoa",
//   // //   email: "teste@gmai.com",
//   // //   senha: "teste123",
//   // // );

//   // void addPessoaBanco() {
//   //   FirebaseFirestore.instance.collection("Pessoas").add(pessoaToAdd.toMap());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//           child: Center(
//               child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,

//           //Register text
//           children: [
//             Text(
//               'Cadastro Passageiro',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//             ),
//             SizedBox(height: 50),

//             //name textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.white),
//                 child: TextField(
//                   controller: nomeController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1)),
//                       hintText: 'Nome Completo',
//                       contentPadding: EdgeInsets.all(20.0)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             //CPF textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.white),
//                 child: TextField(
//                   controller: cpfController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1)),
//                       hintText: 'CPF',
//                       contentPadding: EdgeInsets.all(20.0)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             //address textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.white),
//                 child: TextField(
//                   controller: enderecoControler,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1)),
//                       hintText: 'Endereço',
//                       contentPadding: EdgeInsets.all(20.0)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             //email textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.white),
//                 child: TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1)),
//                       hintText: 'Email',
//                       contentPadding: EdgeInsets.all(20.0)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             //password textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.white),
//                 child: TextField(
//                   controller: senhaController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1)),
//                       hintText: 'Senha',
//                       contentPadding: EdgeInsets.all(20.0)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             //confirm password textfield
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.white),
//                 child: TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1)),
//                       hintText: 'Senha',
//                       contentPadding: EdgeInsets.all(20.0)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             //register button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: GestureDetector(
//                 onTap: () => Fluttertoast.showToast(
//                     msg: 'clicou',
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.BOTTOM,
//                     backgroundColor: Colors.grey,
//                     textColor: Colors.black),
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.all(Radius.circular(12))),
//                   child: Center(
//                     child: Text('Avançar',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18)),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ))),
//     );
//   }
// }
