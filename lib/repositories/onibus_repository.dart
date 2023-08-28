import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OnibusRepository extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void getLocalizationsOnibus() async {
    try {
      db.collection("Onibus").snapshots().listen((event) {
        final onibus = [];
        for (var doc in event.docs) {
          onibus.add(doc.data());
        }
        print("onibus do Banco: ${onibus.join(", ")}");
      });
    } catch (erro) {
      print(erro.toString());
    }
  }

  updateLatLgn(String codigoOnibus, double latitude, double longitude) async {
    try {
      List onibusExist = await findByCodigoOnibus(codigoOnibus);
      if (onibusExist.isNotEmpty) {
        for (var onibus in onibusExist) {
          db
              .collection('Onibus')
              .doc(onibus.id)
              .update({'latitude': latitude, 'longitude': longitude}).then(
                  (value) => print("DocumentSnapshot successfully updated!"),
                  onError: (e) => print("Error updating document $e"));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateLinhaOnibus(String codigoOnibus, String nomeLinha) async {
    try {
      List onibusExist = await findByCodigoOnibus(codigoOnibus);

      if (onibusExist.isNotEmpty) {
        for (var onibus in onibusExist) {
          db
              .collection('Onibus')
              .doc(onibus.id)
              .update({'linha': nomeLinha}).then(
                  (value) => print("Linha atualizada no Firebase"),
                  onError: (e) => print("Erro ao atualizar campo 'linha': $e"));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /// Encontra o onibus pelo codigo informado
  Future<List> findByCodigoOnibus(String codigoOnibus) async {
    try {
      var onibusCollectionRef = db.collection('Onibus');

      var onibusFoundDocs = await onibusCollectionRef
          .where("codigo", isEqualTo: codigoOnibus)
          .get();

      if (onibusFoundDocs.docs.isNotEmpty) {
        for (var onibus in onibusFoundDocs.docs) {
          print('${onibus.id} ===> ${onibus.data()}');
        }
      }
      return onibusFoundDocs.docs;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // (método de ChangeNotifier) usado para notificar qualquer um que esteja assistindo ParadasController
  @override
  notifyListeners();
}
