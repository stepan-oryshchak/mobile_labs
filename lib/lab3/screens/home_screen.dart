import 'package:flutter/material.dart';
import 'package:mobile_first_lab/lab2/widgets/device_card.dart';
import 'package:mobile_first_lab/lab3/models/user_model.dart';
import 'package:mobile_first_lab/lab3/screens/profile_screen.dart';
import 'package:mobile_first_lab/lab2/widgets/custom_button.dart';
import 'package:mobile_first_lab/lab3/screens/registration_screen.dart';
import 'package:mobile_first_lab/lab3/services/mqtt_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Device {
  final IconData icon;
  bool isOn;

  Device({required this.icon, this.isOn = false});
}

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Map<String, Device> _devices = {
    'Лампочка': Device(icon: Icons.lightbulb),
    'Кондиціонер': Device(icon: Icons.ac_unit),
    'Двері': Device(icon: Icons.door_front_door),
    'Камера': Device(icon: Icons.videocam),
  };

  final MqttService _mqttService = MqttService();

  @override
  void initState() {
    super.initState();
    _mqttService.connect();
    _mqttService.listenToMessages((newDeviceStates) {
      if (!mounted) return;
      setState(() {
        _devices.updateAll((key, value) =>
            Device(icon: value.icon, isOn: newDeviceStates[key] ?? value.isOn));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _mqttService.disconnect();
  }

  void _toggleDevice(String name) {
    setState(() {
      _devices[name]!.isOn = !_devices[name]!.isOn;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$name ${_devices[name]!.isOn ? "увімкнено" : "вимкнено"}'),
      backgroundColor: _devices[name]!.isOn ? Colors.green : Colors.red,
      duration: const Duration(seconds: 3),
    ));
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('password');

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => RegistrationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Розумний будинок'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Вихід'),
                    content: Text('Ви справді хочете вийти?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Скасувати'),
                      ),
                      TextButton(
                        onPressed: () {
                          _logout();
                        },
                        child: Text('Вийти'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
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
                  icon: _devices[name]!.icon,
                  isOn: _devices[name]!.isOn,
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
