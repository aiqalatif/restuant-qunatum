import 'dart:convert';

SuccessResponse successResponseFromJson(String str) => SuccessResponse.fromJson(json.decode(str));


class SuccessResponse {
    final bool status;
    final String message;

    SuccessResponse({
        required this.status,
        required this.message,
    });

    factory SuccessResponse.fromJson(Map<String, dynamic> json) => SuccessResponse(
        status: json["status"],
        message: json["message"],
    );
}
