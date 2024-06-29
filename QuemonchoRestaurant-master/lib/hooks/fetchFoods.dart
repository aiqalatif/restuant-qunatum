import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly_restaurant/models/api_error.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/foods.dart';
import 'package:foodly_restaurant/models/hook_models/hook_result.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// Custom Hook
FetchHook useFetchFood() {
  final box = GetStorage();
  final foods = useState<List<Food>?>([]);
  final isLoading = useState(false);
  final error = useState<Exception?>(null);

  // Fetch Data Function
  Future<void> fetchData() async {
    String restaurantId = box.read('restaurantId');

    isLoading.value = true;
    try {
      final response = await http.get(
          Uri.parse('${Environment.appBaseUrl}/api/restaurant/$restaurantId/food'));
//  print(response.body);
//         print("food .body");

      if (response.statusCode == 200) {
        try {
      List<Food> parsedFoods = foodFromJson(response.body);

      // Update your state with parsed foods
      foods.value = parsedFoods;

      // Print confirmation messages
      print("Food list updated successfully $parsedFoods");
    } catch (e) {
      print("Error parsing JSON: $e");
      throw Exception("Failed to parse food data");
    }

      } else {
        var data = apiErrorFromJson(response.body);
    
        error.value = Exception(data.message);
        Get.snackbar(data.message, "Failed to get data, please try again",
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.fastfood_outlined));
      }
    } catch (e) {
      error.value = Exception('An error occurred: ${e.toString()}');
      Get.snackbar(e.toString(), "Failed to get data, please try again",
          snackPosition: SnackPosition.BOTTOM, icon: const Icon(Icons.error));
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
 
  // Side Effect
  useEffect(() {
    fetchData();
    return null;
  }, const []);

  // Refetch Function
  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  // Return values
  return FetchHook(
    data: foods.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
