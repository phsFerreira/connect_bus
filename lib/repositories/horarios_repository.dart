import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_bus/model/horario.dart';

class HorariosRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<Horario> _listHorarios = [];

  /// Método resposável por consultar o nome do bairro da parada
  /// de onibus quando clicada pelo usuario. Através do nome do bairro
  /// será possível trazer os horarios.
  Future<List<Horario>> findByBairroName(String nomeBairro) async {
    try {
      print('bairro da parada ==> $nomeBairro');

      // Procurando na Subcollection 'BairrosHorarios' em seu array 'bairros' se contém o nomeBairro
      var bairroFoundDocs = await db
          .collection("Horarios")
          .where("bairros", arrayContains: nomeBairro)
          .get();
      print('SELECIONOU UMA PARADA DE UM BAIRRO $bairroFoundDocs');

      // Iterando documents da Subcollection 'BairrosHorarios' que possuem no array 'bairros' o nomeBairro
      for (var doc in bairroFoundDocs.docs) {
        print('${doc.id} ===> ${doc.data()}');
        var horario = Horario(
          linha: doc.get('linha'),
          diaDeFuncionamento: doc.get('diaDeFuncionamento'),
          bairros: doc.get('bairros'),
          horaPartidaBairro: doc.get('horaPartidaBairro'),
          horaPartidaRodoviaria: doc.get('horaPartidaRodoviaria'),
        );
        _listHorarios.add(horario);
        print('Objeto Horario ${horario.linha}');
      }
      return _listHorarios;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getHorariosCollection() async {
    try {
      var horarioCollection = await db.collection("Horarios").get();
      return horarioCollection.docs;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
