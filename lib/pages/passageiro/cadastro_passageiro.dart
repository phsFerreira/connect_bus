import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connect_bus/campo_form.dart';
import 'package:connect_bus/extensoes.dart';
import 'package:connect_bus/model/passageiro.dart';
import 'package:connect_bus/pages/passageiro/pages/mapa/paradas_screen.dart';
import 'package:connect_bus/widgets/button.dart';

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
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await insertPassageiro();
        }
      },
    );
  }

  Future<void> insertPassageiro() async {
    Passageiro passageiro = Passageiro(
        nomeCompleto: nameController.text,
        cpf: cpfController.text,
        telefone: phoneController.text,
        email: emailController.text,
        senha: passwordController.text);

    bool cpfDuplicated = await cpfDuplicado(passageiro.cpf);

    bool emailDuplicated = await emailDuplicado(passageiro.email);

    if (cpfDuplicated == false && emailDuplicated == false) {
      var docPassageiro = await passageiro.registrarPassageiro();
      passageiro.docID = docPassageiro.id;
      print(passageiro.docID);

      Fluttertoast.showToast(
          msg: "Cadastro realizado com sucesso.",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 19,
          backgroundColor: Colors.green.shade900,
          gravity: ToastGravity.CENTER);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ParadasScreen(
                passageiro: passageiro,
              )));
    } else if (cpfDuplicated == true) {
      Fluttertoast.showToast(
          msg: "CPF já cadastrado.",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 19,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER);
    } else if (emailDuplicated == true) {
      Fluttertoast.showToast(
          msg: "Email já cadastrado.",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 19,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER);
    }
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
