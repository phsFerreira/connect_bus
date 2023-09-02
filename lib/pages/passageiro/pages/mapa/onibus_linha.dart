import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:connect_bus/pages/passageiro/pages/mapa/onibus_localizacao.dart';

/// Pagina responsavel por mostrar todos os onibus da respectiva linha
/// que Usuario clicou na tela [ParadasScreen]

class OnibusLinhaPage extends StatelessWidget {
  final String nomeLinha;
  const OnibusLinhaPage({
    Key? key,
    required this.nomeLinha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Onibus"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Onibus')
            .where('linha', isEqualTo: nomeLinha)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnibusLocalizacao(
                                  codigoOnibus: doc.get('codigo'),
                                )));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text('Ônibus ${doc.get('codigo')}'),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
