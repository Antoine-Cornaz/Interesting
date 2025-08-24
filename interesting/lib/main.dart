import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_utils.dart';
import 'features/assessment/logic/assessment_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/assessment/ui/assessment_screen.dart';

Future<void> main() async {
  // Load the key from .env file
  await dotenv.load(fileName: ".env");
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
