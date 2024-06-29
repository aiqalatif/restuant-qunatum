import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/hooks/fetchRestaurantOrders.dart';
import 'package:foodly_restaurant/models/ready_orders.dart';
import 'package:foodly_restaurant/views/home/widgets/empty_page.dart';
import 'package:foodly_restaurant/views/home/widgets/order_tile.dart';

class CancelledOrders extends HookWidget {
  const CancelledOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchPicked("cancelled");
    List<ReadyOrders>? orders = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;

    if (isLoading) {
      return const FoodsListShimmer();
    } else if (orders!.isEmpty) {
      return const EmptyPage();
    }

    return Container(
      height: hieght,
      width: width,
      color: Colors.transparent,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w),
          itemCount: orders.length,
          itemBuilder: (context, i) {
            ReadyOrders order = orders[i];
            return OrderTile(order: order, active: 'active');
          }),
    );
  }
}
