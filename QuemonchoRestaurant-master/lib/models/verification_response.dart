import 'dart:convert';

VerificationResponse verificationResponseFromJson(String str) =>
    VerificationResponse.fromJson(json.decode(str));

class VerificationResponse {
  final bool verification;

  VerificationResponse({
    required this.verification,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      VerificationResponse(
        verification: json["verification"],
      );
}
