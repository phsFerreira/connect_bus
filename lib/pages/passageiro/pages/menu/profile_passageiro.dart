import 'package:connect_bus/model/passageiro.dart';
import 'package:connect_bus/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connect_bus/campo_form.dart';
import 'package:connect_bus/extensoes.dart';

class PassageiroPage extends StatefulWidget {
  const PassageiroPage({super.key, required this.passageiro});
  final Passageiro passageiro;

  @override
  State<PassageiroPage> createState() => _PassageiroPageState();
}

class _PassageiroPageState extends State<PassageiroPage> {
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
  void initState() {
    nameController.text = widget.passageiro.nomeCompleto;
    cpfController.text = widget.passageiro.cpf;
    phoneController.text = widget.passageiro.telefone;
    emailController.text = widget.passageiro.email;
    passwordController.text = widget.passageiro.senha;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String nome = "";
    String cpf = "";
    String telefone = "";
    String email = "";
    String senha = "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 106, 212),
        title: const Text('Seu Perfil',
            style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Form(
            key: _formKey,
            child: OverflowBar(
              overflowAlignment: OverflowBarAlignment.center,
              overflowSpacing: 20,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 90,
                ),

                //nome completo
                SizedBox(
                  width: 360,
                  child: CampoForm(
                    controller: nameController,
                    hintText: 'Nome Completo',
                    isPassword: false,
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

                //CPF
                SizedBox(
                  width: 360,
                  child: CampoForm(
                    controller: cpfController,
                    hintText: 'CPF',
                    isPassword: false,
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

                //telefone
                SizedBox(
                  width: 360,
                  child: CampoForm(
                    controller: phoneController,
                    hintText: 'Telefone',
                    isPassword: false,
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

                //email
                SizedBox(
                  width: 360,
                  child: CampoForm(
                    controller: emailController,
                    hintText: 'E-mail',
                    isPassword: false,
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

                //senha
                SizedBox(
                  width: 360,
                  child: CampoForm(
                    controller: passwordController,
                    hintText: 'Senha',
                    isPassword: true,
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

                //voltar button
                ButtonWidget(
                    textButton: "SALVAR",
                    colorTextButton: Colors.white,
                    widthButton: 360,
                    borderButton: Colors.black,
                    backgroundButton: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Atualizando dados do usuario...');
                        Passageiro passageiroEdited = Passageiro(
                          nomeCompleto: nameController.text,
                          cpf: cpfController.text,
                          telefone: phoneController.text,
                          email: emailController.text,
                          senha: passwordController.text,
                          docID: widget.passageiro.docID,
                        );

                        updatePassageiro(passageiroEdited);
                      }
                    }),

                ButtonWidget(
                    textButton: "APAGAR CONTA",
                    colorTextButton: Colors.white,
                    widthButton: 200,
                    borderButton: Color.fromARGB(255, 180, 18, 18),
                    backgroundButton: Color.fromARGB(255, 180, 18, 18),
                    onPressed: () async {
                      bool deleteSuccess =
                          await deletePassageiro(widget.passageiro.docID!);
                      if (deleteSuccess) {
                        Navigator.of(context).pushReplacementNamed('/main');
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
