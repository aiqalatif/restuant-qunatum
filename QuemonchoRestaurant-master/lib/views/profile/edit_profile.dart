import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodly_restaurant/common/custom_btn.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/profile_image_controleer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart'; // Import this for FilteringTextInputFormatter

class UserUpdateScreen extends StatefulWidget {
  const UserUpdateScreen({super.key});

  @override
  _UserUpdateScreenState createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  String _username = '';
  String _email = '';
  String _phone = '';
  final box = GetStorage();
  final imageUploader = Get.put(ProfileImageController());

  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form

  Future<void> updateUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final token = box.read('token');
    if (token == null) {
      throw Exception('Token is null');
    }
    final accessToken = jsonDecode(token);

    const String apiUrl =
        '$appBaseUrl/api/users'; 

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, String>{
          'username': _username,
          'email': _email,
          'phone': _phone,
          'profile': imageUploader.coverUrl, // Use the uploaded image URL
        }),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('User details updated successfully');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User details updated successfully!")),
        );
      } else {
        if (kDebugMode) {
          print('Error updating user details: ${response.body}');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating user details: ${response.body}")),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter User Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form( // Wrap the Column in a Form widget
          key: _formKey, // Assign the GlobalKey to the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                onChanged: (value) => setState(() => _username = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => setState(() => _email = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) => setState(() => _phone = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  } else if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () => imageUploader.pickImage("profile", context),
                text: 'Pick Image',
              ),
              const SizedBox(height: 20),
              Obx(() => imageUploader.coverFile.value != null
                  ? Image.file(
                      imageUploader.coverFile.value!,
                      height: 100,
                    )
                  : const SizedBox(height: 0)),
              const SizedBox(height: 20),
              CustomButton(
                onTap: updateUser,
                text: 'Update User',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
