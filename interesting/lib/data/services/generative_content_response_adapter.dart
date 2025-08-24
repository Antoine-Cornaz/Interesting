import 'package:google_generative_ai/google_generative_ai.dart';
import 'generative_content_response_interface.dart';

// This adapter implements our interface and holds the real, final response object.
class GenerateContentResponseAdapter
    implements GenerateContentResponseInterface {
  final GenerateContentResponse _realResponse;

  GenerateContentResponseAdapter(this._realResponse);

  // When 'text' is called on our adapter, it passes the call
  // through to the real response object.
  @override
  String? get text => _realResponse.text;
}
