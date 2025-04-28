import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isOn;
  final VoidCallback onTap;
  const DeviceCard(
      {super.key,
      required this.name,
      required this.icon,
      required this.isOn,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isOn ? Colors.green : Colors.red,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 50, color: Colors.white),
          Text(name, style: TextStyle(fontSize: 16, color: Colors.white)),
        ]),
      ),
    );
  }
}
