import 'package:flutter/material.dart';
import 'package:mobile_first_lab/lab3/screens/login_screen.dart';
import 'package:mobile_first_lab/lab3/screens/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _checkSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return const RegistrationScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }

  Future<String?> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}
