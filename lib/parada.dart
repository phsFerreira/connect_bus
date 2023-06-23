import 'package:firebase_database/firebase_database.dart';

class Parada {
  String endereco = "";
  String complemento = "";

  Parada({required this.endereco, required this.complemento});

  set setEndereco(String endereco) {
    this.endereco = endereco;
  }

  set setComplemento(String complemento) {
    this.complemento = complemento;
  }

  void registrarParada() {
    late DatabaseReference db;
    db = FirebaseDatabase.instance.ref().child('Paradas');

    Map<String, String> paradas = {
      'endereco': endereco,
      'complemento': complemento,
    };
    db.push().set(paradas);
  }
}
