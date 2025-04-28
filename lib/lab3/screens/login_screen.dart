import 'package:flutter/material.dart';
import 'package:mobile_first_lab/lab3/screens/home_screen.dart';
import 'package:mobile_first_lab/lab2/widgets/input_field.dart';
import 'package:mobile_first_lab/lab2/widgets/custom_button.dart';
import '../models/user_model.dart'; // Імпортуємо модель User

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(hint: 'Email', controller: emailController),
            SizedBox(height: 16),
            InputField(
                hint: 'Password',
                obscure: true,
                controller: passwordController),
            SizedBox(height: 32),
            CustomButton(
              text: 'Login',
              onPressed: () {
                // Створюємо об'єкт користувача з даними, введеними в текстові поля
                final user = User(
                  name: 'User Name', // Замініть на відповідне значення
                  email: emailController.text,
                  password: passwordController.text,
                );

                // Переходимо до HomeScreen після успішного логіну
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(user: user),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
