import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:connect_bus/pages/passageiro/pages/menu/profile_passageiro.dart';

/// Menu lateral
class MenuDrawer extends StatefulWidget {
  const MenuDrawer(
      {Key? key, required this.emailPassageiro, required this.nomePassageiro})
      : super(key: key);
  final String emailPassageiro;
  final String nomePassageiro;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  var emailPassageiro;
  var nomePassageiro;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (widget.emailPassageiro.isNotEmpty &&
          widget.nomePassageiro.isNotEmpty) {
        emailPassageiro = widget.emailPassageiro;
        nomePassageiro = widget.nomePassageiro;
      }
      return _getDrawer();
    });
  }

  _getDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          // Cabeçalho do menu lateral que ficará informações da conta do usuario
          _getDrawerHeader(),
          // Opções do menu lateral
          _menuItems(),
        ],
      ),
    );
  }

  _getDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/bus_home.png',
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nomePassageiro,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            emailPassageiro,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }

  _menuItems() {
    return Column(
      children: [
        _getListTile(Icons.home, 'Home', () => Navigator.pop(context)),
        _getListTile(
            Icons.person,
            'Perfil',
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PassageiroPage()))),
        _getListTile(Icons.local_police, 'Polícia', () {
          const number = '+55190';
          FlutterPhoneDirectCaller.callNumber(number);
        }),
        _getListTile(Icons.help, 'Ajuda', () => null),
        _getButtonLogOut(),
      ],
    );
  }

  _getListTile(IconData? icon, String texto, Function()? onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
        color: Colors.black,
      ),
      title: Text(
        texto,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  _getButtonLogOut() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          // backgroundColor: Colors.red,
          // foregroundColor: const Color.fromARGB(255, 82, 9, 9),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          side: BorderSide(color: Colors.red, width: 2)),
      onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut();
          // Navigate to the login screen or home screen
          Navigator.of(context).pushReplacementNamed('/main');
        } catch (e) {
          print('Error during logout: $e');
        }
      },
      child: const Text(
        'SAIR',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
