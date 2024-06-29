

import 'package:get/get.dart';

class PageVController extends GetxController {
  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int newIndex) {
    _currentIndex.value = newIndex;
    update();
  }
}