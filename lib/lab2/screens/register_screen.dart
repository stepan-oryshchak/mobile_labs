import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Реєстрація",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              InputField(hint: "Ім'я"),
              SizedBox(height: 10),
              InputField(hint: "Email"),
              SizedBox(height: 10),
              InputField(hint: "Пароль", obscure: true),
              SizedBox(height: 20),
              CustomButton(
                  text: "Зареєструватися",
                  onPressed: () => Navigator.pushNamed(context, '/home')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text("Вже маєте акаунт? Увійти"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
