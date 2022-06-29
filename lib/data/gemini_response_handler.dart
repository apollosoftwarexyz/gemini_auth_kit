import 'package:gemini_auth_kit/entities/gemini_login_response.dart';

abstract class GeminiResponseHandler {
  Future<void> handleLoginResponse(RawGeminiLoginResponse response);
}
