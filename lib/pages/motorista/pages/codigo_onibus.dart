import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connect_bus/pages/motorista/pages/home_motorista.dart';
import 'package:connect_bus/repositories/onibus_repository.dart';
import 'package:connect_bus/widgets/button.dart';

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
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            overflowSpacing: 10,
            children: [
              _getImageBus(),
              _getText(),
              _getInputTextCode(),
              _getButtonConfirm(),
              _getButtonBack(),
            ],
          ),
        ),
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
    return TextField(
      controller: _codeBusController,
      decoration: const InputDecoration(
        labelText: 'Codigo',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 2, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 2, style: BorderStyle.solid),
        ),
      ),
    );
  }

  _findBusCode(String codigoOnibus) async {
    onibusRepository.findByCodigoOnibus(codigoOnibus).then((onibusExist) {
      if (onibusExist.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeMotoristaPage(
                      codigoOnibus: codigoOnibus,
                    )));
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
    return ButtonWidget(
      textButton: 'CONFIRMAR',
      colorTextButton: Colors.white,
      widthButton: double.infinity,
      borderButton: Colors.black,
      backgroundButton: Colors.black,
      onPressed: () {
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
