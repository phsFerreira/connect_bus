// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:connect_bus/passageiro.dart';
import 'package:flutter/material.dart';
import 'package:connect_bus/profile_widget.dart';
import 'package:connect_bus/campo_form.dart';
import 'package:connect_bus/extensoes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PassageiroPage extends StatefulWidget {
  const PassageiroPage({super.key});

  @override
  State<PassageiroPage> createState() => _PassageiroPageState();
}

class _PassageiroPageState extends State<PassageiroPage> {
  @override
  Widget build(BuildContext context) {
    //final args=ModalRoute.of(context)!.settings.arguments as String;

    // Passageiro passageiroLogado;

    // passageiroLogado=buscaPassageiro(args) as Passageiro;

    String nome = "";
    String cpf = "";
    String telefone = "";
    String email = "";
    String senha = "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                'teste',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(height: 30),
            ProfileWidget(
              imagePath:
                  "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg",
              width: 90,
              height: 90,
            ),
            SizedBox(height: 40),

            //nome completo
            SizedBox(
              width: 360,
              child: CampoForm(
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
            ),
            SizedBox(height: 20),

            //CPF
            IgnorePointer(
              child: SizedBox(
                width: 360,
                child: CampoForm(
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
              ),
            ),
            SizedBox(height: 20),

            //telefone
            SizedBox(
              width: 360,
              child: CampoForm(
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
            ),
            SizedBox(height: 20),

            //email
            SizedBox(
              width: 360,
              child: CampoForm(
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
            ),
            SizedBox(height: 20),

            //senha
            SizedBox(
              width: 360,
              child: CampoForm(
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
            ),
            SizedBox(height: 20),

            //voltar button
            SizedBox(
              width: 360,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Preencha todos os campos.",
                        toastLength: Toast.LENGTH_LONG);
                  },
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
