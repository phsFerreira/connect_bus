// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_bus/campo_form.dart';
import 'package:connect_bus/extensoes.dart';
import 'package:connect_bus/login_passageiro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'passageiro.dart';

class CadastroPassageiroForm extends StatefulWidget {
  const CadastroPassageiroForm({Key? key}) : super(key: key);

  @override
  State<CadastroPassageiroForm> createState() => _CadastroPassageiroFormState();
}

class _CadastroPassageiroFormState extends State<CadastroPassageiroForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // // ignore: valid_regexps
    // final RegExp nameRegExp = RegExp(r'[!@#<>?"/·:_`~;[]\\|=+)(*&^%0-9-]');

    String nome = "";
    String cpf = "";
    String telefone = "";
    String email = "";
    String senha = "";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    //texto
                    Text(
                      'Cadastro de Passageiro',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(height: 30),

                    //nome completo
                    CampoForm(
                      hintText: 'Nome Completo',
                      validator: (value) {
                        nome = value.toString();
                        if (nome.isEmpty) {
                          return 'Digite seu nome.';
                        } else if (nome.isValidName) {
                          return 'Digite um nome válido.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    //CPF
                    CampoForm(
                      hintText: 'CPF',
                      validator: (value) {
                        cpf = value.toString();
                        if (cpf.isEmpty) {
                          return 'Digite seu CPF.';
                        } else if (cpf.isValidCPF) {
                          return 'Digite um CPF válido.';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    //telefone
                    CampoForm(
                      hintText: 'Telefone',
                      validator: (value) {
                        telefone = value.toString();
                        if (telefone.isEmpty) {
                          return 'Digite seu telefone.';
                        } else if (telefone.isValidPhone) {
                          return 'Digite um telefone válido.';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    //email
                    CampoForm(
                      hintText: 'E-mail',
                      validator: (value) {
                        email = value.toString();
                        if (email.isEmpty) {
                          return 'Digite seu email.';
                        } else if (email.isValidEmail) {
                          return 'Digite um email valido';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    //senha
                    CampoForm(
                      hintText: 'Senha',
                      validator: (value) {
                        senha = value.toString();
                        if (senha.isEmpty) {
                          return 'Digite sua senha.';
                        }
                        if (senha.isValidPassword) {
                          return 'Digite uma senha válida';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black, minimumSize: Size(400, 50)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Passageiro passageiro = Passageiro(
                                nomeCompleto: nome,
                                cpf: cpf,
                                telefone: telefone,
                                email: email,
                                senha: senha);

                            passageiro.registrarPassageiro();

                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          }
                        },
                        child: Text(
                          'Avançar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ))
                  ],
                ),
              )),
        ),
      )),
    );
  }
}
