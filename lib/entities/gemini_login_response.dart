class RawGeminiLoginResponse {
  final dynamic session;
  final dynamic user;
  final dynamic brand;

  const RawGeminiLoginResponse(
      {required this.session, required this.brand, required this.user});

  factory RawGeminiLoginResponse.fromJson(Map<String, dynamic> json) =>
      RawGeminiLoginResponse(
          session: json['session'], user: json['user'], brand: json['brand']);
}
