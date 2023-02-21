// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../main.dart';
// import '../profile_passageiro.dart';

// class DrawerList extends StatelessWidget {
//   const DrawerList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(
//         top: 15,
//       ),
//       child: Column(
//         children: [
//           menuItem(),
//         ],
//       ),
//     );
//   }

//   Widget menuItem() {
//     return Column(
//       children: [
//         ListTile(
//           leading: const Icon(
//             Icons.home,
//             size: 25,
//             color: Colors.black,
//           ),
//           title: const Text(
//             "Home",
//             style: TextStyle(color: Colors.black, fontSize: 16),
//           ),
//           onTap: () {
//             Navigator.pop(context as BuildContext);
//           },
//         ),
//         ListTile(
//           leading: const Icon(
//             Icons.person,
//             size: 25,
//             color: Colors.black,
//           ),
//           title: const Text(
//             "Profile",
//             style: TextStyle(color: Colors.black, fontSize: 16),
//           ),
//           onTap: () {
//             Navigator.push(
//                 context as BuildContext,
//                 MaterialPageRoute(
//                     builder: (context) => const PassageiroPage()));
//           },
//         ),
//         const SizedBox(height: 60),

//         //emergencia button
//         SizedBox(
//           width: 230,
//           height: 50,
//           child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   primary: Colors.white,
//                   onPrimary: Colors.grey,
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                       side: BorderSide(width: 1, color: Colors.black))),
//               onPressed: () {
//                 const number = '+55190';
//                 FlutterPhoneDirectCaller.callNumber(number);
//               },
//               child: const Text(
//                 'Emergência',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16),
//               )),
//         ),

//         const SizedBox(height: 20),

//         //ajuda button
//         SizedBox(
//           width: 230,
//           height: 50,
//           child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   primary: Colors.white,
//                   onPrimary: Colors.grey,
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                       side: BorderSide(width: 1, color: Colors.black))),
//               onPressed: () {
//                 Fluttertoast.showToast(
//                     msg:
//                         "Solicitação enviada ao suporte. Logo entraremos em contato.",
//                     toastLength: Toast.LENGTH_LONG,
//                     gravity: ToastGravity.CENTER,
//                     fontSize: 20.0);
//               },
//               child: const Text(
//                 'Ajuda',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16),
//               )),
//         ),

//         const SizedBox(height: 100),

//         //sair button
//         SizedBox(
//           width: 230,
//           height: 50,
//           child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   primary: Colors.red,
//                   onPrimary: const Color.fromARGB(255, 82, 9, 9),
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                       side: BorderSide(width: 1, color: Colors.red))),
//               onPressed: () {
//                 Builder(builder: (context) {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const MyApp()));
//                 });
//               },
//               child: const Text(
//                 'sair',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16),
//               )),
//         ),
//       ],
//     );
//   }
// }
