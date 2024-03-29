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
  late HorariosRepository horariosRepository;

  // Método responsável para inicialização dos dados
  // que serão exibidos na tela.
  @override
  void initState() {
    super.initState();
    horariosRepository = HorariosRepository();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getHorarios(widget.parada.bairro!);
    });
  }

  @override
  Widget build(BuildContext context) {
    // SE a lista de horarios estiver vazia, retorne uma tela
    // mostrando mensagem "Sem horarios".
    if (listLinhas.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 106, 212),
        title:
            const Text('Parada', style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),

      // Lista de Horários
      body: SingleChildScrollView(
        child: Column(children: [
          // Nome do Bairro
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(widget.parada.bairro!,
                style: const TextStyle(fontSize: 25)),
          ),
          // Coluna de ExpansionTiles
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

  ///  Obtendo os horários a partir do nome do bairro.
  getHorarios(String nomeBairro) async {
    List<Horario> listLinhasHorarios =
        await horariosRepository.findByBairroName(nomeBairro);
    setState(() {
      listLinhas = listLinhasHorarios;
    });
  }
}
