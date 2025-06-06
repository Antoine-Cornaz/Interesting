import 'package:flutter/material.dart';
import 'package:interesting/theme.dart';

void main() => runApp(
  MaterialApp(
    home: Answer(answerText: "a1 + 2 a2x"),
    theme: MyMaterialTheme(ThemeData.light().textTheme).light(),
  ),
);

class Answer extends StatelessWidget {
  const Answer({
    super.key,
    required this.answerText, // ↔ make this required
  });

  final String answerText;

  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    var colorText = scheme.onPrimary;
    var colorBg = scheme.primary;

    final textStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(color: colorText);

    return Center(
      child: Card(
        key: key,
        color: colorBg,
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  // Now questionText can never be null here:
                  child: Text(answerText, style: textStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
