// Import necessary packages and libraries
import 'dart:convert';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/hook_models/hook_result.dart';
import 'package:foodly_restaurant/models/ready_orders.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// Custom Hook
FetchHook useFetchPicked(String query) {
  final box = GetStorage();
  final orders = useState<List<ReadyOrders>?>(null);
  final isLoading = useState(false);
  final error = useState<Exception?>(null);

  // Fetch Data Function
  Future<void> fetchData() async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);
    String? restaurant = box.read('restaurantId');

    isLoading.value = true;
    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/orders/getOrdersByRestaurant/$restaurant?orderStatus=$query');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        orders.value = orderFromJson(response.body);
        error.value = null; // Reset error state if successful
      } else {
        error.value = Exception(response.body);
      }
    } catch (error) {
      Exception('Failed to get data, please try again');
      print('Fetch Data Error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  // Side Effect - useEffect is used to call fetchData initially
  useEffect(() {
    fetchData();
    
    // Cleanup logic if needed (e.g., cancel ongoing HTTP requests)
    return () {
      // Implement cleanup logic here
      // For example, cancel ongoing HTTP requests
      // If you are using a package like http, you may cancel requests using a cancellation token
      // Example: cancelToken.cancel();

      // Ensure that state values are reset or disposed if needed
      orders.dispose(); // Dispose the ValueNotifier
      isLoading.dispose(); // Dispose the ValueNotifier
      error.dispose(); // Dispose the ValueNotifier
    };
  }, []);

  // Refetch Function
  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  // Return values
  return FetchHook(
    data: orders.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
