import 'package:flutter/material.dart';
import 'package:interesting/theme.dart';


void main() => runApp(
  MaterialApp(
    home: Instructions(
      instructionText:
          "Let’s assume any function with constants parameter ai in R for all i in Z.",
    ),
    theme: MyMaterialTheme(ThemeData.light().textTheme).light(),
  ),
);

class Instructions extends StatelessWidget {
  const Instructions({super.key, required this.instructionText});

  final String instructionText;

  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    var colorText = scheme.onSecondaryContainer;
    var colorBg = scheme.secondaryContainer;
    var colorOutline = scheme.onSurfaceVariant;

    final textStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(color: colorText);

    return Center(
      child: Container(
        constraints: BoxConstraints(),
        key: key,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorBg,
          border: Border.all(color: colorOutline, width: 3)),
        child: Text(instructionText, style: textStyle),
      ),
    );
  }
}
