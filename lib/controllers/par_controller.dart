// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// //
// // Controller baseado no video https://www.youtube.com/watch?v=N5MsMDbz6_w&t=1133s
// //

// // PENDENCIAS: Precisa

// class ParadasController extends GetxController {
//   // "obs" de observável
//   final latitude = 0.0.obs;
//   final longitude = 0.0.obs;

//   late GoogleMapController _mapController;

//   // Variavel estática que retorna a instancia de ParadasController para ser utilizada
//   // em outros arquivos
//   static ParadasController get to => Get.find<ParadasController>();

//   // getter do atributo mapController
//   get mapsController => _mapController;

//   final Set<Marker> mapMarkers = {
//     // Marker(
//     //     markerId: const MarkerId('parada_test_nvmundo1'),
//     //     position: LatLng(-23.261009142007083, -47.671992198992314)),
//     // Marker(
//     //     markerId: const MarkerId('parada_test_centro'),
//     //     position: LatLng(-23.2860909, -47.6741624)),
//     // Marker(
//     //     markerId: const MarkerId('parada_test_grupao'),
//     //     position: LatLng(-23.2821963, -47.6723522)),
//     // Marker(
//     //     markerId: const MarkerId('parada_test_grupao'),
//     //     position: LatLng(-23.2777673, -47.6731613)),
//     // Marker(
//     //     markerId: const MarkerId('parada_test_nvmundo2'),
//     //     position: LatLng(-23.2625092, -47.6716789)),
//     // Marker(
//     //     markerId: const MarkerId('parada_test_nvmundo3'),
//     //     position: LatLng(-23.2644994, -47.6712476)),
//     // Marker(
//     //     markerId: const MarkerId('parada_test_nvmundo4'),
//     //     position: LatLng(-23.2661207, -47.6709187)),
//     // Marker(
//     //     markerId: const MarkerId('parada_test_nvmundo5'),
//     //     position: LatLng(-23.2668392, -47.6702893)),
//   };

//   // Quando o mapa for criado pegue a posição atual do usuário
//   onMapCreated(GoogleMapController mapController) async {
//     _mapController = mapController;
//     getPosicaoAtualUsuario();
//     loadParadas();
//   }

//   Future<Position> _posicaoAtual() async {
//     // #region: Verifica se o serviço de GPS do usuário esta ativo
//     bool ativado;
//     LocationPermission permissao;

//     // Checando se o serviço de localização esta ativado no celular.
//     ativado = await Geolocator.isLocationServiceEnabled();

//     // Se o serviço de localização não estiver ativo retorne um erro.
//     if (!ativado) {
//       return Future.error('Por favor, habilite a localização do smartphone.');
//     }

//     permissao = await Geolocator.checkPermission();

//     // Se o usuário negou a permissão de localização se sim requisita para o usuário a sua localização.
//     if (permissao == LocationPermission.denied) {
//       permissao = await Geolocator.requestPermission();

//       // Se mesmo solicitando o acesso o usuário negar, então mostre mensagem de erro.
//       if (permissao == LocationPermission.denied) {
//         return Future.error("Voce precisa autorizar o acesso a localização");
//       }
//     }

//     // Se o usuário tem a permissão de localização permanentemente desabilitada, então precisa orientá-lo
//     // a ativar pelas configurações
//     if (permissao == LocationPermission.deniedForever) {
//       return Future.error('Autorize o acesso à localização nas configurações.');
//     }
//     // #endregion

//     Position posicaoAtual = await Geolocator.getCurrentPosition();

//     return posicaoAtual;
//   }

//   getPosicaoAtualUsuario() async {
//     try {
//       final posicaoAtual = await _posicaoAtual();
//       latitude.value = posicaoAtual.latitude;
//       longitude.value = posicaoAtual.longitude;

//       // Movendo a camera do google maps para a localizaçaõ do usuario
//       _mapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//               target: LatLng(latitude.value, longitude.value), zoom: 16),
//         ),
//       );
//     } catch (e) {
//       // todo: Tratar o erro
//       printError(info: e.toString());
//     }
//   }

//   loadParadas() async {
//     // FirebaseFirestore db = DB.get();
//     // try {
//     //   final bairros = await db.collection('Bairros').get();
//     //   for (var bairro in bairros.docs) {
//     //     {
//     //       nomeBairro = bairro.get('nomeBairro');
//     //       paradas = bairro.get('parada');
//     //     }
//     //   }
//     // } catch (e) {
//     //   // todo: Tratar o erro
//     //   printError(info: e.toString());
//     // }
//   }

//   // generateMarkers(bairro) {
//   //   List paradas = bairro.get('parada');
//   //   paradas.forEach((parada) async {
//   //     var paradaId = parada['id'];
//   //     var position = parada['position'];
//   //     GeoPoint point = position['geopoint'];

//   //     mapMarkers.add(
//   //       Marker(
//   //         markerId: MarkerId(paradaId.toString()),
//   //         position: LatLng(point.latitude, point.longitude),
//   //         infoWindow: InfoWindow(title: bairro.get('nomeBairro')),
//   //         icon: await BitmapDescriptor.fromAssetImage(
//   //             const ImageConfiguration(), 'assets/images/bus-stop.png'),
//   //         onTap: () => {
//   //            Navigator.push(
//   //               context,
//   //               MaterialPageRoute(
//   //                   builder: (context) =>
//   //                       const BusStopDetails(neighborhood: 'Novo Mundo')));
//   //         },
//   //       ),
//   //     );
//   //     update();
//   //   });
//   // }
// }
