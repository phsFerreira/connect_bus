import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildImage(),
    );
  }

  _buildImage() {
    return ClipOval(
      child: Material(
        child: Ink.image(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
