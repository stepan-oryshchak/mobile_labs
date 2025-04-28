import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  const InputField({super.key, required this.hint, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: obscure,
        decoration:
            InputDecoration(hintText: hint, border: OutlineInputBorder()));
  }
}
