import 'dart:isolate';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile_first_lab/lab3/models/user_model.dart';
import 'package:mobile_first_lab/lab3/repository/user_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_first_lab/lab3/screens/registration_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  final repo = UserRepositoryImpl();

  late Isolate _isolate;
  late SendPort _sendPort;
  final ReceivePort _receivePort = ReceivePort();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    _initIsolate();
  }

  Future<void> _initIsolate() async {
    final isolate = await Isolate.spawn(_isolateEntry, _receivePort.sendPort);
    _isolate = isolate;

    _sendPort = await _receivePort.first as SendPort;
  }

  static void _isolateEntry(SendPort mainSendPort) {
    final port = ReceivePort();
    mainSendPort.send(port.sendPort);

    port.listen((message) {
      if (message == 'SAVE_USER') {
        log('✅ Дані юзера збережено', name: 'ProfileIsolate');
      }
    });
  }

  void saveChanges() async {
    final updatedUser = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: widget.user.password,
    );

    await repo.updateUser(updatedUser);

    _sendPort.send('SAVE_USER');

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated')),
    );
  }

  void deleteAccount() async {
    await repo.deleteUser();
    if (!mounted) return;
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saveChanges, child: const Text('Save')),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('user');

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()),
                    (route) => false,
                  );
                }
              },
              child: const Text('Вийти з акаунту'),
            ),
          ],
        ),
      ),
    );
  }
}
