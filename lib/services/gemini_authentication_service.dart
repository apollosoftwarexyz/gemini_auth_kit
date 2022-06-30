import 'package:gemini_auth_kit/data/gemini_data_layer.dart';

import '../data/data_response.dart';
import '../entities/gemini_login_page_content.dart';
import '../gemini_auth_kit.dart';

/// Consumer facing class that handles the calls to the data layer and handles
/// logging and contacting other services
class GeminiAuthenticationServiceImpl extends GeminiAuthenticationService {
  final GeminiDataLayer _dataLayer;
  GeminiAuthenticationServiceImpl(this._dataLayer);

  Future<DataResponse<GeminiLoginPageContent>> fetchLogin() {
    return _dataLayer.fetchLogin();
  }

  @override
  Future<DataResponse<RawGeminiLoginResponse>> login(
      String email, String password) {
    // TODO: Log with analytics
    return _dataLayer.login(email, password);
  }
}
