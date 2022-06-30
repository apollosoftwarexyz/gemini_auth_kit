import 'package:json_annotation/json_annotation.dart';

part 'gemini_login_response.g.dart';
@JsonSerializable()
class RawGeminiLoginResponse {
  final dynamic session;
  final dynamic user;

  const RawGeminiLoginResponse({required this.session, required this.user});

  factory RawGeminiLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$RawGeminiLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RawGeminiLoginResponseToJson(this);
}
