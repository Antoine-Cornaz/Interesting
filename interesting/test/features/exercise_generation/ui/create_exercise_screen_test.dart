import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// No longer need to import the real google_generative_ai library directly in the test
// import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:interesting/data/services/gemini_service.dart';
import 'package:interesting/data/models/exercise.dart';
import 'package:interesting/data/services/generative_model_interface.dart';
// --- Import your new response interface ---
import 'package:interesting/data/services/generative_content_response_interface.dart';

// --- UPDATE THIS ANNOTATION ---
// Mock your own interfaces, which are not final.
// We can remove 'Candidate' because our code no longer uses it.

// If the file doesn't exist, run the following command
// dart run build_runner build --delete-conflicting-outputs
@GenerateMocks([GenerativeModelInterface, GenerateContentResponseInterface])
import 'create_exercise_screen_test.mocks.dart';

void main() {
  group('GeminiService', () {
    test(
      'throws a TypeError when the API response has an incorrect JSON structure',
      () async {
        // ARRANGE
        final mockModel = MockGenerativeModelInterface();
        // --- Use the mock for your new interface ---
        final mockResponse = MockGenerateContentResponseInterface();

        final malformedJson = jsonEncode([
          {
            "instructions": "Solve the problem.",
            "questions": ["2 + 2 = ?"],
            "solution": "The answer is 4.",
            "answers": ["4"],
            "fake_answers": ["3", "5"],
          },
        ]);

        when(mockResponse.text).thenReturn(malformedJson);
        // The line for mocking 'candidates' is no longer needed.

        when(
          mockModel.generateContent(any),
        ).thenAnswer((_) async => mockResponse);

        final geminiService = GeminiService(mockModel);

        // ACT & ASSERT
        final futureCall = geminiService.generateExercises('any prompt');
        expect(futureCall, throwsA(isA<TypeError>()));
      },
    );

    test(
      'throws a FormatException when the API response is not a valid JSON',
      () async {
        // ARRANGE
        final mockModel = MockGenerativeModelInterface();
        // --- Use the mock for your new interface ---
        final mockResponse = MockGenerateContentResponseInterface();

        const invalidJsonString = '[{"key": "value"},]';
        when(mockResponse.text).thenReturn(invalidJsonString);

        when(
          mockModel.generateContent(any),
        ).thenAnswer((_) async => mockResponse);

        final geminiService = GeminiService(mockModel);

        // ACT & ASSERT
        final futureCall = geminiService.generateExercises('any prompt');
        expect(futureCall, throwsA(isA<FormatException>()));
      },
    );

    test(
      'throws a FormatException when the API response is not a valid list',
      () async {
        // ARRANGE
        final mockModel = MockGenerativeModelInterface();
        // --- Use the mock for your new interface ---
        final mockResponse = MockGenerateContentResponseInterface();

        const invalidJsonString = '{"key": "value"}';
        when(mockResponse.text).thenReturn(invalidJsonString);

        when(
          mockModel.generateContent(any),
        ).thenAnswer((_) async => mockResponse);

        final geminiService = GeminiService(mockModel);

        // ACT & ASSERT
        final futureCall = geminiService.generateExercises('any prompt');
        expect(futureCall, throwsA(isA<FormatException>()));
      },
    );

    test('throws an Exception when the API response is null', () async {
      // ARRANGE
      final mockModel = MockGenerativeModelInterface();
      // --- Use the mock for your new interface ---
      final mockResponse = MockGenerateContentResponseInterface();

      when(mockResponse.text).thenReturn(null);

      when(
        mockModel.generateContent(any),
      ).thenAnswer((_) async => mockResponse);

      final geminiService = GeminiService(mockModel);

      // ACT & ASSERT
      final futureCall = geminiService.generateExercises('any prompt');
      expect(futureCall, throwsA(isA<Exception>()));
    });
  });
}
