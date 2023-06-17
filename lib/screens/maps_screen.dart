import 'package:flutter/material.dart';
import 'package:connect_bus/widgets/menu_drawer.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text('Connect Bus'),
      ),
      drawer: const MenuDrawer(),
      body: const Placeholder(),
    );
  }
}
