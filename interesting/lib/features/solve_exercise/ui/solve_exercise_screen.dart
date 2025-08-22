import 'package:flutter/material.dart';
import 'package:interesting/data/models/exercise.dart';
import 'package:interesting/widget/instructions.dart';
import 'package:interesting/widget/question.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_theme.dart';
import '../../../../widget/bezier/Wave.dart';
import '../../../../widget/answer.dart';
import '../../../../widget/expandable_draggable_scrollable_container.dart';
import '../logic/solve_exercise_viewmodel.dart';

const heightWave = 70.0;

class SolveExerciseScreen extends StatelessWidget {
  const SolveExerciseScreen({super.key, required this.problems});

  final List<Exercise> problems;

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider creates and provides the ViewModel to its children.
    return ChangeNotifierProvider(
      create: (_) => SolveExerciseViewModel(problems),
      child: const _SolveExerciseScreen(),
    );
  }
}

class _SolveExerciseScreen extends StatelessWidget {
  const _SolveExerciseScreen();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SolveExerciseViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    final textStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(fontSize: 32);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: Row(
          children: [
            Text('Sub‐problem ${viewModel.currentIndex + 1}', style: textStyle),
          ],
        ),
      ),

      body: _buildBody(context, viewModel, colorScheme),
    );
  }

  Widget _buildBody(
    BuildContext context,
    SolveExerciseViewModel viewModel,
    ColorScheme colorScheme,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surfaceContainerLowest,
      child: Column(
        children: [
          // Expand to fill all space between AppBar and footer
          Expanded(
            child: Stack(
              children: [
                // Custom ExpandableDraggableScrollableContainer
                _buildScroll(context, viewModel, colorScheme),

                // This sits on top of the bottom‐edge of the middle area
                _buildWave(),

                _buildButtonNext(context, viewModel, colorScheme),
              ],
            ),
          ),

          _buildFooter(viewModel, colorScheme),
        ],
      ),
    );
  }

  Widget _buildButtonNext(
    BuildContext context,
    SolveExerciseViewModel viewModel,
    ColorScheme colorScheme,
  ) {
    final Color bg = colorScheme.secondary;
    final Color fg = colorScheme.onSecondary;

    final buttonTextStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(color: fg);

    // Determine the button's action based on the state
    VoidCallback? onPressedAction;
    if (viewModel.isComplete) {
      if (viewModel.allCorrect) {
        onPressedAction = () => viewModel.nextProblem(context);
      } else {
        onPressedAction = viewModel.verifyAnswers;
      }
    }

    return Container(
      alignment: Alignment(0.9, 0.7),

      child: ElevatedButton(
        onPressed: onPressedAction,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg, // text/icon color
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        ),

        child: Text(
          viewModel.allCorrect
              ? (viewModel.isLastProblem ? 'Finish' : 'Next')
              : 'Verify',
          style: buttonTextStyle,
        ),
      ),
    );
  }

  Widget _buildScroll(
    BuildContext context,
    SolveExerciseViewModel viewModel,
    ColorScheme colorScheme,
  ) {
    return ExpandableDraggableScrollableContainer(
      child: Container(
        color: colorScheme.surfaceContainerLowest,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10 + heightWave),
        child: Row(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            _buildLeftColumn(viewModel),

            // Right column
            _buildRightColumn(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftColumn(SolveExerciseViewModel viewModel) {
    return Instructions(instructionText: viewModel.instructions);
  }

  Widget _buildRightColumn(SolveExerciseViewModel viewModel) {
    final problem = viewModel.currentProblem;
    final allAnswers = [...problem.answers, ...problem.fakeAnswers];

    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(problem.questions.length, (i) {
        final answerId = viewModel.slotIds[i];
        final isCorrect = viewModel.isCorrect[i];

        return Question(
          questionText: problem.questions[i],
          isCorrect: isCorrect,
          onAccept: (id) => viewModel.onAnswerAccepted(id, i),
          child: answerId != null
              ? Answer(answerText: allAnswers[answerId], id: answerId)
              : null,
        );
      }),
    );
  }

  Positioned _buildWave() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SizedBox(height: heightWave, child: Wave()),
    );
  }

  Widget _buildFooter(
    SolveExerciseViewModel viewModel,
    ColorScheme colorScheme,
  ) {
    final problem = viewModel.currentProblem;
    final allAnswers = [...problem.answers, ...problem.fakeAnswers];

    return Container(
      height: 100,
      color: buildSurfaceVariant(colorScheme),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HorizontalExpandableDraggableScrollableContainer(
        child: Row(
          children: viewModel.bank.map((answerData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Answer(answerText: allAnswers[answerData], id: answerData),
            );
          }).toList(),
        ),
      ),
    );
  }
}
