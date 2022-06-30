import 'package:flutter/material.dart';
import 'package:gemini_auth_kit/data/gemini_response_handler.dart';
import 'package:gemini_auth_kit/entities/gemini_success_response.dart';
import 'package:gemini_auth_kit/injection.dart';
import 'package:gemini_auth_kit/pages/login/gemini_login_loader_page.dart';

import 'abstracts/gemini_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  locator.registerSingleton<GeminiConfig>(_GeminiConfigImpl());
  locator
      .registerSingleton<GeminiResponseHandler>(_GeminiResponseHandlerImpl());
  configureInjection(locator);
  runApp(MaterialApp(home: GeminiLoginPage()));
}

class _GeminiConfigImpl extends GeminiConfig {
  @override
  String get appId => 'xyz.apollosoftware.houston';

  @override
  String get redirectUrl => 'http://localhost:2070/v1/auth/done';

  @override
  String? get geminiOverrideBaseUrl => 'http://localhost:2071/v1';

  @override
  int? get connectionTimeout => 5000;

  @override
  int? get receiveTimeout => 5000;
}

class _GeminiResponseHandlerImpl extends GeminiResponseHandler {
  @override
  Future<void> handleLoginResponse(GeminiSuccessResponse response) async {
    print(
        'Successful response User: ${response.data['payload']['user']}. Session: ${response.data['payload']['session']}');
  }
}
