// ignore_for_file: prefer_const_constructors

import 'package:connect_bus/campo_form.dart';
import 'package:connect_bus/login_passageiro.dart';
import 'package:flutter/material.dart';
import 'parada.dart';

class CadastroParadaForm extends StatefulWidget {
  const CadastroParadaForm({super.key});

  @override
  State<CadastroParadaForm> createState() => _CadastroParadaFormState();
}

class _CadastroParadaFormState extends State<CadastroParadaForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String endereco = "";
    String complemento = "";

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  Text("Cadastro de Paradas"),
                  SizedBox(
                    height: 30,
                  ),
                  CampoForm(
                    hintText: 'Endereço',
                    validator: (value) {
                      endereco = value.toString();
                      if (endereco.isEmpty) {
                        return 'Digite o endereço.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CampoForm(
                    hintText: 'idOnibus',
                    validator: (value) {
                      complemento = value.toString();
                      if (endereco.isEmpty) {
                        return 'Digite o endereço.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black, minimumSize: Size(400, 50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Parada parada = Parada(
                              endereco: endereco, complemento: complemento);

                          parada.registrarParada();
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
                      )),
                ],
              ),
            )),
      )),
    );
  }
}
