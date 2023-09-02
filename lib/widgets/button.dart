import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.textButton,
    required this.colorTextButton,
    required this.widthButton,
    required this.borderButton,
    required this.backgroundButton,
    required this.onPressed,
  }) : super(key: key);
  final String textButton;
  final Color colorTextButton;
  final double widthButton;
  final Color borderButton;
  final Color backgroundButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(widthButton, 52),
      backgroundColor: backgroundButton,
      foregroundColor: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: borderButton, width: 2, style: BorderStyle.solid),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
    );
    return ElevatedButton(
      style: elevatedButtonStyle,
      onPressed: onPressed,
      child: Text(
        textButton,
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w900,
          color: colorTextButton,
        ),
      ),
    );
  }
}
