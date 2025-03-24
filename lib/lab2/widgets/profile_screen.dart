import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Профіль')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 40, backgroundImage: AssetImage('assets/avatar.png')),
            SizedBox(height: 10),
            Text("Ім'я Користувача",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("email@example.com",
                style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text("Вийти"),
            ),
          ],
        ),
      ),
    );
  }
}
