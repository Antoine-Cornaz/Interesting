import 'package:flutter/material.dart';
import 'package:interesting/my_widget/instructions.dart';
import 'package:interesting/my_widget/question.dart';
import 'package:interesting/my_widget/small_instruction.dart';
import 'package:interesting/my_widget/sub_problem_data.dart';
import 'my_widget/bezier/Wave.dart';
import 'my_widget/answer.dart';
import 'my_widget/expandable_draggable_scrollable_container.dart';
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
      home: MyHomePage(
        subProblemData: subProblem1,
      ),
    );
  }
}

const sizeWave = 70.0;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.subProblemData});

  final SubProblemData subProblemData;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // one slot per question in your right column:
  final String title = "Taylor series";

  List<int> _bank = [];
  List<int?> _slotIds = List<int?>.filled(0, null);

  @override
  initState() {


    super.initState();
    _slotIds = widget.subProblemData.questions == null
        ? []
        : List<int?>.filled(widget.subProblemData.questions!.length, null);
    _bank = (widget.subProblemData.answers?? [])
        .asMap()
        .entries
        .map((e) => e.key)
        .toList() ; // for i in range question.length: _bank.append(i)

    _bank.shuffle();
  }

  bool get _allCorrect {
    for (var i = 0; i < _slotIds.length; i++) {
      if (i != _slotIds[i]) return false;
    }
    return true;
  }

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
        title: Text(title, style: textStyle),
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
                _buildScroll(colorScheme, widget.subProblemData.questions),

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
        onPressed: _allCorrect ? () {} : null, // () {} // null
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg, // text/icon color
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        ),

        child: Text("Next", style: buttonTextStyle),
      ),
    );
  }

  Widget _buildScroll(ColorScheme colorScheme, List<String>? questions) {
    return ExpandableDraggableScrollableContainer(
      child: Container(
        color: colorScheme.surfaceContainerLowest,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10 + sizeWave),
        child: Row(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            _buildLeftColumn(),

            // Right column
            _buildRightColumn(questions),
          ],
        ),
      ),
    );
  }

  Column _buildLeftColumn() {
    return Column(
      children: widget.subProblemData.instructions != null
          ? List.generate(widget.subProblemData.instructions!.length, (i) {
              return Instructions(instructionText: widget.subProblemData.instructions![i]);
            })
          : [],
    );
  }

  Column _buildRightColumn(List<String>? questions) {
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: questions != null
          ? List.generate(questions.length, (i) {
              return Question(
                questionText: questions[i],
                child: _slotIds[i] != null
                    ? Answer(
                        answerText: widget.subProblemData.answers![_slotIds[i]!],
                        id: _slotIds[i]!,
                      )
                    : null,
                onAccept: (id) {
                  setState(() {
                    // 1) if it came from another slot, clear that slot:
                    final origin = _slotIds.indexOf(id);

                    if (origin != -1) {
                      _slotIds[origin] = null;
                    } else {
                      // 2) otherwise it was in the bank:
                      _bank.remove(id);
                    }

                    // 3) if this slot already had an answer, return it to bank:
                    if (_slotIds[i] != null) {
                      _bank.add(_slotIds[i]!);
                    }

                    // 4) finally assign the new text here:
                    _slotIds[i] = id;
                  });
                },
              );
            })
          : [],
    );
  }

  Positioned _buildWave() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SizedBox(height: sizeWave, child: Wave()),
    );
  }

  Widget _buildFooter(ColorScheme colorScheme) {
    return Container(
      height: 100,
      color: Color.lerp(
        colorScheme.surfaceContainerLowest,
        colorScheme.surfaceTint,
        60.0 / 255,
      )!,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HorizontalExpandableDraggableScrollableContainer(
        child: Row(
          children: widget.subProblemData.answers == null
              ? []
              : _bank.map((answerData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Answer(
                      answerText: widget.subProblemData.answers![answerData],
                      id: answerData,
                    ),
                  );
                }).toList(),
        ),
      ),
    );
  }
}
