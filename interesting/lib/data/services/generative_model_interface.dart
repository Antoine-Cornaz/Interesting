import 'package:google_generative_ai/google_generative_ai.dart';
import 'generative_content_response_interface.dart';

abstract class GenerativeModelInterface {
  // The method must now return a Future of our new interface.
  Future<GenerateContentResponseInterface> generateContent(
    Iterable<Content> prompt,
  );
}
