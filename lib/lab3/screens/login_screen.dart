import 'package:flutter/material.dart';
import 'package:mobile_first_lab/lab3/models/user_model.dart';
import 'package:mobile_first_lab/lab3/screens/home_screen.dart';
import 'package:mobile_first_lab/lab2/widgets/input_field.dart';
import 'package:mobile_first_lab/lab2/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail == emailController.text.trim() &&
        savedPassword == passwordController.text.trim()) {
      final user = User(
        name: prefs.getString('name')!,
        email: savedEmail!,
        password: savedPassword!,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(user: user),
        ),
      );
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid credentials'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(hint: 'Email', controller: emailController),
            const SizedBox(height: 16),
            InputField(
                hint: 'Password',
                obscure: true,
                controller: passwordController),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Login',
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }
}
