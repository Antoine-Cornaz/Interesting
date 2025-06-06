import 'package:flutter/material.dart';
import 'package:interesting/theme.dart';

void main() => runApp(MaterialApp(home: QuestionAnswer(), theme: MyMaterialTheme(ThemeData.light().textTheme).light()));

class QuestionAnswer extends StatelessWidget {
  const QuestionAnswer({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card.outlined(key: key,
          color: Theme.of(context).colorScheme.primary,

          child: Text("Coucou je suis une carte", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        )
    );
  }
}
