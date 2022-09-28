// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_bus/campo_form.dart';
import 'package:connect_bus/extensoes.dart';
import 'package:connect_bus/login_passageiro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'pessoa.dart';

class CadastroPassageiroForm extends StatefulWidget {
  const CadastroPassageiroForm({Key? key}) : super(key: key);

  @override
  State<CadastroPassageiroForm> createState() => _CadastroPassageiroFormState();
}

class _CadastroPassageiroFormState extends State<CadastroPassageiroForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomeController;
    final TextEditingController cpfController;
    final TextEditingController telefoneController;
    final TextEditingController emailController;
    final TextEditingController senhaControoler;

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
                        if (value!.isValidName) {
                          return 'digite um nome válido.';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    //CPF
                    CampoForm(
                      hintText: 'CPF',
                      validator: (value) {
                        if (value!.isValidCPF) {
                          return 'digite um cpf válido.';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    //telefone
                    CampoForm(
                      hintText: 'Telefone',
                      validator: (value) {
                        if (value!.isValidPhone) {
                          return 'digite um telefone válido.';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    //email
                    CampoForm(
                      hintText: 'E-mail',
                      validator: (value) {
                        if (value!.isValidEmail) {
                          return 'digite um email valido';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    //senha
                    CampoForm(
                      hintText: 'Senha',
                      validator: (value) {
                        if (value!.isValidPassword) {
                          return 'digite uma senha válida';
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black, minimumSize: Size(400, 50)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
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
