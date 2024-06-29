// ignore: file_names
// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var coverFile = Rxn<File>();
  var logoFile = Rxn<File>();
  var imageOne = Rxn<File>();
  var imageTwo = Rxn<File>();
  var imageThree = Rxn<File>();
  var imageFour = Rxn<File>();

  RxList<String> _images = <String>[].obs;

  List<String> get images => _images;

  set setImages(String newValue) {
    _images.add(newValue);
  }

  RxString _coverUrl = ''.obs;

  String get coverUrl => _coverUrl.value;

  set coverUrl(String value) {
    _coverUrl.value = value;
  }

  RxString _imageOneUrl = ''.obs;

  String get imageOneUrl => _imageOneUrl.value;

  set imageOneUrl(String value) {
    _imageOneUrl.value = value;
  }

  RxString _imageTwoUrl = ''.obs;

  String get imageTwoUrl => _imageTwoUrl.value;

  set imageTwoUrl(String value) {
    _imageTwoUrl.value = value;
  }

  RxString _imageThreeUrl = ''.obs;

  String get imageThreeUrl => _imageThreeUrl.value;

  set imageThreeUrl(String value) {
    _imageThreeUrl.value = value;
  }

  RxString _imageFourUrl = ''.obs;

  String get imageFourUrl => _imageFourUrl.value;

  set imageFourUrl(String value) {
    _imageFourUrl.value = value;
  }

  RxString _logoUrl = ''.obs;

  String get logoUrl => _logoUrl.value;

  set logoUrl(String value) {
    _logoUrl.value = value;
  }

  Future<void> pickImage(String type) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (type == "logo") {
        logoFile.value = File(pickedImage.path);
        uploadImageToFirebase("logo");
        return;
      } else if (type == "cover") {
        coverFile.value = File(pickedImage.path);
        uploadImageToFirebase("cover");
        return;
      } else if (type == "one") {
        imageOne.value = File(pickedImage.path);
        uploadImageToFirebase("one");
        return;
      } else if (type == "two") {
        imageTwo.value = File(pickedImage.path);
        uploadImageToFirebase("two");
        return;
      } else if (type == "three") {
        imageThree.value = File(pickedImage.path);
        uploadImageToFirebase("three");
        return;
      } else if (type == "four") {
        imageFour.value = File(pickedImage.path);
        uploadImageToFirebase("four");
        return;
      }
    }
  }

  Future<void> uploadImageToFirebase(String type) async {
    if (type == "logo") {
      if (logoFile.value == null) return;
      try {
        String fileName =
            'images/${DateTime.now().millisecondsSinceEpoch}_${logoFile.value!.path.split('/').last}';
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child(fileName)
            .putFile(logoFile.value!);
        logoUrl = await snapshot.ref.getDownloadURL();
      } catch (e) {
        debugPrint("Error uploading");
      }
    } else if (type == "cover") {
      if (coverFile.value == null) return;
      try {
        String fileName =
            'images/${DateTime.now().millisecondsSinceEpoch}_${coverFile.value!.path.split('/').last}';
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child(fileName)
            .putFile(coverFile.value!);
        coverUrl = await snapshot.ref.getDownloadURL();
      } catch (e) {
        debugPrint("Error uploading");
      }
    } else if (type == "one") {
      if (imageOne.value == null) return;
      try {
        String fileName =
            'images/${DateTime.now().millisecondsSinceEpoch}_${imageOne.value!.path.split('/').last}';
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child(fileName)
            .putFile(imageOne.value!);
        imageOneUrl = await snapshot.ref.getDownloadURL();
        images.add(imageOneUrl);
      } catch (e) {
        debugPrint("Error uploading");
      }
    } else if (type == "two") {
      if (imageTwo.value == null) return;
      try {
        String fileName =
            'images/${DateTime.now().millisecondsSinceEpoch}_${imageTwo.value!.path.split('/').last}';
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child(fileName)
            .putFile(imageTwo.value!);
        imageTwoUrl = await snapshot.ref.getDownloadURL();
        images.add(imageTwoUrl);  
      } catch (e) {
        debugPrint("Error uploading");
      }
    } else if (type == "three") {
      if (imageThree.value == null) return;
      try {
        String fileName =
            'images/${DateTime.now().millisecondsSinceEpoch}_${imageThree.value!.path.split('/').last}';
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child(fileName)
            .putFile(imageThree.value!);
        imageThreeUrl = await snapshot.ref.getDownloadURL();
        images.add(imageThreeUrl);
      } catch (e) {
        debugPrint("Error uploading");
      }
    } else if (type == "four") {
      if (imageFour.value == null) return;
      try {
        String fileName =
            'images/${DateTime.now().millisecondsSinceEpoch}_${imageFour.value!.path.split('/').last}';
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child(fileName)
            .putFile(imageFour.value!);
        imageFourUrl = await snapshot.ref.getDownloadURL();
        images.add(imageFourUrl);
      } catch (e) {
        debugPrint("Error uploading");
      }
    }
  }
  
}
