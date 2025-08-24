import 'package:google_generative_ai/google_generative_ai.dart';
import 'generative_model_interface.dart';
// Import our new response adapter
import 'generative_content_response_adapter.dart';
import 'generative_content_response_interface.dart';

class GenerativeModelAdapter implements GenerativeModelInterface {
  final GenerativeModel _model;

  GenerativeModelAdapter(this._model);

  // --- UPDATE THIS METHOD ---
  @override
  Future<GenerateContentResponseInterface> generateContent(
    Iterable<Content> prompt,
  ) async {
    // 1. Call the real model to get the real, final response object.
    final realResponse = await _model.generateContent(prompt);

    // 2. Wrap the real response in our adapter before returning it.
    return GenerateContentResponseAdapter(realResponse);
  }
}
