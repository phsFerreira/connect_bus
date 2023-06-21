import 'package:flutter/material.dart';
import 'package:connect_bus/widgets/menu_drawer.dart';
import 'package:provider/provider.dart';
import 'package:connect_bus/controllers/bus_stops_controller.dart';

class ParadasScreen extends StatelessWidget {
  const ParadasScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: const Text('Connect Bus'),
        ),
        drawer: const MenuDrawer(),
        body: ChangeNotifierProvider<BusStopsController>(
          create: (context) => BusStopsController(),
          child: Builder(builder: (context) {
            final local = context.watch<BusStopsController>();

            String mensagem = local.erro == ''
                ? 'latitude: ${local.latitude} | longitude: ${local.longitude}'
                : local.erro;

            return Center(child: Text(mensagem));
          }),
        ));
  }
}
