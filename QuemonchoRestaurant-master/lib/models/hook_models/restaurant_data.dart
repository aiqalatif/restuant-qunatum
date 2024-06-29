import 'package:foodly_restaurant/models/api_error.dart';
import 'package:foodly_restaurant/models/restaurant_data.dart';

class FetchRestaurantReservationData {
  final Data? restaurant;
  final int ordersTotal;
  final int cancelledOrders;
  final double revenueTotal;
  final int processingOrders;
  final String restaurantToken;
  final ApiError? error;
  final bool isLoading;
  final List<LatestPayout> payout;
  final Function? refetch;

  FetchRestaurantReservationData( 
      {required this.restaurant,
      required this.ordersTotal,
      required this.cancelledOrders,
      required this.revenueTotal,
      required this.processingOrders,
      required this.restaurantToken,
      required this.error,
      required this.payout,
      required this.isLoading,
      required this.refetch});
}
