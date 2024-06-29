import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var coverFile = Rxn<File>();
  final RxString _coverUrl = ''.obs;

  String get coverUrl => _coverUrl.value;

  set coverUrl(String value) {
    _coverUrl.value = value;
  }

  Future<void> pickImage(String type, BuildContext context) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverFile.value = File(pickedImage.path);
      await uploadImageToFirebase(type, context);
    }
  }

  Future<void> uploadImageToFirebase(String type, BuildContext context) async {
    if (type == "profile") {
      if (coverFile.value == null) return;
      try {
        String fileName =
            'images/${DateTime.now().millisecondsSinceEpoch}_${coverFile.value!.path.split('/').last}';
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child(fileName)
            .putFile(coverFile.value!);
        coverUrl = await snapshot.ref.getDownloadURL();
        if (kDebugMode) {
          print("Image uploaded successfully: $coverUrl");
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image uploaded successfully!")),
        );
      } catch (e) {
        if (kDebugMode) {
          print("Error uploading image: $e");
        }
      }
    }
  }
}
