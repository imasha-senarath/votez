import 'package:flutter/material.dart';

class AppButtonOutline extends StatelessWidget {
  final Function() onTap;
  final String text;

  const AppButtonOutline({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        //side: const BorderSide(color: Colors.grey, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          //color: Colors.black,
        ),
      ),
    );
  }
}
