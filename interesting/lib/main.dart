import 'package:flutter/material.dart';
import 'package:interesting/features/assessment/ui/assessment_screen.dart';
import 'package:provider/provider.dart';
import 'core/app_utils.dart';
import 'features/assessment/logic/assessment_manager.dart';

void main() {
  runApp(
    // 2. Wrap your app in a ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => AssessmentManager(),
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
      home: AssessmentScreen(),
    );
  }
}