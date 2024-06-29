import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainScreenController extends GetxController {
  final box = GetStorage();

  // Reactive state using RxInt
  final RxInt _tabIndex = 0.obs;

  // Getter to expose the current value
  int get tabIndex => _tabIndex.value;

  // Setter to change the value and notify listeners
  set setTabIndex(int newValue) {
    _tabIndex.value = newValue; // Update the reactive value
    // update(); // This is optional, as .value already triggers updates
  }
}
