import 'package:flutter/material.dart';
import 'package:interesting/my_widget/sub_problem_data.dart';
import '../../util.dart';
import '../my_widget/problem.dart';

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
      home: Problem(problems: problem1),
    );
  }
}

