import 'package:get/get.dart';

class ReadyForPickUpController extends GetxController {

  var refetch = false.obs;

  // Function to be called when status changes
  Function? onStatusChange;

  @override
  void onInit() {
    super.onInit();
    // Set up the listener
    ever(refetch, (_) async {
      if (refetch.isTrue && onStatusChange != null) {
        await Future.delayed(const Duration(seconds: 5));
        onStatusChange!();
      }
    });
  }

  void setOnStatusChangeCallback(Function callback) {
    onStatusChange = callback;
  }
}