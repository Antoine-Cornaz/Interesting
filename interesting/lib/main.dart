import 'package:flutter/material.dart';
import 'package:interesting/my_widget/instructions.dart';
import 'package:interesting/my_widget/question.dart';
import 'package:interesting/my_widget/smallInstruction.dart';
import 'my_widget/Wave.dart';
import 'my_widget/answer.dart';
import 'my_widget/expandableDraggableScrollableContainer.dart';
import 'util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taylor series',
      theme: getTheme(context),
      home: const MyHomePage(title: 'Taylor series'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var colorScheme = Theme.of(context).colorScheme;
    //return _buildThings();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: Text("Taylor series"),
      ),

      body: _buildBody(colorScheme),
    );
  }

  Widget _buildBody(ColorScheme colorScheme) {
    return Container(color: colorScheme.surfaceContainerLowest, child: Column(
      children: [_buildCenter(colorScheme), Container(height: 70, width: double.infinity, child: Wave(),), _builderFooter(colorScheme)],
    ));
  }

  Widget _buildCenter(ColorScheme colorScheme) {
    return Expanded(
      child: ExpandableDraggableScrollableContainer(
        key: key,
        child: Container(
          padding: EdgeInsets.all(10),
          color: colorScheme.surfaceContainerLowest,
          child: Row(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Left column
              leftColumn(),

              // Right column
              rightColumn(),
            ],
          ),
        ),
      ),
    );
  }

  Column leftColumn() {
    return Column(
      spacing: 24,
      children: [
        SmallInstruction(instructionText: "Let f(x) = a0 + a1x + a2x² + ..."),
        Question(
          questionText: "f'(x)",
          child: Answer(answerText: "a1 + 2a2x + 3a3x² + ..."),
        ),
        Question(questionText: "f''(x)"),
        Question(questionText: 'f(n) (x)'),
      ],
    );
  }

  Column rightColumn() {
    return Column(
      children: [
        Instructions(
          instructionText:
              "Let’s assume any function with \n constants parameter ai in R for all i in Z.",
        ),
      ],
    );
  }

  Widget _builderFooter(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceTint.withAlpha(60),
      height: 100,

      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: HorizontalExpandableDraggableScrollableContainer(
        child: Row(
          spacing: 16,
          children: [
            // Wrap the Row in a SingleChildScrollView to enable horizontal scrolling
            Answer(answerText: "Johny"),
            Answer(answerText: "God himself"),
            Answer(answerText: "Napoleon"),
            Answer(answerText: "D, la réponse D"),
            Answer(answerText: "D, la réponse D"),
            Answer(answerText: "D, la réponse D"),
            Answer(answerText: "D, la réponse D"),
            Answer(answerText: "D, la réponse D"),
            Answer(answerText: "D, la réponse D"),
          ],
        ),
      ),
    );
  }
}
