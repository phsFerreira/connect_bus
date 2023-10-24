// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoForm extends StatelessWidget {
  const CampoForm({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    this.value,
    this.controller,
  }) : super(key: key);

  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? value;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        initialValue: value,
        validator: validator,
        decoration: InputDecoration(
          labelText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: 2, style: BorderStyle.solid),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: 2, style: BorderStyle.solid),
          ),
        ),
      ),
    );
  }
}
