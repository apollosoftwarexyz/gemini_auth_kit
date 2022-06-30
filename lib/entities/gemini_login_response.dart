class RawGeminiLoginResponse {
  final dynamic session;
  final dynamic user;

  const RawGeminiLoginResponse({required this.session, required this.user});

  factory RawGeminiLoginResponse.fromJson(Map<String, dynamic> json) =>
      RawGeminiLoginResponse(
        session: json['session'],
        user: json['user'],
      );
}
