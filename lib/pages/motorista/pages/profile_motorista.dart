import 'package:flutter/material.dart';

import 'package:connect_bus/model/onibus.dart';
import 'package:connect_bus/repositories/onibus_repository.dart';

class ProfileMotorista extends StatefulWidget {
  const ProfileMotorista({super.key, required this.codigoOnibus});
  final String codigoOnibus;

  @override
  State<ProfileMotorista> createState() => _ProfileMotoristaState();
}

class _ProfileMotoristaState extends State<ProfileMotorista> {
  Onibus onibusAtual = Onibus(estadoFisico: "Normal", linha: "Linha");
  late OnibusRepository onibusRepository;

  @override
  void initState() {
    super.initState();

    onibusRepository = OnibusRepository();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOnibus(widget.codigoOnibus);
    });
  }

  getOnibus(String codigoOnibus) async {
    List onibusFound = await onibusRepository.findByCodigoOnibus(codigoOnibus);
    Onibus onibuss = Onibus();

    if (onibusFound.isNotEmpty) {
      for (var onibus in onibusFound) {
        print('${onibus.id} ===> ${onibus.data()}');
        onibuss.estadoFisico = onibus.data()['estadoFisico'];
        onibuss.linha = onibus.data()['linha'];
      }
    }
    setState(() {
      onibusAtual = onibuss;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 230),
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text('Perfil'),
      ),
      body: _getPage(),
    );
  }

  _getPage() {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
          child: Column(
            children: <Widget>[
              _getPartTexts(),
              _getDivider(),
              _getCard(Icons.directions_bus_filled_rounded, widget.codigoOnibus,
                  () => null),
              _getCard(Icons.bus_alert_rounded, onibusAtual.estadoFisico,
                  () => null),
              _getCard(Icons.route, onibusAtual.linha, () => null)
            ],
          ),
        ),
      ),
    );
  }

  _getPartTexts() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _getText(),
          Text("Resumo da corrida:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        ],
      ),
    );
  }

  _getDivider() {
    return Divider(
      height: 50,
      thickness: 1,
      color: Colors.black,
      indent: 20,
      endIndent: 20,
    );
  }

  _getText() {
    return const Text(
      "Seu Perfil!",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }

  _getCard(IconData? icone, String? texto, Function()? onTap) {
    if (texto!.isNotEmpty) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            margin: EdgeInsets.all(15),
            elevation: 20,
            child: SizedBox.expand(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Icon(icone, size: 50)),
                  Expanded(child: Text(texto, style: TextStyle(fontSize: 25))),
                ],
              ),
            ),
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
