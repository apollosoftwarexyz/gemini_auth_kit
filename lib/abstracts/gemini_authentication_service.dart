import 'package:gemini_auth_kit/entities/gemini_login_page_content.dart';

import '../data/data_response.dart';
import '../entities/gemini_login_response.dart';

abstract class GeminiAuthenticationService {
  Future<DataResponse<RawGeminiLoginResponse>> login(
      String email, String password);

  Future<DataResponse<GeminiLoginPageContent>> fetchLogin();
}
