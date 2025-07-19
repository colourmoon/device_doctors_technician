import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:intl/intl.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import '../../../registration/registrationflow/profile_verification/cubit/profile_verfication_cubit.dart';
import '../../new_orders/logic/cubit/new_orders_cubit.dart';
import '../../new_orders/widget/new_order_widget.dart';
import '../../service_details/screen/service_details_screen.dart';
import '../widget/completed_orders_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedOrdersScreen extends StatefulWidget {
  const CompletedOrdersScreen({super.key});

  @override
  State<CompletedOrdersScreen> createState() => _CompletedOrdersScreenState();
}

class _CompletedOrdersScreenState extends State<CompletedOrdersScreen> {
  late ProfileVerficationCubit verificationcubit;
  TextEditingController fromcontroller = TextEditingController();
  TextEditingController tocontroller = TextEditingController();
  String? formattedDate;
  @override
  void initState() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);

    verificationcubit = ProfileVerficationCubit();
    verificationcubit.profileVerificationCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => verificationcubit,
      child: BlocConsumer<ProfileVerficationCubit, ProfileVerficationState>(
        listener: (context, verificationState) {
          if (verificationState.verificationModel!.vendorStatus != "0") {
            context.read<NewOrdersCubit>().fetchNewOrders(
                type: "completed",
                fromdate: fromcontroller.text,
                todate: tocontroller.text);
          }
          // TODO: implement listener
        },
        builder: (context, verificationState) {
          print(
              "verification model :${verificationState.verificationModel?.vendorStatus}");
          if (verificationState.verificationModel?.vendorStatus == "0") {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/services_new/verificationpending.png",
                      height: 170,
                      width: 170,
                    ),
                  ),
                  15.ph,
                  CommonProximaNovaTextWidget(
                    text: "Your Profile is\nUnder Verification!",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                  3.ph,
                  CommonProximaNovaTextWidget(
                    text: "Please wait until our team\nverify your profile",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (verificationState.isLoading == true) {
            return Scaffold(
                body: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => const OrdersLoadingWidget()),
            ));
          }
          return BlocConsumer<NewOrdersCubit, NewOrdersState>(
            listener: (context, state) {
              // print("state emitted : ${state.newOrder!.length}");
              print(
                  "${state.isLoading},,,,,,,,,,, ${state.error} ,,,,,,,,,,,,,${state.newOrder}");
              // TODO: implement listener
            },
            builder: (context, state) {
              // print(
              //     "${state.isLoading},,,,,,,,,,, ${state.error} ,,,,,,,,,,,,,${state.newOrder}");
              // if (state.isLoading == true) {
              //   return Scaffold(
              //       body: Padding(
              //     padding: const EdgeInsets.only(top: 10),
              //     child: ListView.builder(
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: 5,
              //         itemBuilder: (context, index) =>
              //             const OrdersLoadingWidget()),
              //   )
              // }
              if (state.error != null &&
                  state.error != "" &&
                  state.error != "No Services") {
                return Scaffold(
                    body: Center(
                  child: CommonProximaNovaTextWidget(
                    text: state.error ?? "",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ));
              }
              //  else if (state.newOrder == null) {
              //   return RefreshIndicator(
              //     onRefresh: () async {
              //       context
              //           .read<NewOrdersCubit>()
              //           .fetchNewOrders(type: "completed");
              //     },
              //     child: SingleChildScrollView(
              //       physics: BouncingScrollPhysics(),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         mainAxisSize: MainAxisSize.max,
              //         children: [
              //           Center(
              //             child: Image.asset(
              //               "assets/services_new/noorders.png",
              //               height: 170,
              //               width: 170,
              //             ),
              //           ),
              //           15.ph,
              //           CommonProximaNovaTextWidget(
              //             text: "No Orders Yet!",
              //             fontSize: 20,
              //             fontWeight: FontWeight.w600,
              //             color: Colors.black,
              //             textAlign: TextAlign.center,
              //           ),
              //           3.ph,
              //           CommonProximaNovaTextWidget(
              //             text:
              //                 "No Orders Yet Please wait\nfor some fantastic orders",
              //             fontSize: 14,
              //             fontWeight: FontWeight.w400,
              //             color: Colors.black,
              //             textAlign: TextAlign.center,
              //           ),
              //         ],
              //       ),
              //     ),
              //   );
              // }
              return Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CommonProximaNovaTextWidget(
                          text: state.newOrder == null
                              ? "Completed Jobs"
                              : "Completed Jobs (${state.newOrder?.length})",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      10.ph,
                      DateFiltersWidget(
                        fromcontroller: fromcontroller,
                        tocontroller: tocontroller,
                        fromDateOnTap: () {
                          _selectDate(context, fromcontroller, "from");
                        },
                        toDateOnTap: () {
                          _selectDate(context, tocontroller, "to");
                        },
                      ),
                      5.ph,
                      BlocBuilder<NewOrdersCubit, NewOrdersState>(
                        builder: (context, state) {
                          if (state.isLoading == true) {
                            return const Expanded(
                                child: Center(child: ThemeSpinner()));
                          } else if (state.error == "No Services") {
                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
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
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: state.newOrder?.length ?? 0,
                              itemBuilder: (context, index) => NewOrderWidget(
                                  date:
                                      "${state.newOrder?[index].serviceDate}, ${state.newOrder?[index].serviceTime}",
                                  itemsList:
                                      state.newOrder?[index].serviceItems ?? [],
                                  device_details_updated:
                                  state.newOrder?[index].device_details_updated == 'no',
                                  is_amc_subscription:state.newOrder?[index]. is_amc_subscription=='yes',
                                  orderId:
                                      state.newOrder?[index].sessionId ?? '',
                                  deviceBrand:
                                  state.newOrder?[index].device_brand ??"", model_name:
                              state.newOrder?[index].model_name ??"", service_tag:
                              state.newOrder?[index].serial_number??'',
                                  price: state.newOrder?[index].earnings
                                          .toString() ??
                                      '',
                                  isRating:
                                      state.newOrder?[index].isRating ?? false,
                                  buttonWidget: state.newOrder?[index].isRating ==
                                          false
                                      ? const SizedBox.shrink()
                                      : CompletedServiceWidget(
                                          image: state.newOrder?[index]
                                                  .customerRatingObj?.image ??
                                              '',
                                          name:
                                              "${state.newOrder?[index].customerRatingObj?.customerName}",
                                          date:
                                              " ${state.newOrder?[index].completedDate}",
                                          rating:
                                              "${state.newOrder?[index].customerRatingObj?.rating}",
                                          review:
                                              "${state.newOrder?[index].customerRatingObj?.review}"),
                                  orderOnTapFun: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              OrderDetailsScreen(
                                                  orderStatus: "completed",
                                                  orderId: state
                                                          .newOrder?[index]
                                                          .id ??
                                                      ''),
                                        ));
                                  }),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      String type,
      ) async {
    final now = DateTime.now();
    final nextMonth = DateTime(now.year, now.month + 1, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2024),
      lastDate: nextMonth,
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        controller.text = formattedDate;

        if (type == "from") {
          tocontroller.clear();
        }
      });

      if (type == "to") {
        context.read<NewOrdersCubit>().fetchNewOrders(
          type: "completed",
          fromdate: fromcontroller.text, // now correctly taken from fromController
          todate: tocontroller.text,
        );
      }
    }
  }


}
