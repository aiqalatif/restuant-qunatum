// To parse this JSON data, do
//
//     final status = statusFromJson(jsonString);

import 'dart:convert';

Status statusFromJson(String str) => Status.fromJson(json.decode(str));


class Status {
    final String message;
    final bool isAvailable;

    Status({
        required this.message,
        required this.isAvailable,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        message: json["message"],
        isAvailable: json["isAvailable"],
    );
}
