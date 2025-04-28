import 'package:flutter/material.dart';
import 'package:mobile_first_lab/lab3/models/user_model.dart';
import 'package:mobile_first_lab/lab3/screens/profile_screen.dart';
import 'package:mobile_first_lab/lab2/widgets/custom_button.dart';
import 'package:mobile_first_lab/lab2/widgets/device_card.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Map<String, (IconData, bool)> _devices = {
    'Лампочка': (Icons.lightbulb, false),
    'Кондиціонер': (Icons.ac_unit, false),
    'Двері': (Icons.door_front_door, false),
    'Камера': (Icons.videocam, false),
  };

  void _toggleDevice(String name) {
    setState(() => _devices[name] = (_devices[name]!.$1, !_devices[name]!.$2));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$name ${_devices[name]!.$2 ? "увімкнено" : "вимкнено"}'),
      backgroundColor: _devices[name]!.$2 ? Colors.green : Colors.red,
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Розумний будинок')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Перейти до профілю',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(user: widget.user),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _devices.length,
              itemBuilder: (_, i) {
                String name = _devices.keys.elementAt(i);
                return DeviceCard(
                  name: name,
                  icon: _devices[name]!.$1,
                  isOn: _devices[name]!.$2,
                  onTap: () => _toggleDevice(name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
