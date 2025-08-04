// lib/card_manager.dart (Corrected)

import 'dart:math';
import 'package:flutter/material.dart';

// Assuming CardRepository is in another file
import '../card_repository.dart';

// Add "with ChangeNotifier" to make the class observable
class CardManager with ChangeNotifier {
  final List<List<String>> _allCards = CardRepository().allCards;

  bool _isFinished = false;
  int _currentLevel = 0;
  int _questionIndexInLevel = 0;
  int _levelScore = 0;
  int _max_level_succeed = -1;
  late int _min_level_failed;

  static const int questionsPerLevel = 6;
  static const int masteryThreshold = 5;

  CardManager() {
    reset();
  }

  // --- Getters ---
  String get currentCard {
    if (isFinished) return "Assessment Complete!";
    if (_currentLevel >= _allCards.length || _questionIndexInLevel >= _allCards[_currentLevel].length) {
      // This case should ideally not be reached, but it's a safe fallback.
      _finishAssessment();
      return "Finishing assessment...";
    }
    return _allCards[_currentLevel][_questionIndexInLevel];
  }

  int get finalLevel => max(0, _max_level_succeed);
  bool get isFinished => _isFinished;
  String get progressIndicator => isFinished
      ? "Finished"
      : "Question ${_questionIndexInLevel + 1} of $questionsPerLevel (Testing Level $_currentLevel)";

  // --- Response Methods ---
  void answerYes() => _processAnswer(isCorrect: true);
  void answerNo() => _processAnswer(isCorrect: false);
  void answerMaybe() => _processAnswer(isCorrect: false);

  // --- Core Logic ---
  void _processAnswer({required bool isCorrect}) {
    if (isFinished) return;

    if (isCorrect) _levelScore++;
    _questionIndexInLevel++;

    // Check if the level is complete (either by answering all questions or by reaching a definitive result early)
    bool masteryIsCertain = _levelScore >= masteryThreshold;
    bool failureIsCertain = (_questionIndexInLevel - _levelScore) > (questionsPerLevel - masteryThreshold);

    if (_questionIndexInLevel >= questionsPerLevel || masteryIsCertain || failureIsCertain) {
      _evaluateLevelCompletion();
    }

    // Notify the UI to rebuild with the new state (e.g., to show the next card).
    notifyListeners();
  }

  void _evaluateLevelCompletion() {
    bool hasMastered = _levelScore >= masteryThreshold;

    if (hasMastered) {
      _max_level_succeed = _currentLevel;
    } else {
      _min_level_failed = _currentLevel;
    }

    if (_min_level_failed - _max_level_succeed <= 1) {
      _finishAssessment();
      return;
    }

    int nextLevel = _max_level_succeed + ((_min_level_failed - _max_level_succeed) / 2).ceil();
    _prepareForNextLevel(nextLevel);
  }

  void _prepareForNextLevel(int level) {
    _currentLevel = level;
    _questionIndexInLevel = 0;
    _levelScore = 0;
  }

  void _finishAssessment() {
    if (!_isFinished) { // Prevent multiple notifications
      _isFinished = true;
      // Notify listeners that the final state has been reached.
      notifyListeners();
    }
  }

  void reset() {
    _isFinished = false;
    _max_level_succeed = -1;
    _min_level_failed = _allCards.length;
    _levelScore = 0;
    _questionIndexInLevel = 0;
    _currentLevel = 0;
    notifyListeners();
  }
}