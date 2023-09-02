import 'package:flutter/material.dart';

import 'package:connect_bus/campo_form.dart';
import 'package:connect_bus/extensoes.dart';
import 'package:connect_bus/pages/passageiro/login_passageiro.dart';
import 'package:connect_bus/model/passageiro.dart';
import 'package:connect_bus/widgets/button.dart';

class CadastroPassageiroPage extends StatefulWidget {
  const CadastroPassageiroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPassageiroPage> createState() => _CadastroPassageiroPageState();
}

class _CadastroPassageiroPageState extends State<CadastroPassageiroPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: _getForm(),
        ),
      ),
    );
  }

  _getForm() {
    String nome = "";
    String cpf = "";
    String telefone = "";
    String email = "";
    String senha = "";
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: OverflowBar(
          overflowSpacing: 15,
          children: <Widget>[
            _getText(),

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

            _getButtonNext(nome, cpf, telefone, email, senha),
            _getButtonBack(),
          ],
        ),
      ),
    );
  }

  _getText() {
    return const Text(
      'Cadastro de Passageiro',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }

  _getButtonNext(
      String nome, String cpf, String telefone, String email, String senha) {
    return ButtonWidget(
      textButton: 'AVANÇAR',
      colorTextButton: Colors.white,
      widthButton: double.infinity,
      borderButton: Colors.black,
      backgroundButton: Colors.black,
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
              MaterialPageRoute(builder: (_) => const LoginPassageiroPage()));
        }
      },
    );
  }

  _getButtonBack() {
    return ButtonWidget(
      textButton: 'VOLTAR',
      colorTextButton: Colors.black,
      widthButton: double.infinity,
      borderButton: Colors.black,
      backgroundButton: Colors.white,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
