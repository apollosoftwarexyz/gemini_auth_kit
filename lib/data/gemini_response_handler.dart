import 'package:gemini_auth_kit/data/failure.dart';
import 'package:gemini_auth_kit/entities/gemini_success_response.dart';

abstract class GeminiResponseHandler {
  /// When we get a successful login response from gemini this function
  /// will be called.
  Future<void> handleLoginResponse(GeminiSuccessResponse response);

  /// When there is a failure picked up by the gemini data layer
  /// this function is called (this function should be optional)
  Future<void> handleLoginFailure(GeminiFailure failure) async {}
}
