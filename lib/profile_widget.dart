// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),
    );
  }
}

Widget buildImage() {
  final image = NetworkImage(
      "https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg");

  return ClipOval(
    child: Material(
        child: Ink.image(
            image: image, fit: BoxFit.cover, width: 128, height: 128)),
  );
}
