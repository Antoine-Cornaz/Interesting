import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/exercise.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  // This will read the variable passed by --dart-define during the build.
  // For local development, it will be null, so we need a fallback.
  static const _apiKeyFromEnv = String.fromEnvironment('GEMINI_API_KEY');

  // Keep the dotenv logic for local development
  static final String _apiKeyFromDotEnv =
      dotenv.env['GEMINI_API_KEY'] ?? 'NO_API_KEY';

  // The final API key prioritizes the compile-time key.
  static final String _apiKey = _apiKeyFromEnv.isNotEmpty
      ? _apiKeyFromEnv
      : _apiKeyFromDotEnv;

  static const String _modelName = 'gemini-2.5-flash';

  final GenerativeModel _model;

  GeminiService._()
    : _model = GenerativeModel(
        model: _modelName,
        apiKey: _apiKey,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
      );

  static final GeminiService _instance = GeminiService._();

  factory GeminiService() {
    return _instance;
  }

  Future<List<Exercise>> generateExercises(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      // --- DEBUGGING STEP ---
      // Print the raw text from the model to see what it's sending.
      print('--- Gemini API Response ---');
      print(response.text);
      print('--------------------------');

      if (response.text != null) {
        // The rest of your code can often remain the same because the
        // Exercise.fromJson factory is now robust.
        final decodedJson = json.decode(response.text!);
        if (decodedJson is List) {
          return decodedJson
              .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (decodedJson is Map<String, dynamic> &&
            decodedJson.containsKey('exercises')) {
          final exercisesList = decodedJson['exercises'] as List;
          return exercisesList
              .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      throw Error();
    } catch (e, s) {
      // Also catch the stack trace for more details
      print('An error occurred: $e');
      print('Stack trace: $s');
      throw Error();
    }
  }
}
