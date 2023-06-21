import 'package:flutter/material.dart';

class BusStopDetails extends StatelessWidget {
  const BusStopDetails({super.key, required this.neighborhood});

  final String neighborhood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Novo Mundo', style: TextStyle(fontSize: 40)),
          Image.asset(
            'assets/images/horario_novo_mundo.jpg',
            fit: BoxFit.cover,
            // width: 600,
            // height: 700,
          ),
        ],
      ),
    );
  }
}
