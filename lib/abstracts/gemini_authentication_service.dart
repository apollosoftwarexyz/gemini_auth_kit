import 'package:gemini_auth_kit/entities/gemini_login_page_content.dart';

import '../data/data_response.dart';
import '../gemini_auth_kit.dart';

abstract class GeminiAuthenticationService {
  Future<DataResponse<GeminiSuccessResponse>> login(
      String email, String password);

  Future<DataResponse<GeminiLoginPageContent>> fetchLogin();
}
