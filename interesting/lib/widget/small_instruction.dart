import 'package:flutter/material.dart';
import 'package:interesting/core/app_theme.dart';

void main() => runApp(
  MaterialApp(
    home: SmallInstruction(instructionText: "a1 + 2 a2x"),
    theme: AppTheme(ThemeData.light().textTheme).light(),
  ),
);

class SmallInstruction extends StatelessWidget {
  const SmallInstruction({
    super.key,
    required this.instructionText, // ↔ make this required
  });

  final String instructionText;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var colorText = colorScheme.onSurface;

    final textStyle = Theme.of(
      context,
    ).textTheme.headlineMedium?.copyWith(color: colorText);

    return Center(child: Text(instructionText, style: textStyle));
  }
}
