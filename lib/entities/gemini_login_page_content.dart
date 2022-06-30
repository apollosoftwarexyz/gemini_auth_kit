import 'package:json_annotation/json_annotation.dart';

part 'gemini_login_page_content.g.dart';

@JsonSerializable()
class GeminiLoginPageContent {
  final dynamic brand;
  final dynamic application;
  @JsonKey(name: 'query_string')
  final String queryString;

  const GeminiLoginPageContent({
    required this.brand,
    required this.application,
    required this.queryString,
  });

  Map<String, dynamic> toJson() => _$GeminiLoginPageContentToJson(this);

  factory GeminiLoginPageContent.fromJson(Map<String, dynamic> json) {
    return _$GeminiLoginPageContentFromJson(json);
  }
}
