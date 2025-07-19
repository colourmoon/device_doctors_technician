import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

import '../../../registration/registrationflow/profile_verification/cubit/profile_verfication_cubit.dart';
import '../../../services_bottombar/logic/orderscountcubit/orders_count_cubit.dart';
import '../../new_orders/logic/cubit/new_orders_cubit.dart';
import '../../new_orders/widget/new_order_widget.dart';
import '../../service_details/screen/service_details_screen.dart';
import '../widget/ongoing_order_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'accepted_screen.dart';
import 'ongoing_screen.dart';

class OngoingOrdersScreen extends StatefulWidget {
  @override
  _OngoingOrdersScreenState createState() => _OngoingOrdersScreenState();
}

class _OngoingOrdersScreenState extends State<OngoingOrdersScreen>
    with SingleTickerProviderStateMixin {
  late ProfileVerficationCubit verificationcubit;
  late TabController _tabController;

  @override
  void initState() {
    context.read<OrdersCountCubit>().getOrdersCount();
    verificationcubit = ProfileVerficationCubit();
    verificationcubit.profileVerificationCheck();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => verificationcubit,
      child: BlocConsumer<ProfileVerficationCubit, ProfileVerficationState>(
        listener: (context, verificationState) {
          if (verificationState.verificationModel!.vendorStatus != "0") {
            context.read<NewOrdersCubit>().fetchNewOrders(type: "accepted");
          }
          // TODO: implement listener
        },
        builder: (context, verificationState) {
          if (verificationState.verificationModel?.vendorStatus == "0") {
            return Scaffold(
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProfileVerficationCubit>()
                      .profileVerificationCheck();
                },
                child: Center(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/services_new/verificationpending.png",
                            height: 170,
                            width: 170,
                          ),
                        ),
                        SizedBox(height: 15),
                        CommonProximaNovaTextWidget(
                          text: "Your Profile is\nUnder Verification!",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 3),
                        CommonProximaNovaTextWidget(
                          text:
                              "Please wait until our team\nverify your profile",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (verificationState.isLoading == true) {
            return Scaffold(
                body: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => OrdersLoadingWidget()),
            ));
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 0.5,
                            color: Colors.grey)), // Add border to the container
                  ),
                  child: BlocBuilder<OrdersCountCubit, OrdersCountState>(
                    builder: (context, state) {
                      if (state.orderscount != null) {
                        return TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          indicatorWeight: 3,
                          indicatorColor: AppthemeColor().appAnotherColor,
                          labelStyle: TextStyle(
                              fontFamily: AppthemeColor().themeFont,
                              color: AppthemeColor().appAnotherColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          unselectedLabelStyle: TextStyle(
                              fontFamily: AppthemeColor().themeFont,
                              color: AppthemeColor().tabTitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          indicatorSize: TabBarIndicatorSize.label,

                          // indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                          controller: _tabController,
                          isScrollable: false,
                          tabs: [
                            Tab(
                                text: (state.orderscount!.acceptedOrders ==
                                            "0" ||
                                        state.orderscount!.acceptedOrders == 0)
                                    ? "Accepted"
                                    : 'Accepted(${state.orderscount!.acceptedOrders})'),
                            Tab(
                                text: (state.orderscount!.ongoingOrders ==
                                            "0" ||
                                        state.orderscount!.ongoingOrders == 0)
                                    ? "Ongoing"
                                    : 'Ongoing(${state.orderscount!.ongoingOrders})'),
                          ],
                        );
                      }
                      return TabBar(
                        physics: const NeverScrollableScrollPhysics(),
                        indicatorWeight: 3,
                        indicatorColor: AppthemeColor().appAnotherColor,
                        labelStyle: TextStyle(
                            fontFamily: AppthemeColor().themeFont,
                            color: AppthemeColor().appAnotherColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        unselectedLabelStyle: TextStyle(
                            fontFamily: AppthemeColor().themeFont,
                            color: AppthemeColor().tabTitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        indicatorSize: TabBarIndicatorSize.label,

                        // indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                        controller: _tabController,
                        isScrollable: false,
                        tabs: const [
                          Tab(text: 'Accepted'),
                          Tab(text: 'Ongoing'),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      // Content for Tab 1
                      AcceptedScreen(),
                      // Content for Tab 2
                      OngoingScreen()
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
