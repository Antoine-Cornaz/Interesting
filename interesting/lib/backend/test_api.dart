import '../data/services/gemini_service.dart';

void main() async {
  final gemini = GeminiService();

  final prompt = '''
  Generate a list of 3 questions by 3 exercises so 9 questions in total about derivatives and integrals.
  For each exercise, provide:
  - name_of_exercise: A short title for the exercise.
  - instructions: How to complete the exercise.
  - questions: The questions to be asked.
  - solution: The steps to solve all the question in one string.
  - answers: A list of correct answers in the same order as the questions.
  - fake_answers: A list of incorrect answers that are plausible.
  ''';

  final exercises = await gemini.generateExercises(prompt);

  if (exercises.isNotEmpty) {
    for (var i = 0; i < exercises.length; i++) {
      final exercise = exercises[i];
      print('--- Exercise ${i + 1} ---');
      print('Name: ${exercise.nameOfExercise}');
      print('Instructions: ${exercise.instructions}');
      print('Questions: ${exercise.questions}');
      print('Correct Answers: ${exercise.answers}');
      print('Fake Answers: ${exercise.fakeAnswers}');
      print('\n');
    }
  } else {
    print('No exercises were generated.');
  }
}