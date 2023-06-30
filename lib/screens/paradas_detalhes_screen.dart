import 'package:flutter/material.dart';

import 'package:connect_bus/model/horario.dart';
import 'package:connect_bus/model/parada.dart';
import 'package:connect_bus/repositories/horarios_repository.dart';

/// Tela que mostra os horários da parada de ônibus, de acordo com o bairro que ela está.

class ParadaDetalhesScreen extends StatefulWidget {
  final Parada parada;

  const ParadaDetalhesScreen({super.key, required this.parada});

  @override
  State<ParadaDetalhesScreen> createState() => _ParadaDetalhesScreenState();
}

class _ParadaDetalhesScreenState extends State<ParadaDetalhesScreen> {
  List<Horario> listLinhas = [];

  @override
  Widget build(BuildContext context) {
    // Obtendo os horários a partir do nome do bairro.
    getHorarios(widget.parada.bairro);

    // SE a lista de horarios estiver vazia, retorne uma tela
    // mostrando mensagem "Sem horarios".
    if (listLinhas.isEmpty) {
      return const Scaffold(
        body: Center(
            child: Text(
          textAlign: TextAlign.center,
          'Ainda não tem horários para este bairro :c',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text('Parada'),
      ),

      // Lista de Horários
      body: SingleChildScrollView(
        // Coluna de ExpansionTiles
        child: Column(children: [
          for (var linha in listLinhas)
            ExpansionTile(
                title: Text(linha.linha!),
                subtitle: Text(linha.diaDeFuncionamento!),
                controlAffinity: ListTileControlAffinity.leading,
                children: [
                  // Horarios de partida do Bairro
                  const ListTile(
                    tileColor: Colors.amber,
                    title: Text('Partida Bairro',
                        style: TextStyle(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center),
                  ),
                  for (var horaBairro in linha.horaPartidaBairro!)
                    ListTile(
                      title: Text(horaBairro, textAlign: TextAlign.center),
                    ),

                  // Horarios de partida da Rodoviaria
                  const ListTile(
                    tileColor: Colors.amber,
                    title: Text('Partida Rodoviária',
                        style: TextStyle(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center),
                  ),
                  for (var horaRodoviaria in linha.horaPartidaRodoviaria!)
                    ListTile(
                      title: Text(horaRodoviaria, textAlign: TextAlign.center),
                    ),
                ]),
        ]),
      ),
    );
  }

  void getHorarios(String nomeBairro) async {
    var horariosRepository = HorariosRepository();
    List<Horario> listLinhasHorarios =
        await horariosRepository.findByBairroName(nomeBairro);

    // `mounted` se Widget já estiver "montado" na tela, então
    // setState() reconstrói a tela com `listLinhas` recebendo um novo valor.
    if (mounted) {
      setState(() {
        listLinhas = listLinhasHorarios;
      });
    }
  }
}
