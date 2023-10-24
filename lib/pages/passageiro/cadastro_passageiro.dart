import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import 'package:connect_bus/campo_form.dart';
import 'package:connect_bus/extensoes.dart';
import 'package:connect_bus/pages/passageiro/login_passageiro.dart';
import 'package:connect_bus/model/passageiro.dart';
import 'package:connect_bus/widgets/button.dart';
import 'package:flutter/services.dart';

class CadastroPassageiroPage extends StatefulWidget {
  const CadastroPassageiroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPassageiroPage> createState() => _CadastroPassageiroPageState();
}

class _CadastroPassageiroPageState extends State<CadastroPassageiroPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cpfController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              controller: nameController,
              hintText: 'Nome Completo',
              isPassword: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Digite seu nome.';
                } else if (value.isValidName) {
                  return 'Digite um nome válido.';
                }
                return null;
              },
            ),

            //CPF
            CampoForm(
              controller: cpfController,
              hintText: 'CPF',
              isPassword: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
              validator: (value) {
                bool cpfValid = UtilBrasilFields.isCPFValido(value);

                if (value!.isEmpty) {
                  return 'Digite seu CPF.';
                } else if (cpfValid == false) {
                  return 'Digite um CPF válido.';
                }
                return null;
              },
            ),

            //telefone
            CampoForm(
              controller: phoneController,
              isPassword: false,
              hintText: 'Telefone',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Digite seu telefone.';
                } else if (value.isValidPhone) {
                  return 'Digite um telefone válido.';
                }
                return null;
              },
            ),

            //email
            CampoForm(
              controller: emailController,
              isPassword: false,
              hintText: 'E-mail',
              validator: (value) {
                // Coloquei o Regex aqui porque no arquivo extensoes.dart nao estava funcionando.
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!);
                if (value.isEmpty) {
                  return 'Digite seu email.';
                } else if (emailValid == false) {
                  return 'Digite um email valido';
                }
                return null;
              },
            ),

            //senha
            CampoForm(
              controller: passwordController,
              isPassword: false,
              hintText: 'Senha',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Digite sua senha.';
                } else if (value.isValidPassword) {
                  return 'Digite uma senha válida';
                }
                return null;
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
              nomeCompleto: nameController.text,
              cpf: cpfController.text,
              telefone: phoneController.text,
              email: emailController.text,
              senha: passwordController.text);

          print(passageiro.cpf);

          // passageiro.registrarPassageiro();

          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (_) => const LoginPassageiroPage()));
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
