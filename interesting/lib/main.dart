import 'package:flutter/material.dart';
import 'package:interesting/my_widget/instructions.dart';
import 'package:interesting/my_widget/question.dart';
import 'package:interesting/my_widget/smallInstruction.dart';
import 'my_widget/Bezier/Wave.dart';
import 'my_widget/answer.dart';
import 'my_widget/expandableDraggableScrollableContainer.dart';
import '../util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taylor series',
      theme: getTheme(context),
      home: const MyHomePage(title: 'Taylor series'),
    );
  }
}

const sizeWave = 70.0;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final textStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(fontSize: 32);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: Text(title, style: textStyle,),
      ),

      body: _buildBody(context),
    );
  }

  Container _buildBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surfaceContainerLowest,
      child: Column(
        children: [
          // Expand to fill all space between AppBar and footer
          Expanded(
            child: Stack(
              children: [
                // === MIDDLE AREA ===
                // Your custom ExpandableDraggableScrollableContainer
                _buildScroll(colorScheme),

                // === WAVE SHAPE ===
                // This sits on top of the bottom‐edge of the middle area
                _buildWave(),

                _buildButtonNext(context),
              ],
            ),
          ),

          // === FOOTER ===
          // Fixed height 100
          _buildFooter(colorScheme),
        ],
      ),
    );
  }

  Widget _buildButtonNext(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color bg = colorScheme.secondary;
    final Color fg = colorScheme.onSecondary;

    final buttonTextStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(color: fg);

    return Container(
      alignment: Alignment(0.9, 0.7),

      child: ElevatedButton(
        onPressed: null, // () {} // null
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg, // text/icon color
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        ),

        child: Text("Next",
          style: buttonTextStyle,
        ),
      ),
    );
  }

  ExpandableDraggableScrollableContainer _buildScroll(ColorScheme colorScheme) {
    return ExpandableDraggableScrollableContainer(
      child: Container(
        color: colorScheme.surfaceContainerLowest,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10 + sizeWave),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Column(
              children: [
                Instructions(
                  instructionText:
                      "Let’s assume any function with \nconstants parameter ai in R for all i in Z.",
                ),
              ],
            ),

            const SizedBox(width: 24),

            // Right column
            Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallInstruction(
                  instructionText: "Let f(x) = a0 + a1x + a2x² + ...",
                ),

                Question(
                  questionText: "f'(x)",
                  child: Answer(answerText: "a1 + 2a2x + 3a3x² + ..."),
                ),

                Question(questionText: "f''(x)"),

                Question(questionText: 'f⁽ⁿ⁾(x)'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildWave() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SizedBox(
        height: sizeWave,
        child: Wave(),
      ),
    );
  }

  Widget _buildFooter(ColorScheme colorScheme) {
    return Container(
      height: 100,
      color: Color.lerp(Colors.white, colorScheme.surfaceTint, 60.0 / 255)!,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HorizontalExpandableDraggableScrollableContainer(
        child: Row(
          // If you need spacing, either wrap each Answer in Padding or use SizedBox(width: …)
          children: const [
            SizedBox(width: 16),
            Answer(answerText: "Johny"),
            SizedBox(width: 16),
            Answer(answerText: "God himself"),
            SizedBox(width: 16),
            Answer(answerText: "Napoleon"),
            SizedBox(width: 16),
            Answer(answerText: "D, la réponse D"),
            SizedBox(width: 16),
            Answer(answerText: "D, la réponse D"),
            SizedBox(width: 16),
            Answer(answerText: "D, la réponse D"),
            SizedBox(width: 16),
            Answer(answerText: "D, la réponse D"),
            SizedBox(width: 16),
            Answer(answerText: "D, la réponse D"),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
