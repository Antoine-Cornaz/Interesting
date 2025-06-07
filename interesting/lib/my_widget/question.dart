import 'package:flutter/material.dart';
import 'package:interesting/my_widget/answer.dart';
import 'package:interesting/theme.dart';

// Example of question and question-answer.
var exampleQuestions = Column(
  children: [
    Question(questionText: "f''(x) ="),

    Question(
      questionText: "f'(x) = and you know what a text slowly longer",
      child: Answer(answerText: "A bit bigger answer", id: 0,),
    ),
  ],
);

void main() => runApp(
  MaterialApp(
    home: exampleQuestions,
    theme: MyMaterialTheme(ThemeData.light().textTheme).light(),
  ),
);

class Question extends StatelessWidget {
  const Question({
    super.key,
    required this.questionText,
    this.child,
    this.onAccept,
    this.horizontalPadding = 8.0,
    this.verticalPadding = 4.0,
  });

  final String questionText;
  final Widget? child;
  final void Function(int)? onAccept;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final _ColorsAndStyles styles = _getColorsAndStyles(context);
    return Center(
      child: Card(
        shape: _buildCardShape(styles.borderColor),
        color: styles.backgroundColor,
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildQuestionText(styles.questionTextStyle),
              _buildDivider(styles.borderColor),
              _buildChildArea(),
            ],
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder _buildCardShape(Color borderColor) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: borderColor, width: 4.0),
    );
  }

  Widget _buildQuestionText(TextStyle? style) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ).copyWith(right: 0),
      child: Text(questionText, style: style),
    );
  }

  Widget _buildDivider(Color color) {
    return VerticalDivider(
      width: horizontalPadding * 2,
      thickness: 6.0,
      color: color,
    );
  }

  Widget _buildChildArea() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ).copyWith(left: 0),
      child: DragTarget<AnswerData>(
        onWillAcceptWithDetails: (_) => true,
        onAcceptWithDetails: (answerText) {
          if (onAccept != null) onAccept!(answerText.data.id);
        },
        builder: (context, candidateData, rejectedData) {
          if (child != null) {
            return child!;
          } else if (candidateData.isNotEmpty) {
            // show a preview while dragging over
            return Answer(answerText: candidateData.first!.text, id: candidateData.first!.id);
          } else {
            // empty placeholder
            return const SizedBox(width: 220, height: 56);
          }
        },
      ),
    );
  }

  _ColorsAndStyles _getColorsAndStyles(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = colorScheme.onPrimaryContainer;
    final borderColor = colorScheme.outlineVariant;
    final backgroundColor = colorScheme.primaryContainer;

    final questionTextStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(color: textColor);

    return _ColorsAndStyles(
      questionTextStyle: questionTextStyle,
      borderColor: borderColor,
      backgroundColor: backgroundColor,
    );
  }
}

class _ColorsAndStyles {
  final TextStyle? questionTextStyle;
  final Color borderColor;
  final Color backgroundColor;

  _ColorsAndStyles({
    required this.questionTextStyle,
    required this.borderColor,
    required this.backgroundColor,
  });
}


class QuestionData {
  final int id;
  final String text;
  QuestionData(this.id, this.text);
}