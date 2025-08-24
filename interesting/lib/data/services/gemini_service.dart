import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/exercise.dart';
import 'generative_model_adapter.dart'; // <-- Import the adapter
import 'generative_model_interface.dart'; // <-- Import the interface

class GeminiService {
  static const _apiKeyFromEnv = String.fromEnvironment('GEMINI_API_KEY');
  static final String _apiKeyFromDotEnv =
      dotenv.env['GEMINI_API_KEY'] ?? 'NO_API_KEY';
  static final String _apiKey = _apiKeyFromEnv.isNotEmpty
      ? _apiKeyFromEnv
      : _apiKeyFromDotEnv;
  static const String _modelName = 'gemini-1.5-flash';

  // --- MODIFICATION 1: Depend on the INTERFACE, not the concrete class ---
  final GenerativeModelInterface _model;

  GeminiService._()
    // --- MODIFICATION 2: The singleton now creates the real model and wraps it in the adapter ---
    : _model = GenerativeModelAdapter(
        GenerativeModel(
          model: _modelName,
          apiKey: _apiKey,
          generationConfig: GenerationConfig(
            maxOutputTokens: 2048,
            responseMimeType: 'application/json',
          ),
        ),
      );

  // The public constructor now expects the INTERFACE
  GeminiService(this._model);

  static final GeminiService _instance = GeminiService._();

  factory GeminiService.instance() {
    return _instance;
  }

  // --- NO CHANGES NEEDED BELOW THIS LINE ---
  // The rest of your logic remains exactly the same because the method signature
  // on your interface matches the one on the original class.

  Future<List<Exercise>> generateExercises(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(
        content,
      ); // This now calls the interface method

      if (response.text == null) {
        throw Exception('Received a null response from the API.');
      }

      final decodedJson = json.decode(response.text!);

      if (decodedJson is List) {
        return decodedJson
            .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw const FormatException('Expected a JSON list of exercises.');
      }
    } on FormatException catch (e) {
      print('JSON Format Error: $e');
      rethrow;
    } catch (e) {
      print('An unexpected error occurred during exercise generation: $e');
      rethrow;
    }
  }
}
