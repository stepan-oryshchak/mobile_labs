import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repository/user_repository_impl.dart';

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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
  }

  void saveChanges() async {
    final updatedUser = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: widget.user.password,
    );

    await repo.updateUser(updatedUser);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated')),
    );
  }

  void deleteAccount() async {
    await repo.deleteUser();
    // ignore: use_build_context_synchronously
    Navigator.popUntil(context, (route) => route.isFirst);
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
                onPressed: deleteAccount, child: const Text('Delete Account')),
          ],
        ),
      ),
    );
  }
}
