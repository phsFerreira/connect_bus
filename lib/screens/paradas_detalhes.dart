import 'package:connect_bus/controllers/horarios_controller.dart';
import 'package:connect_bus/model/parada.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParadaDetalhes extends StatelessWidget {
  final Parada parada;

  const ParadaDetalhes({Key? key, required this.parada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: const Text('Parada'),
        ),
        body: ChangeNotifierProvider<HorariosController>(
          create: (context) => HorariosController(),
          child: Builder(builder: (context) {
            final horarioController = context.watch<HorariosController>();

            horarioController.loadHorarios(parada.bairro);
            return const Placeholder();
          }),
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(parada.bairro!, style: const TextStyle(fontSize: 40)),
        //     Image.asset(
        //       'assets/images/horario_novo_mundo.jpg',
        //       fit: BoxFit.cover,
        //       // width: 600,
        //       // height: 700,
        //     ),
        //   ],
        // ),
        );
  }
}
