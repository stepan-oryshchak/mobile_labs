import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ColorChangerScreen(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class ColorChangerScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ColorChangerScreenState createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<ColorChangerScreen> {
  Color _backgroundColor = Colors.grey[300]!;
  final TextEditingController _controller = TextEditingController();
  String? _funFact;
  final List<String> _funFacts = [
    "Перша версія Android вийшла у 2008 році!",
    "Android побудований на базі ядра Linux.",
    "Більше 70% смартфонів у світі працюють на Android!",
    "Google називав версії Android на честь десертів до Android 10.",
    "Android має понад 3 мільйони додатків у Play Store!",
  ];

  final Map<String, Color> _colorMap = {
    "червоний": Colors.red,
    "зелений": Colors.green,
    "синій": Colors.blue,
    "жовтий": Colors.yellow,
    "фіолетовий": Colors.purple,
  };

  void _updateBackgroundColor() {
    String input = _controller.text.trim().toLowerCase();
    if (input == "default") {
      setState(() {
        _backgroundColor = Colors.grey[300]!;
      });
    } else if (_colorMap.containsKey(input)) {
      setState(() {
        _backgroundColor = _colorMap[input]!;
      });
    }
    _controller.clear();
  }

  void _showFunFact() {
    setState(() {
      _funFact = (_funFacts..shuffle()).first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter IoT Lab")),
      body: Container(
        color: _backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Введіть колір або Default",
              ),
              onSubmitted: (value) => _updateBackgroundColor(),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _showFunFact, child: Text("Цікавинка")),
            if (_funFact != null) ...[
              SizedBox(height: 10),
              Text(
                _funFact!,
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
