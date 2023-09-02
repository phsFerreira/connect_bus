import 'package:flutter/material.dart';

import 'package:connect_bus/pages/motorista/pages/home_motorista.dart';
import 'package:connect_bus/profile_widget.dart';

class ProfileMotorista extends StatefulWidget {
  const ProfileMotorista({super.key});

  @override
  State<ProfileMotorista> createState() => _ProfileMotoristaState();
}

class _ProfileMotoristaState extends State<ProfileMotorista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            _getText(),
            const SizedBox(height: 30),
            _getPhoto(),
            const SizedBox(height: 40),
            _getTextReputation(),

            //campo das estrelas
            // RatingBar.builder(
            //     minRating: 1,
            //     itemBuilder: (context, _) => Icon(
            //           Icons.star,
            //           color: Colors.amber,
            //         ),
            //     onRatingUpdate: (rating) {}),
            const SizedBox(height: 20),

            //texto numero registro
            const SizedBox(
                width: 300,
                height: 30,
                child: Text(
                  "Nº de registro:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            _getRegistrationNumber(),
            const SizedBox(height: 300),
            _getButtonVoltar(),
          ],
        ),
      )),
    );
  }

  _getText() {
    return const Text(
      "Seu Perfil!",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }

  _getPhoto() {
    return const ProfileWidget(
      imagePath:
          "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg",
      width: 90,
      height: 90,
    );
  }

  _getTextReputation() {
    return const SizedBox(
      width: 300,
      height: 30,
      child: Text(
        "Reputação:",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  _getRegistrationNumber() {
    return const SizedBox(
      width: 300,
      height: 30,
      child: Text(
        "5948298591831",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }

  _getButtonVoltar() {
    return SizedBox(
      width: 320,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeMotoristaPage()));
        },
        child: const Text(
          "Voltar",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
