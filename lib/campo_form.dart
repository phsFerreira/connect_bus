import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoForm extends StatefulWidget {
  const CampoForm({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    this.value,
    this.controller,
    required this.isPassword,
  }) : super(key: key);

  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? value;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  State<CampoForm> createState() => _CampoFormState();
}

class _CampoFormState extends State<CampoForm> {
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        initialValue: widget.value,
        validator: widget.validator,
        decoration: InputDecoration(
          suffix: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                  child: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          border: OutlineInputBorder(),
          labelText: widget.hintText,
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
