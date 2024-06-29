import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_appbar.dart';
import 'package:foodly_restaurant/common/tab_widget.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/order_controller.dart';
import 'package:foodly_restaurant/controllers/restaurant_controller.dart';
import 'package:foodly_restaurant/views/reservation/acceptrequest.dart';
import 'package:foodly_restaurant/views/reservation/cancel_request.dart';
import 'package:foodly_restaurant/views/reservation/reservation_request.dart';
import 'package:get/get.dart';

class ReservationPage extends StatefulHookWidget {
  const ReservationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ReservationPage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 7,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    final restaurantController = Get.put(RestaurantController());
    
    final orderController = Get.put(OrdersController());
    _tabController.animateTo(orderController.tabIndex);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          type: true,
          onTap: () {
            restaurantController.restaurantStatus();
          },
        ),
        elevation: 0,
        backgroundColor: kLightWhite,
      ),
      body:
             
                   
          
          
        Column(children: [
             Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Container(
                  height: 25.h,
                  width: width,
                  decoration: BoxDecoration(
                    color: kOffWhite,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.white,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    labelStyle:
                        appStyle(12, kLightWhite, FontWeight.normal),
                    unselectedLabelColor: Colors.grey.withOpacity(0.7),
                    tabs:  const <Widget>[
                       Tab(
                        child: TabWidget(text: "New Request"),
                      ),
                      Tab(
                        child: TabWidget(text: "Confirmed"),
                      ),
                    
                      Tab(
                        child: TabWidget(text: "Cancelled"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: hieght * 0.7,
                child: TabBarView(
                    controller: _tabController,
                    children: const [
                   
                      AcceptRequest(),
                        ReservationRequest(),
                      CancelledRequest()
                    ]),
              ),
           
        ]
              )
               
          
          
         
        );
  }
}