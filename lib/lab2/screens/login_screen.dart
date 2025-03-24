import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Авторизація",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              InputField(hint: "Email"),
              SizedBox(height: 10),
              InputField(hint: "Пароль", obscure: true),
              SizedBox(height: 20),
              CustomButton(
                  text: "Увійти",
                  onPressed: () => Navigator.pushNamed(context, '/home')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text("Немає акаунту? Зареєструйтесь"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
