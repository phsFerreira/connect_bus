import 'package:brasil_fields/brasil_fields.dart';
import 'package:connect_bus/model/passageiro.dart';
import 'package:connect_bus/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                Image.asset('assets/images/bus-icon.png', height: 90),

                //nome completo
                SizedBox(
                  width: 360,
                  child: CampoForm(
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
                ),

                //CPF
                SizedBox(
                  width: 360,
                  child: CampoForm(
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
                ),

                //telefone
                SizedBox(
                  width: 360,
                  child: CampoForm(
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
                ),

                //email
                SizedBox(
                  width: 360,
                  child: CampoForm(
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
                ),

                //senha
                SizedBox(
                  width: 360,
                  child: CampoForm(
                    controller: passwordController,
                    isPassword: true,
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
