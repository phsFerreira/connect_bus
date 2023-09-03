import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connect_bus/repositories/onibus_repository.dart';

class LinhaPage extends StatefulWidget {
  const LinhaPage({super.key, this.codigoOnibus});
  final String? codigoOnibus;

  @override
  State<LinhaPage> createState() => _LinhaPageState();
}

class _LinhaPageState extends State<LinhaPage> {
  var onibusRepository = OnibusRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text('Linhas'),
      ),
      body: _getLines(),
    );
  }

  _getLines() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getCard(
                'Linha 001 Azul',
                const Color.fromARGB(255, 3, 110, 197),
              ),
              _getCard(
                'Linha 002 (A) Laranja',
                const Color.fromRGBO(247, 124, 0, 1),
              ),
              _getCard(
                'Linha 002 (B) Laranja',
                const Color.fromRGBO(247, 124, 0, 1),
              ),
              _getCard(
                'Linha 003 Verde',
                const Color.fromRGBO(0, 176, 80, 1),
              ),
              _getCard('Linha 004 Vermelha', Colors.red),
              _getCard(
                'Linha 005 Coral',
                const Color.fromRGBO(255, 51, 153, 1),
              ),
              _getCard(
                'Linha 006 Lilas',
                const Color.fromRGBO(239, 25, 208, 1),
              ),
              _getCard(
                'Linha 007 (A) Expressa',
                const Color.fromARGB(255, 3, 110, 197),
              ),
              _getCard(
                'Linha 007 (B) Expressa',
                const Color.fromARGB(255, 3, 110, 197),
              ),
              _getCard(
                'Linha 008 Perimetral',
                const Color.fromRGBO(51, 51, 51, 1),
              ),
              _getCard(
                'Linha 009 Bronze',
                const Color.fromRGBO(217, 108, 31, 1),
              ),
              _getCard(
                'Linha 010 Prata',
                const Color.fromRGBO(95, 95, 95, 1),
              ),
              _getCard(
                'Linha 011 Turistica',
                const Color.fromRGBO(116, 85, 189, 1),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Função responsável por gerar um card com o nome na linha no centro.
  _getCard(String nomeLinha, Color colorCard) {
    return GestureDetector(
      onTap: () {
        _onTapLine(nomeLinha);
      },
      child: Card(
        color: colorCard,
        child: SizedBox(
          height: 100,
          child: Center(
            child: Text(
              nomeLinha,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Função responsavel por exibir um Toast e
  /// chamar função para atualizar a linha do onibus no Firebase.
  void _onTapLine(String nomeLinha) {
    Fluttertoast.showToast(
        msg: '$nomeLinha selecionada',
        fontSize: 19,
        gravity: ToastGravity.CENTER);

    onibusRepository.updateLinhaOnibus(widget.codigoOnibus!, nomeLinha);
  }
}
