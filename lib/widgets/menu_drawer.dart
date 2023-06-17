import 'package:connect_bus/profile_passageiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

/// Menu lateral
class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: const [
          // Cabeçalho do menu lateral que ficará informações da conta do usuario
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          // Opções do menu lateral
          MenuItems(),
        ],
      ),
    );
  }
}

/// Opções do menu lateral
class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO: Refatorar ListTile, codigo esta repetitivo

        // Menu Home
        ListTile(
          leading: const Icon(
            Icons.home,
            size: 25,
            color: Colors.black,
          ),
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        // Menu Perfil
        ListTile(
          leading: const Icon(
            Icons.person,
            size: 25,
            color: Colors.black,
          ),
          title: const Text(
            "Perfil",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PassageiroPage()));
          },
        ),
        // Menu Polícia
        ListTile(
          leading: const Icon(
            Icons.local_police,
            size: 25,
            color: Colors.black,
          ),
          title: const Text(
            "Polícia",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            const number = '+55190';
            FlutterPhoneDirectCaller.callNumber(number);
          },
        ),
        // Menu Ajuda
        ListTile(
          leading: const Icon(
            Icons.help,
            size: 25,
            color: Colors.black,
          ),
          title: const Text(
            "Ajuda",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const PassageiroPage()));
          },
        ),
        // Botão sair
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: const Color.fromARGB(255, 82, 9, 9),
            padding: const EdgeInsets.symmetric(horizontal: 30),
          ),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const MyApp()));
          },
          child: const Text(
            'sair',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
