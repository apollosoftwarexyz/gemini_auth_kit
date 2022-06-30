import 'package:json_annotation/json_annotation.dart';

part 'gemini_success_response.g.dart';

@JsonSerializable()
class GeminiSuccessResponse {
  Map<String, dynamic> data;
  GeminiSuccessResponse(this.data);

  factory GeminiSuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$GeminiSuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiSuccessResponseToJson(this);
}
