//import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Passageiro {
  String nomeCompleto = "";
  String cpf = "";
  String telefone = "";
  String email = "";
  String senha = "";

  Passageiro(
      {required this.nomeCompleto,
      required this.cpf,
      required this.telefone,
      required this.email,
      required this.senha});

  set setNomeCompleto(String nomeCompleto) {
    this.nomeCompleto = nomeCompleto;
  }

  String get getNomeCompleto {
    return nomeCompleto;
  }

  set setCpf(String CPF) {
    this.cpf = CPF;
  }

  String get getCpf {
    return cpf;
  }

  set setTelefone(String telefone) {
    this.telefone = telefone;
  }

  String get getTelefone {
    return telefone;
  }

  set setEmail(String email) {
    this.email = email;
  }

  String get getEmail {
    return email;
  }

  set setSenha(String senha) {
    this.senha = senha;
  }

  String get getSenha {
    return senha;
  }

  void registrarPassageiro() {
    late DatabaseReference db;
    db = FirebaseDatabase.instance.ref().child('Usuarios');

    Map<String, String> passageiros = {
      'nomeCompleto': nomeCompleto,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'senha': senha,
    };
    db.push().set(passageiros);
  }

  // signup(Passageiro passageiro, AuthCredential authCredential) async {}

  // // void login(String emailTeste, String senha){
  // //   FirebaseFirestore db=FirebaseFirestore.instance;

  // //   db.collection('ConnectBus-Usuarios').where('email', isEqualTo: emailTeste).get().then((doc) {
  // //     if(doc!=){

  // //     }
  // //   });
  // // }

  // void login(String email, String senha) {
  //   late DatabaseReference db;
  //   db = FirebaseDatabase.instance.ref().child('Usuarios');

  //   Query query = FirebaseDatabase.instance
  //       .ref()
  //       .child('Usuarios')
  //       .orderByChild('email')
  //       .equalTo('teste');

  //   // db.orderByChild("email").equalTo("pedro.ferreirasilva777@gmail.com");

  //   // const q=query(db.orderByChild("email").equalTo("pedro.ferreirasilva777@gmail.com"));

  //   // final usuariosRef=FirebaseDatabase.instance.ref().child('Usuarios');
  //   // final query=usuariosRef.where("email", isEqualTo: "teste");
  // }
}
