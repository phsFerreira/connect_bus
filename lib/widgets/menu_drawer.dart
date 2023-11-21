import 'package:connect_bus/model/passageiro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:connect_bus/pages/passageiro/pages/menu/profile_passageiro.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Menu lateral
class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key, required this.passageiro}) : super(key: key);
  final Passageiro passageiro;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return _getDrawer();
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
            widget.passageiro.nomeCompleto,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            widget.passageiro.email,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }

  _menuItems() {
    return Column(
      children: [
        // Home
        _getListTile(Icons.home, 'Home', () => Navigator.pop(context)),

        // Perfil
        _getListTile(
            Icons.person,
            'Perfil',
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PassageiroPage(
                          passageiro: widget.passageiro,
                        )))),

        // Polícia
        _getListTile(Icons.local_police, 'Polícia', () {
          const number = '+55190';
          FlutterPhoneDirectCaller.callNumber(number);
        }),

        // Sair
        _getListTile(Icons.logout, 'Sair', () async {
          try {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed('/main');
          } catch (e) {
            Fluttertoast.showToast(msg: 'Erro durante logout: $e');
          }
        })
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
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      onTap: onTap,
    );
  }
}
