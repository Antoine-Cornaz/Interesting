import 'package:flutter/material.dart';
import 'package:interesting/data/models/exercise.dart';
import '../../exercise_generation/ui/create_exercise_screen.dart';

class SolveExerciseViewModel extends ChangeNotifier {
  final List<Exercise> _problems;
  int _currentIndex = 0;

  List<int?> _slotIds = [];
  List<int> _bank = [];
  List<bool> _isCorrect = [];
  bool _isVerified = false; // NEW: Tracks if the verification has been run.

  // Public getters
  int get currentIndex => _currentIndex;
  List<int?> get slotIds => _slotIds;
  List<int> get bank => _bank;
  List<bool> get isCorrect => _isCorrect;
  Exercise get currentProblem => _problems[_currentIndex];
  bool get isVerified => _isVerified;

  bool get isComplete => !_slotIds.contains(null);
  bool get isLastProblem => _currentIndex >= _problems.length - 1;

  String get instructions => _problems[_currentIndex].instructions;

  // This is only true if verification has been run AND all answers are correct.
  bool get allCorrect => _isVerified && !_isCorrect.contains(false);

  SolveExerciseViewModel(this._problems) {
    _initForCurrentProblem();
  }

  void _initForCurrentProblem() {
    final problem = currentProblem;
    final questionsCount = problem.questions.length;
    final allAnswersCount = problem.answers.length + problem.fakeAnswers.length;

    _slotIds = List<int?>.filled(questionsCount, null);
    _bank = List<int>.generate(allAnswersCount, (i) => i)..shuffle();
    _isCorrect = List<bool>.filled(questionsCount, true);
    _isVerified = false; // Reset verification status for the new problem.

    notifyListeners();
  }

  void onAnswerAccepted(int answerId, int slotIndex) {
    final originIndex = _slotIds.indexOf(answerId);
    if (originIndex != -1) {
      _slotIds[originIndex] = null;
    } else {
      _bank.remove(answerId);
    }

    if (_slotIds[slotIndex] != null) {
      _bank.add(_slotIds[slotIndex]!);
    }

    _slotIds[slotIndex] = answerId;

    // CRUCIAL FIX: If the user changes an answer, the previous verification
    // is no longer valid. Reset the state to force a new verification.
    _isCorrect = List<bool>.filled(currentProblem.questions.length, true);
    _isVerified = false;

    notifyListeners();
  }

  // This function now also sets the verification status.
  void verifyAnswers() {
    if (!isComplete) return; // Should not be callable, but as a safeguard.

    for (int i = 0; i < _slotIds.length; i++) {
      _isCorrect[i] = (_slotIds[i] == i);
    }
    _isVerified = true; // Mark that verification has happened.
    notifyListeners();
  }

  void nextProblem(BuildContext context) {
    if (isLastProblem) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CreateExerciseAiScreen()),
      );
    } else {
      _currentIndex++;
      _initForCurrentProblem(); // This will reset all the state for the new problem.
    }
  }
}
