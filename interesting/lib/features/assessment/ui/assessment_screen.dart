import 'dart:math';

import 'package:flutter/material.dart';
import '../../../core/app_utils.dart';
import '../../../data/models/sub_problem_data.dart';
import '../../solve_exercise/ui/solve_exercise_screen.dart';
import '../logic/assessment_manager.dart';
import '../../../widget/latex_card.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AssessmentManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Screen',
      theme: getTheme(context),
      home: AssessmentScreen(),
    );
  }
}

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  Offset _dragOffset = Offset.zero;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final cardManager = Provider.of<AssessmentManager>(context, listen: false);
    final dx = _dragOffset.dx;
    final dy = _dragOffset.dy;
    bool swiped = false;

    if (dx > 100) {
      cardManager.answerYes();
      swiped = true;
    } else if (dx < -100) {
      cardManager.answerNo();
      swiped = true;
    } else if (dy < -100) {
      cardManager.answerMaybe();
    }

    if (!swiped) {
      setState(() => _dragOffset = Offset.zero);
    } else {
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() => _dragOffset = Offset.zero);
      });
    }
  }

  static const maxWidthCard = 600.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    final ellipseColor = colorScheme.surface;
    final ellipseColorInside = colorScheme.secondary;

    return Consumer<AssessmentManager>(
      builder: (context, cardManager, child) {
        // Check if the assessment is finished
        if (cardManager.isFinished) {
          // Use addPostFrameCallback to navigate after the build is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SolveExerciseScreen(problems: problem1),
              ),
            );
          });
        }

        // Return the scaffold and the rest of your UI
        // This part of the UI will be rebuilt when cardManager notifies listeners
        return Scaffold(
          backgroundColor: colorScheme.primary,
          body: buildMainBody(
            size,
            ellipseColorInside,
            ellipseColor,
            colorScheme,
            context,
            cardManager,
          ),
        );
      },
    );
  }

  Widget buildMainBody(
    Size size,
    Color ellipseColorInside,
    Color ellipseColorOutside,
    ColorScheme colorScheme,
    BuildContext context,
    AssessmentManager cardManager,
  ) {
    return Stack(
      children: [
        // 1) giant ellipse
        buildGiantEllipses(size, ellipseColorOutside),

        // 2) giant ellipse
        buildGiantEllipses(size, ellipseColorInside, scaleFactor: 0.83),

        // 3) main content
        buildMainContent(context, colorScheme, cardManager),
      ],
    );
  }

  Widget buildGiantEllipses(
    Size size,
    Color ellipseColor, {
    double scaleFactor = 1.0,
  }) {
    return Positioned(
      top: -size.height * .8,
      left: -200,
      right: -240,
      child: Container(
        width: min(size.width, maxWidthCard) * 2.2 * scaleFactor,
        height: size.height * 1.80 * scaleFactor,
        decoration: BoxDecoration(
          color: ellipseColor,
          borderRadius: BorderRadius.circular(size.height),
        ),
      ),
    );
  }

  Widget buildBottomLine(ColorScheme colorScheme) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(height: 3.5, color: colorScheme.onPrimaryContainer),
    );
  }

  Widget buildMainContent(
    BuildContext context,
    ColorScheme colorScheme,
    AssessmentManager cardManager,
  ) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidthCard),
        child: Column(
          children: [
            // a) header text
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              child: buildInstructions(context, colorScheme),
            ),

            // b) the card with LaTeX, now with horizontal padding
            buildLatexCard(cardManager),

            // c) buttons row
            buildButtons(colorScheme, cardManager),
          ],
        ),
      ),
    );
  }

  Widget buildInstructions(BuildContext context, ColorScheme colorScheme) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: "Let's Find Your Math Level",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLatexCard(AssessmentManager cardManager) {
    final content = cardManager.currentCard;

    return Expanded(
      child: GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 12, 40, 0),
          child: Transform.translate(
            offset: _dragOffset,
            child: Transform.rotate(
              angle: _dragOffset.dx * 0.001,
              child: cardManager.isInstruction
                  ? TextCard(expressions: [content])
                  : LatexCard(expressions: [content]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtons(ColorScheme colorScheme, AssessmentManager cardManager) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(120, 12, 120, 120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              // Too Hard button
              buildElevatedButton(
                () {
                  setState(() {
                    cardManager.answerNo();
                  });
                },
                colorScheme.tertiary,
                colorScheme.onTertiary,
                'No',
                Icons.arrow_back_rounded,
              ),

              // Not sure button
              buildElevatedButton(
                () {
                  setState(() {
                    cardManager.answerMaybe();
                  });
                },
                colorScheme.secondary,
                colorScheme.onSecondary,
                'Maybe',
                Icons.arrow_upward,
              ),

              // Easy button
              buildElevatedButton(
                () {
                  setState(() {
                    cardManager.answerYes();
                  });
                },
                colorScheme.primary,
                colorScheme.onPrimary,
                'Yes',
                Icons.arrow_forward_sharp,
              ),
            ],
          ),
        ),

        // back icon button
        //buildBackButton(colorScheme),
      ],
    );
  }

  Widget buildElevatedButton(
    void Function()? onPressed,
    Color backgroundColor,
    Color foregroundColor,
    String data,
    IconData icon,
  ) {
    final textStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: foregroundColor);

    return Expanded(
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(data, style: textStyle),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Widget buildBackButton(ColorScheme colorScheme) {
    return Positioned(
      top: 5,
      left: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: CircleBorder(),
          side: BorderSide(color: colorScheme.outline, width: 1.0),
          padding: EdgeInsets.all(20.0),
          backgroundColor: colorScheme.surfaceContainerLow,
          foregroundColor: colorScheme.onSurfaceVariant, // optional fill
        ),
        onPressed: () {
          setState(() {
            //cardManager.previousCard();
          });
        },
        child: Icon(Icons.undo),
      ),
    );
  }
}
