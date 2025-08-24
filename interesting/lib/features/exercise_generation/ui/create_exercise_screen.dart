import 'package:flutter/material.dart';

import '../../../data/services/gemini_service.dart';
import '../../solve_exercise/ui/solve_exercise_screen.dart';

class CreateExerciseAiScreen extends StatelessWidget {
  const CreateExerciseAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A controller to potentially get the text from the TextField later
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      // AppBar provides the top bar with a title and action buttons
      appBar: AppBar(
        // The title of the screen
        title: const Text('Create a New Exercise'),
        backgroundColor: Colors.blueGrey[800], // A slightly more modern color
        foregroundColor: Colors.white,
        actions: [
          // The "Go Home" button on the top right
          buildReturnButton(),
        ],
      ),
      // Padding adds space around the main content of the screen
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          // Aligns children to the start of the column (top)
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The instructional text for the user
            const Text(
              'What subject would you like to practice?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // This is the key to making the TextField take up most of the space.
            // Expanded tells its child (the TextField) to fill all available
            // vertical space in the Column.
            Expanded(
              child: TextField(
                controller: textController,
                // maxLines: null and expands: true work together to make the
                // TextField grow to fill the available space.
                maxLines: null,
                expands: true,
                // This ensures the text starts from the top, not the center
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText:
                      'e.g., "Calculus: Integration by parts", "Basic algebra", "Differential equation", ...',
                  // A nice border to visually contain the TextField
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // Fills the text field with a light color to distinguish it
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),

            // The button at the bottom of the screen
            buildCreateButton(textController, context),
          ],
        ),
      ),
    );
  }

  IconButton buildReturnButton() {
    return IconButton(
      icon: const Icon(Icons.home),
      tooltip: 'Go Home',
      onPressed: () {
        // TODO: Implement navigation to your home screen
        // For example: Navigator.of(context).popUntil((route) => route.isFirst);
        print('Home button pressed!');
      },
    );
  }

  ElevatedButton buildCreateButton(
    TextEditingController textController,
    BuildContext context,
  ) {
    final gemini = GeminiService.instance();
    return ElevatedButton(
      onPressed: () async {
        final String exerciseTopic = textController.text;

        final prompt =
            '''  Generate a list of 2 questions by 2 exercises so 4 questions in total about the following theme: {$exerciseTopic}.
  For each exercise, provide:
  - name_of_exercise: A short title for the exercise.
  - instructions: How to complete the exercise.
  - questions: The questions to be asked.
  - solution: The steps to solve all the question in one string.
  - answers: A list of correct answers in the same order as the questions.
  - fake_answers: A list of incorrect answers that are plausible.
  ''';

        try {
          final problem = await gemini.generateExercises(prompt);
          // You might show a loading indicator or navigate to the next screen here
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SolveExerciseScreen(problems: problem),
            ),
          );
        } catch (err) {
          print('Caught error: $err');
        }
      },
      style: ElevatedButton.styleFrom(
        // A strong background color to make it stand out
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        // Makes the button taller and more tappable
        padding: const EdgeInsets.symmetric(vertical: 16),
        // Gives the button a modern, slightly rounded look
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Create Exercise',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
