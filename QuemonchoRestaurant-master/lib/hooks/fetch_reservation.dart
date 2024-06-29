
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodly_restaurant/models/api_error.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/hook_models/hook_result.dart';
import 'package:foodly_restaurant/models/reservation_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

FetchHook  fetchRestaurantReservation(String query)
  {
 
  final isLoading = useState<bool>(false);

final appiError = useState<ApiError?>(null);
 final reservation = useState<List<Reservation>?>([]);
  
  final error = useState<Exception?>(null);


  final box = GetStorage();
  Future<void> fetchData() async {
    isLoading.value = true;
     String token = box.read('token');
  
    String? restaurantId = box.read('restaurantId');
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/restaurant/reserv/$restaurantId/?status=$query');
      final response = await http.get(url);
      print('______________________');
 print(response.statusCode);
        print(response.body);
      if (response.statusCode == 200) {
      // List  <Reservation> data =reservationFromJson( response.body);
      reservation.value = reservationFromJson(response.body);
        print(response.body); 
      } else {
        appiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }
 return FetchHook(
    data: reservation.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
 
}
