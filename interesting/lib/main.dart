import 'package:flutter/material.dart';
import 'package:interesting/screen/swipe_screen.dart';
import 'package:provider/provider.dart';
import '../util.dart';
import 'backend/screen/card_manager.dart';

void main() {
  runApp(
    // 2. Wrap your app in a ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => CardManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interesting',
      theme: getTheme(context),
      home: SwipeScreen(),
    );
  }
}