abstract class GeminiConfig {
  String get appId;

  String get redirectUrl;

  String? get geminiOverrideBaseUrl;

  int? get connectionTimeout;

  int? get receiveTimeout;
}
