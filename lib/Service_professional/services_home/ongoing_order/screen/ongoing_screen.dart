import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

import '../../../services_bottombar/logic/orderscountcubit/orders_count_cubit.dart';
import '../../new_orders/logic/cubit/new_orders_cubit.dart';
import '../../new_orders/widget/new_order_widget.dart';
import '../../service_details/screen/service_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/ongoing_order_widget.dart';

class OngoingScreen extends StatelessWidget {
  const OngoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrdersCountCubit>().getOrdersCount();
    context.read<NewOrdersCubit>().fetchNewOrders(type: "ongoing");
    return BlocConsumer<NewOrdersCubit, NewOrdersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print("ongoing **********************${state.newOrder}");

        if (state.isLoading == true) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => OrdersLoadingWidget()),
          ));
        } else if (state.error != null &&
            state.error != "" &&
            state.error != "No Services") {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCountCubit>().getOrdersCount();
              context.read<NewOrdersCubit>().fetchNewOrders(type: "ongoing");
            },
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CommonProximaNovaTextWidget(
                    text: state.error ?? "",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                )),
          );
        } else if (state.error == "No Services") {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCountCubit>().getOrdersCount();
              context.read<NewOrdersCubit>().fetchNewOrders(type: "ongoing");
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/services_new/noorders.png",
                        height: 170,
                        width: 170,
                      ),
                    ),
                    15.ph,
                    CommonProximaNovaTextWidget(
                      text: "No Orders Yet!",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                    3.ph,
                    CommonProximaNovaTextWidget(
                      text:
                          "No Orders Yet Please wait\nfor some fantastic orders",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state.newOrder == null) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCountCubit>().getOrdersCount();
              context.read<NewOrdersCubit>().fetchNewOrders(type: "ongoing");
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/services_new/noorders.png",
                        height: 170,
                        width: 170,
                      ),
                    ),
                    15.ph,
                    CommonProximaNovaTextWidget(
                      text: "No Orders Yet!",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                    3.ph,
                    CommonProximaNovaTextWidget(
                      text:
                          "No Orders Yet Please wait\nfor some fantastic orders",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<OrdersCountCubit>().getOrdersCount();
            context.read<NewOrdersCubit>().fetchNewOrders(type: "ongoing");
          },
          child: Scaffold(
            body: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.newOrder!.length,
                itemBuilder: (context, index) {
                  print("order $index: ${state.newOrder![index]}");
                  return NewOrderWidget(
                      is_amc_subscription:state.newOrder?[index]. is_amc_subscription=='yes',
                      date: state.newOrder![index].serviceDate +
                          ", " +
                          state.newOrder![index].serviceTime,
                      deviceBrand:
                      state.newOrder?[index].device_brand ??"", model_name:
                  state.newOrder?[index].model_name ??"", service_tag:
                  state.newOrder?[index].serial_number??'',
                      device_details_updated:
                      state.newOrder?[index].device_details_updated == 'no',
                      itemsList: state.newOrder![index].serviceItems,
                      orderId: state.newOrder![index].sessionId,
                      price: state.newOrder![index].earnings.toString(),
                      buttonWidget: OngoingButtonsWidget(
                        lat: state.newOrder![index].custLatitude,
                        long: state.newOrder![index].custLongitude,
                        phoneNumber: state.newOrder![index].customerMobile,
                        buttonOnTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => OrderDetailsScreen(
                                    orderStatus: state
                                                .newOrder![index].status ==
                                            "Reached to location"
                                        ? state.newOrder![index].isQuote ==
                                                    "0" &&
                                                state.newOrder![index]
                                                        .orderhasvisitAndQuote ==
                                                    true &&
                                                state.newOrder![index]
                                                        .visitAndQuote.length ==
                                                    0
                                            ? "CREATE QUOTE"
                                            : state.newOrder![index].isQuote ==
                                                        "0" &&
                                                    state.newOrder![index]
                                                            .orderhasvisitAndQuote ==
                                                        true &&
                                                    state
                                                            .newOrder![index]
                                                            .visitAndQuote
                                                            .length !=
                                                        0
                                                ? "REVIEW QUOTE"
                                                : "START SERVICE"
                                        : "COMPLETE",
                                    orderId: state.newOrder![index].id),
                              ));
                        },
                        buttontitle: state.newOrder![index].status ==
                                "Reached to location"
                            ? state.newOrder![index].isQuote == "0" &&
                                    state.newOrder![index]
                                            .orderhasvisitAndQuote ==
                                        true &&
                                    state.newOrder![index].visitAndQuote
                                            .length ==
                                        0
                                ? "CREATE QUOTE"
                                : state.newOrder![index].isQuote == "0" &&
                                        state.newOrder![index]
                                                .orderhasvisitAndQuote ==
                                            true &&
                                        state.newOrder![index].visitAndQuote
                                                .length !=
                                            0
                                    ? "REVIEW QUOTE"
                                    : state.newOrder![index]
                                                    .paymentType ==
                                                "Pending" &&
                                            state.newOrder![index]
                                                    .orderhasvisitAndQuote ==
                                                true &&
                                            state.newOrder![index].isQuote ==
                                                "1"
                                        ? "Pending"
                                        : "START SERVICE"
                            : "COMPLETE",
                        customerName: '${state.newOrder![index].customerName}',
                      ),
                      orderOnTapFun: () {
                        print(
                            "visit and quote list length: ${state.newOrder![index].visitAndQuote.length}");
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => OrderDetailsScreen(
                                  orderStatus: state.newOrder![index].status ==
                                          "Reached to location"
                                      ? state.newOrder![index].isQuote == "0" &&
                                              state.newOrder![index]
                                                      .orderhasvisitAndQuote ==
                                                  true &&
                                              state.newOrder![index]
                                                      .visitAndQuote.length ==
                                                  0
                                          ? "CREATE QUOTE"
                                          : state.newOrder![index].isQuote ==
                                                      "0" &&
                                                  state.newOrder![index]
                                                          .orderhasvisitAndQuote ==
                                                      true &&
                                                  state
                                                          .newOrder![index]
                                                          .visitAndQuote
                                                          .length !=
                                                      0
                                              ? "REVIEW QUOTE"
                                              : "START SERVICE"
                                      : "COMPLETE",
                                  orderId: state.newOrder![index].id),
                            ));
                      });
                }),
          ),
        );
      },
    );
  }
}
