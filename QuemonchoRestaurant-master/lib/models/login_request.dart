import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
    final String email;
    final String password;
    final String userType;  // Add this line to include userType

    LoginRequest({
        required this.email,
        required this.password,
        required this.userType,  // Add this line to include userType
    });

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        email: json["email"],
        password: json["password"],
        userType: json["userType"],  // Add this line to include userType
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "userType": userType,  // Add this line to include userType
    };
}
