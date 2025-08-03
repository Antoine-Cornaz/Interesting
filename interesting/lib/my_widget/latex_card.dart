import 'package:flutter_math_fork/flutter_math.dart';

import 'package:flutter/material.dart';
import '../util.dart';

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
      home:TextCard(
        expressions: [
          r'\displaystyle x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}',
          r'\displaystyle y = mx + b',
          r'\displaystyle e^{i\pi} + 1 = 0',
        ],
      ),
    );
  }
}

class LatexCard extends StatelessWidget {
  /// The list of TeX strings to render.
  final List<String> expressions;

  /// Text style for all equations.
  final TextStyle textStyle;

  /// Math style (display vs inline) for all equations.
  final MathStyle mathStyle;

  const LatexCard({
    super.key,
    required this.expressions,
    this.textStyle = const TextStyle(fontSize: 24),
    this.mathStyle = MathStyle.text,
  });

  @override
  Widget build(BuildContext context) {
    // Build a list of widgets: Expanded(Math), [Divider, Expanded(Math), ...]
    final children = <Widget>[];
    for (var i = 0; i < expressions.length; i++) {
      // Each expression takes equal space
      children.add(
        Expanded(
          child: Center(
            child: Math.tex(
              expressions[i],
              textStyle: textStyle,
              mathStyle: mathStyle,
            ),
          ),
        ),
      );

      // Insert a divider after every item except the last one
      if (i < expressions.length - 1) {
        children.add(
          const Divider(
            thickness: 1,
            height: 32,
            indent: 16,
            endIndent: 16,
          ),
        );
      }
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      color: colorScheme.surfaceContainerLowest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    );
  }
}

class TextCard extends StatelessWidget {
  /// The list of TeX strings to render.
  final List<String> expressions;

  /// Text style for all equations.
  final TextStyle textStyle;

  /// Math style (display vs inline) for all equations.
  final MathStyle mathStyle;

  const TextCard({
    super.key,
    required this.expressions,
    this.textStyle = const TextStyle(fontSize: 24),
    this.mathStyle = MathStyle.text,
  });

  @override
  Widget build(BuildContext context) {
    // Build a list of widgets: Expanded(Math), [Divider, Expanded(Math), ...]
    final children = <Widget>[];
    for (var i = 0; i < expressions.length; i++) {
      // Each expression takes equal space
      children.add(
        Expanded(
          child: Center(
            child: Text(expressions[i], style: textStyle,),
          ),
        ),
      );

      // Insert a divider after every item except the last one
      if (i < expressions.length - 1) {
        children.add(
          const Divider(
            thickness: 1,
            height: 32,
            indent: 16,
            endIndent: 16,
          ),
        );
      }
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      color: colorScheme.surfaceContainerLowest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    );
  }
}
