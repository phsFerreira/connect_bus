import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Passageiro {
  String nomeCompleto = "";
  String cpf = "";
  String telefone = "";
  String email = "";
  String senha = "";
  String? docID = "";

  Passageiro({
    required this.nomeCompleto,
    required this.cpf,
    required this.telefone,
    required this.email,
    required this.senha,
    this.docID,
  });

  set setNomeCompleto(String nomeCompleto) {
    this.nomeCompleto = nomeCompleto;
  }

  String get getNomeCompleto {
    return nomeCompleto;
  }

  set setCpf(String cpf) {
    this.cpf = cpf;
  }

  String get getCpf {
    return cpf;
  }

  set setTelefone(String telefone) {
    this.telefone = telefone;
  }

  String get getTelefone {
    return telefone;
  }

  set setEmail(String email) {
    this.email = email;
  }

  String get getEmail {
    return email;
  }

  set setSenha(String senha) {
    this.senha = senha;
  }

  String get getSenha {
    return senha;
  }

  Future<DocumentReference<Map<String, dynamic>>> registrarPassageiro() async {
    var db = FirebaseFirestore.instance;
    final data = {
      'nomeCompleto': nomeCompleto,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'senha': senha,
    };

    var docSnapshot = await db.collection('Usuarios').add(data);
    return docSnapshot;
  }

  static Passageiro fromJson(Map<String, dynamic> json) => Passageiro(
      nomeCompleto: json['nomeCompleto'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      email: json['email'],
      senha: json['senha']);
}

Future<String> buscaNomePassageiro(String email) async {
  String emailBusca = email;
  String nome = "";

  var collection = FirebaseFirestore.instance.collection('Usuarios');
  var docSnapshot = await collection.doc(emailBusca).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    nome = data?['nomeCompleto'];
  }
  return nome;
}

Future<Passageiro> buscaPassageiro(String email) async {
  String emailBusca = email;
  Passageiro passageiroBusca =
      Passageiro(nomeCompleto: "", cpf: "", telefone: "", email: "", senha: "");

  var collection = FirebaseFirestore.instance.collection('Usuarios');
  var docSnapshot = await collection.doc(emailBusca).get();

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    passageiroBusca.nomeCompleto = data?['nomeCompleto'];
    passageiroBusca.cpf = data?['cpf'];
    passageiroBusca.telefone = data?['telefone'];
    passageiroBusca.email = data?['email'];
    passageiroBusca.senha = data?['senha'];
  }

  return passageiroBusca;
}

Future<bool> emailDuplicado(String email) async {
  try {
    bool duplicated = true;
    var usuariosCollectionRef =
        FirebaseFirestore.instance.collection('Usuarios');

    var usuarioEmailFoundDocs =
        await usuariosCollectionRef.where("email", isEqualTo: email).get();

    if (usuarioEmailFoundDocs.docs.isEmpty) {
      duplicated = false;
    }
    return duplicated;
  } catch (e) {
    Fluttertoast.showToast(
        msg: 'Erro ao consultar email do usuario ${e.toString()}.');
    return true;
  }
}

Future<bool> cpfDuplicado(String cpf) async {
  try {
    bool duplicated = true;
    var usuariosCollectionRef =
        FirebaseFirestore.instance.collection('Usuarios');

    var usuarioCPFFoundDocs =
        await usuariosCollectionRef.where("cpf", isEqualTo: cpf).get();

    if (usuarioCPFFoundDocs.docs.isEmpty) {
      duplicated = false;
    }
    return duplicated;
  } catch (e) {
    Fluttertoast.showToast(
        msg: 'Erro ao consultar cpf do usuario ${e.toString()}.');
    return true;
  }
}

loginPassageiro(String email, String senha) async {
  try {
    var usuariosCollectionRef =
        FirebaseFirestore.instance.collection('Usuarios');

    var usuarioFoundDocs =
        await usuariosCollectionRef.where("email", isEqualTo: email).get();

    if (usuarioFoundDocs.docs.isNotEmpty) {
      for (var docUsuario in usuarioFoundDocs.docs) {
        print('${docUsuario.id} ===> ${docUsuario.data()}');

        if (docUsuario.data()['senha'] == senha) {
          var passageiroExist = Passageiro(
              nomeCompleto: docUsuario.data()['nomeCompleto'],
              cpf: docUsuario.data()['cpf'],
              telefone: docUsuario.data()['telefone'],
              email: docUsuario.data()['email'],
              senha: docUsuario.data()['senha'],
              docID: docUsuario.id);
          return passageiroExist;
        } else {
          Fluttertoast.showToast(
              msg: "Senha incorreta.", toastLength: Toast.LENGTH_LONG);
          return null;
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Email não cadastrado ou incorreto.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Erro ao consultar usuario ${e.toString()}.');
    return null;
  }
}

Future<bool> deletePassageiro(String docID) {
  Future<bool> deleteSuccess = FirebaseFirestore.instance
      .collection("Usuarios")
      .doc(docID)
      .delete()
      .then(
        (doc) => true,
        onError: (e) => Fluttertoast.showToast(msg: "Erro ao deletar conta $e"),
      );
  return deleteSuccess;
}

updatePassageiro(Passageiro passageiro) async {
  final docPassageiroRef =
      FirebaseFirestore.instance.collection("Usuarios").doc(passageiro.docID);

  var docPassageiroExist = await docPassageiroRef.get();

  if (docPassageiroExist.exists) {
    docPassageiroRef.update({
      "nomeCompleto": passageiro.nomeCompleto,
      "cpf": passageiro.cpf,
      "telefone": passageiro.telefone,
      "email": passageiro.email,
      "senha": passageiro.senha,
    }).then(
        (value) =>
            Fluttertoast.showToast(msg: 'Usuario atualizado com sucesso.'),
        onError: (e) => Fluttertoast.showToast(
            msg: 'Erro ao atualizar usuario ${e.toString()}.'));
  }
}
