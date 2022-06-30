import '../data/data_response.dart';
import '../entities/gemini_login_response.dart';

abstract class GeminiAuthenticationService {
  Future<DataResponse<RawGeminiLoginResponse>> login(
      String email, String password);
}
