// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:foodly_restaurant/constants/constants.dart';
// import 'package:foodly_restaurant/controllers/order_controller.dart';
// import 'package:foodly_restaurant/models/environment.dart';
// import 'package:foodly_restaurant/models/hook_models/hook_result.dart';
// import 'package:foodly_restaurant/models/ready_orders.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// // Custom Hook
// FetchHook useFetchClientOrders() {
//   final controller = Get.put(OrdersController());
//   final box = GetStorage();
//   final orders = useState<List<ReadyOrders>?>(null);
//   final isLoading = useState(false);
//   final error = useState<Exception?>(null);

//   // Fetch Data Function
//   Future<void> fetchData() async {
//     String token = box.read('token');
//     String accessToken = jsonDecode(token);

//     isLoading.value = true;
//     try {
//       Uri url = Uri.parse('${Environment.appBaseUrl}/api/orders/delivery/Ready');

//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $accessToken',
//         },
//       );

//       if (response.statusCode == 200) {
//         orders.value = orderFromJson(response.body);
//         controller.setCount = orders.value!.length;
//       }
//     } catch (e) {
//       Get.snackbar(e.toString(), "Failed to get data, please try again",
//           colorText: kLightWhite,
//           backgroundColor: kRed,
//           icon: const Icon(Icons.error));
//       error.value = e as Exception?;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Side Effect
//   useEffect(() {
//     fetchData();
//     return null;
//   }, const []);

//   // Refetch Function
//   void refetch() {
//     isLoading.value = true;
//     fetchData();
//   }

//   // Return values
//   return FetchHook(
//     data: orders.value,
//     isLoading: isLoading.value,
//     error: error.value,
//     refetch: refetch,
//   );
// }
