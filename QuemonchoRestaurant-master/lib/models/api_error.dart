import 'dart:convert';

ApiError apiErrorFromJson(String str) => ApiError.fromJson(json.decode(str));


class ApiError {
    final bool status;
    final String message;

    ApiError({
        required this.status,
        required this.message,
    });

    factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        status: json["status"],
        message: json["message"],
    );
}
