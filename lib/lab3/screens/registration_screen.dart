import 'package:flutter/material.dart';
import 'package:mobile_first_lab/lab2/widgets/input_field.dart';
import 'package:mobile_first_lab/lab2/widgets/custom_button.dart';
import 'package:mobile_first_lab/lab3/models/user_model.dart';
import 'package:mobile_first_lab/lab3/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _register() async {
    final user = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', user.name);
    await prefs.setString('email', user.email);
    await prefs.setString('password', user.password);

    if (!mounted) return; // Перевірка на "mounted"

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('User ${user.name} registered successfully!'),
      backgroundColor: Colors.green,
    ));

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
