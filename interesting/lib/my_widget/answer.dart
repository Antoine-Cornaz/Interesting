import 'package:flutter/material.dart';
import 'package:interesting/theme.dart';

void main() => runApp(
  MaterialApp(
    home: Answer(answerText: "a1 + 2 a2x",),
    theme: MyMaterialTheme(ThemeData.light().textTheme).light(),
  ),
);

class Answer extends StatelessWidget {
  const Answer({
    super.key,
    required this.answerText,
  });

  final String answerText;

  @override
  Widget build(BuildContext context) {
    final scheme    = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context)
        .textTheme.headlineSmall
        ?.copyWith(color: scheme.onPrimary);

    final card = Card(
      key: key,
      color: scheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(answerText, style: textStyle),
      ),
    );

    return Draggable<String>(
      data: answerText,
      feedback: Material(elevation: 4, child: card),
      childWhenDragging: Opacity(opacity: 0.4, child: card),
      child: card,
    );
  }
}