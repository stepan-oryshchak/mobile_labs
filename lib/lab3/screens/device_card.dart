import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String title;
  final bool isOn;
  final ValueChanged<bool> onToggle;

  const DeviceCard({
    super.key,
    required this.title,
    required this.isOn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: ListTile(
        title: Text(title),
        trailing: Switch(
          value: isOn,
          onChanged: onToggle,
        ),
      ),
    );
  }
}
