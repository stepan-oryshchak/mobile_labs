import 'package:flutter/material.dart';
import 'package:mobile_first_lab/lab2/widgets/input_field.dart';
import 'package:mobile_first_lab/lab2/widgets/custom_button.dart';
import 'package:mobile_first_lab/lab3/models/user_model.dart';
import 'package:mobile_first_lab/lab3/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _register() {
    final user = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    // Логіка реєстрації (можна зберігати дані користувача)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('User ${user.name} registered successfully!'),
      backgroundColor: Colors.green,
    ));

    // Переходимо на сторінку логіну після реєстрації
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(hint: 'Name', controller: nameController),
            SizedBox(height: 16),
            InputField(hint: 'Email', controller: emailController),
            SizedBox(height: 16),
            InputField(
                hint: 'Password',
                obscure: true,
                controller: passwordController),
            SizedBox(height: 32),
            CustomButton(
              text: 'Register',
              onPressed: _register,
            ),
          ],
        ),
      ),
    );
  }
}
