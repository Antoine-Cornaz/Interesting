import 'package:flutter/material.dart';
import 'package:interesting/widget/bezier/cloud.dart';
import 'package:interesting/core/app_theme.dart';

void main() => runApp(
  MaterialApp(
    home: Instructions(
      instructionText:
          "Let’s assume any function with constants parameter ai in R for all i in Z.",
    ),
    theme: AppTheme(ThemeData.light().textTheme).light(),
  ),
);

class Instructions extends StatelessWidget {
  const Instructions({super.key, required this.instructionText});

  final String instructionText;

  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    var colorText = scheme.onSecondaryContainer;

    final textStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(color: colorText);

    return Cloud(
      child: Container(
        alignment: Alignment(0, 0),
        width: 600 / 1.5,
        height: 356 / 1.5,
        padding: EdgeInsets.all(20),
        child: Text(instructionText, style: textStyle),
      ),
    );
  }
}
