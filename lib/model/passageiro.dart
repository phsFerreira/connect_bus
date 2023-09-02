//import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

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

  set setCpf(String cpf) {
    this.cpf = cpf;
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
    var db = FirebaseFirestore.instance;

    Map<String, String> passageiros = {
      'nomeCompleto': nomeCompleto,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'senha': senha,
    };

    db.collection('Usuarios').doc(email).set(passageiros);
  }

  static Passageiro fromJson(Map<String, dynamic> json) => Passageiro(
      nomeCompleto: json['nomeCompleto'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      email: json['email'],
      senha: json['cpf']);
}

Future<String> buscaNomePassageiro(String email) async {
  String emailBusca = email;
  String nome = "";

  var collection = FirebaseFirestore.instance.collection('Usuarios');
  var docSnapshot = await collection.doc(emailBusca).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    nome = data?['nomeCompleto'];
  }
  return nome;
}

Future<Passageiro> buscaPassageiro(String email) async {
  String emailBusca = email;
  Passageiro passageiroBusca =
      Passageiro(nomeCompleto: "", cpf: "", telefone: "", email: "", senha: "");

  var collection = FirebaseFirestore.instance.collection('Usuarios');
  var docSnapshot = await collection.doc(emailBusca).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    passageiroBusca.nomeCompleto = data?['nomeCompleto'];
    passageiroBusca.cpf = data?['cpf'];
    passageiroBusca.telefone = data?['telefone'];
    passageiroBusca.email = data?['email'];
    passageiroBusca.senha = data?['senha'];
  }

  return passageiroBusca;
}

Future<bool> loginPassageiro(String email, String senha) async {
  String emailBusca = email;

  var collection = FirebaseFirestore.instance.collection('Usuarios');
  var docSnapshot = await collection.doc(emailBusca).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    String emailLogin = data?['email'];
    String senhaLogin = data?['senha'];

    if (emailLogin == email && senhaLogin == senha) {
      // Fluttertoast.showToast(
      //     msg: "logado com sucesso.", toastLength: Toast.LENGTH_LONG);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "Email ou senha incorretos.", toastLength: Toast.LENGTH_LONG);
      return false;
    }
  } else {
    Fluttertoast.showToast(
        msg: "Usuário não cadastrado.", toastLength: Toast.LENGTH_LONG);
    return false;
  }
}

Future<Passageiro> updatePassageiro(Passageiro passageiro) async {
  Passageiro passageiroUpdate = passageiro;
  String emailBusca = passageiroUpdate.email;

  var collection = FirebaseFirestore.instance.collection('Usuarios');
  var docSnapshot = await collection.doc(emailBusca).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    String emailUpdate = data?['email'];

    if (emailUpdate == emailBusca) {}
  }

  return passageiro;
}
