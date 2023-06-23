import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:connect_bus/model/horario.dart';

class HorariosRepository extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // /Horarios/H5jBlkPni50C8r8WyCDY/BairrosHorarios/U2iGMFbrKCMVIrg6HFDj

  /// Método resposável por consultar o nome do bairro da parada
  /// de onibus quando clicada pelo usuario. Através do nome do bairro
  /// será possível trazer os horarios.
  findByBairroName(String nome) async {
    try {
      print('bairro da parada ==> $nome');
      var horarioCollection = await db.collection("Horarios").get();
      for (var horarioDoc in horarioCollection.docs) {
        var bairrosHorariosCollection =
            db.collection("Horarios/${horarioDoc.id}/BairrosHorarios");

        var bairroFound =
            bairrosHorariosCollection.where("bairros", arrayContains: nome);
        print('bairro encontrado ${bairroFound.get()}');
        var bairroDoc = await bairroFound.get();
        for (var doc in bairroDoc.docs) {
          print('${doc.id} ===> ${doc.data()}');

          var horario = Horario(
            linha: horarioDoc.get('linha'),
            diaDeFuncionamento: horarioDoc.get('diaDeFuncionamento'),
            bairros: doc.get('bairros'),
            horaPartidaBairro: doc.get('horaPartidaBairro'),
            horaPartidaRodoviaria: doc.get('horaPartidaRodoviaria'),
          );
          print('Objeto Horario ${horario.linha}');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
