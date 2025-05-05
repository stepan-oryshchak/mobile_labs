import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType; // Додано тип клавіатури
  final String? Function(String?)? validator; // Додано можливість валідації

  const InputField(
      {super.key,
      required this.hint,
      this.obscure = false,
      this.controller,
      this.keyboardType, // Приймаємо тип клавіатури як параметр
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType, // Налаштовуємо тип клавіатури
      validator: validator, // Використовуємо функцію валідації, якщо надано
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200], // Легкий фон для покращення вигляду
      ),
    );
  }
}
