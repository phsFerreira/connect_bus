import 'package:connect_bus/profile_motorista.dart';
import 'package:connect_bus/profile_widget.dart';
import 'package:flutter/material.dart';

class InfoMotorista extends StatefulWidget {
  const InfoMotorista({super.key});

  @override
  State<InfoMotorista> createState() => _InfoMotoristaState();
}

class _InfoMotoristaState extends State<InfoMotorista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            const Text(
              "Seu Perfil!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 30),

            //imagem do motorista
            const ProfileWidget(
                imagePath:
                    "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg"),
            const SizedBox(
              height: 40,
            ),

            //texto reputacao
            const SizedBox(
              width: 300,
              height: 30,
              child: Text(
                "Reputação:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),

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
            const SizedBox(
              width: 300,
              height: 30,
              child: Text(
                "5948298591831",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            const SizedBox(height: 300),

            SizedBox(
              width: 320,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MotoristaPage()));
                  },
                  child: const Text(
                    "Voltar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
