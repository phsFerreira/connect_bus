import 'package:connect_bus/model/parada.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParadasRepository {
  List<Parada> get listParadas => _listParadas;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Parada>> getParadas() async {
    try {
      var bairroCollection = await db.collection("Bairros").get();

      for (var bairroDoc in bairroCollection.docs) {
        var paradaCollection =
            await db.collection("Bairros/${bairroDoc.id}/Paradas").get();

        for (var paradaDoc in paradaCollection.docs) {
          print('PARADADOC ${paradaDoc.id} ===> ${paradaDoc.data()}');
          var parada = Parada(
            bairro: bairroDoc.get('nome'),
            id: paradaDoc.get('id'),
            latitude: paradaDoc.get('latitude'),
            longitude: paradaDoc.get('longitude'),
            onibus: bairroDoc.get('onibus'),
          );

          _listParadas.add(parada);
        }
      }
      return _listParadas;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  final List<Parada> _listParadas = [
    // Parada(
    //     id: 'parada_test_nvmundo1',
    //     bairro: 'Novo Mundo',
    //     latitude: -23.261009142007083,
    //     longitude: -47.671992198992314),
    // Parada(
    //     id: 'parada_test_nvmundo2',
    //     bairro: 'Novo Mundo Teste',
    //     latitude: -23.2625092,
    //     longitude: -47.6716789),

    // Marker(
    //     markerId: const MarkerId('parada_test_nvmundo1'),
    //     position: LatLng(-23.261009142007083, -47.671992198992314)),
    // Marker(
    //     markerId: const MarkerId('parada_test_centro'),
    //     position: LatLng(-23.2860909, -47.6741624)),
    // Marker(
    //     markerId: const MarkerId('parada_test_grupao'),
    //     position: LatLng(-23.2821963, -47.6723522)),
    // Marker(
    //     markerId: const MarkerId('parada_test_grupao'),
    //     position: LatLng(-23.2777673, -47.6731613)),
    // Marker(
    //     markerId: const MarkerId('parada_test_nvmundo2'),
    //     position: LatLng(-23.2625092, -47.6716789)),
    // Marker(
    //     markerId: const MarkerId('parada_test_nvmundo3'),
    //     position: LatLng(-23.2644994, -47.6712476)),
    // Marker(
    //     markerId: const MarkerId('parada_test_nvmundo4'),
    //     position: LatLng(-23.2661207, -47.6709187)),
    // Marker(
    //     markerId: const MarkerId('parada_test_nvmundo5'),
    //     position: LatLng(-23.2668392, -47.6702893)),
  ];
}
