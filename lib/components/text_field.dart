import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final bool obscureText;

  const AppTextField({super.key, required this.textEditingController, required this.labelText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 2.0
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        labelText: labelText,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
