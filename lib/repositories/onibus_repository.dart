import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OnibusRepository extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void getOnibusAll() async {
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
            onError: (e) => Fluttertoast.showToast(
                msg: 'Erro ao atualizar lat e lgn do onibus $e.'),
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erro ao atualizar lat e lgn do onibus ${e.toString()}.');
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
            onError: (e) =>
                Fluttertoast.showToast(msg: 'Erro ao atualizar linha. $e'),
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erro ao atualizar linha. ${e.toString()}');
    }
  }

  updateEstadoOnibus(String codigoOnibus, String estadoFisico) async {
    try {
      List onibusExist = await findByCodigoOnibus(codigoOnibus);

      if (onibusExist.isNotEmpty) {
        for (var onibus in onibusExist) {
          db
              .collection('Onibus')
              .doc(onibus.id)
              .update({'estadoFisico': estadoFisico}).then(
            (value) => Fluttertoast.showToast(
                msg: 'Estado Fisico atualizado com sucesso.'),
            onError: (e) => Fluttertoast.showToast(
                msg: 'Erro ao atualizar Estado Fisico. $e'),
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erro ao atualizar Estado Fisico. ${e.toString()}');
    }
  }

  findByCodigoOnibus(String codigoOnibus) async {
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
      Fluttertoast.showToast(
          msg: 'Erro ao consultar codigoOnibus ${e.toString()}.');
      return [];
    }
  }

  findByLinhaOnibus(String nomeLinha) async {
    try {
      var onibusCollectionRef = db.collection('Onibus');

      var onibusFoundDocs =
          await onibusCollectionRef.where("linha", isEqualTo: nomeLinha).get();

      if (onibusFoundDocs.docs.isNotEmpty) {
        for (var onibus in onibusFoundDocs.docs) {
          print('${onibus.id} ===> ${onibus.data()}');
        }
      }
      return onibusFoundDocs.docs;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erro consultar linha de onibus ${e.toString()}.');
      return [];
    }
  }

  // (método de ChangeNotifier) usado para notificar qualquer um que esteja assistindo ParadasController
  @override
  notifyListeners();
}
