import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connect_bus/profile_motorista.dart';
import 'package:connect_bus/repositories/onibus_repository.dart';

/// Página que recebe o código do onibus que o motorista esta
/// e consulta no banco para saber se o onibus existe ou não.

class CodigoOnibusPage extends StatefulWidget {
  const CodigoOnibusPage({super.key});

  @override
  State<CodigoOnibusPage> createState() => _CodigoOnibusPageState();
}

class _CodigoOnibusPageState extends State<CodigoOnibusPage> {
  late OnibusRepository onibusRepository;

  late TextEditingController _codeBusController;

  @override
  void initState() {
    super.initState();
    onibusRepository = OnibusRepository();
    _codeBusController = TextEditingController();
  }

  @override
  void dispose() {
    _codeBusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPageCodeBus(),
    );
  }

  _getPageCodeBus() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getImageBus(),
          const SizedBox(
            height: 30,
          ),
          _getText(),
          const SizedBox(
            height: 30,
          ),
          _getInputTextCode(),
          const SizedBox(
            height: 20,
          ),
          _getButtonConfirm(),
        ],
      ),
    );
  }

  _getImageBus() {
    return Image.asset("assets/images/bus-icon.png", height: 200);
  }

  _getText() {
    return const Text(
      'Informe o código do onibus:',
      style: TextStyle(fontSize: 20),
    );
  }

  _getInputTextCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: TextField(
          controller: _codeBusController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.black, width: 1)),
              hintText: 'Codigo',
              contentPadding: EdgeInsets.all(20.0)),
        ),
      ),
    );
  }

  _findBusCode(String codigoOnibus) async {
    onibusRepository.findByCodigoOnibus(codigoOnibus).then((onibusExist) {
      if (onibusExist.isNotEmpty) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MotoristaPage()));
      }
      if (onibusExist.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Ônibus não encontrado.',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 238, 147, 147),
            textColor: Colors.black);
      }
    });
  }

  _getButtonConfirm() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: const Color.fromARGB(255, 66, 190, 240),
        minimumSize: const Size(150, 50),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
      onPressed: () async {
        if (_codeBusController.text.isEmpty) {
          Fluttertoast.showToast(
              msg: 'Preencha o campo.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.black);
        }

        _findBusCode(_codeBusController.text);
      },
      child: const Text('CONFIRMAR',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    );
  }
}
