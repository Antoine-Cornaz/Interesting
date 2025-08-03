import 'package:flutter/material.dart';
import '../../util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taylor series',
      theme: getTheme(context),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Hi !\nAntoine", textAlign: TextAlign.center),
            buildCircularProgressLevel(),
            ElevatedButton(onPressed: () {}, child: Text("Play")),
            ElevatedButton(onPressed: () {}, child: Text("Explore")),
          ],
        ),
      ),
    );
  }

  Widget buildCircularProgressLevel() {
    return Stack(
      children: [
        Center(
          child: CircularProgressIndicator(
            value: 0.1,
            backgroundColor: Colors.pink,
            strokeWidth: 10,
            constraints: BoxConstraints(minWidth: 100, minHeight: 100),
          ),
        ),
        Center(child: Text("lvl\n16", textAlign: TextAlign.center)),
      ],
    );
  }
}
