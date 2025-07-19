import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_images.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/payout_history/cubit/payout_history_cubit.dart';

import '../../../../../comman/shimmers/shimmer_widget.dart';
import '../../../../commons/color_codes.dart';
import '../../../completed_orders/widget/completed_orders_widget.dart';
import '../widget/payment_history_widget.dart';
import 'payouts_details_screen.dart';

class PayoutHistoryScreen extends StatefulWidget {
  const PayoutHistoryScreen({super.key});

  @override
  State<PayoutHistoryScreen> createState() => _PayoutHistoryScreenState();
}

class _PayoutHistoryScreenState extends State<PayoutHistoryScreen> {
  DateTimeRange? _selectedDateRange;

  String dropdownValue = 'Pending';
  DateTimeRange? result;
  var formatter1 = new DateFormat('yyyy-MM-dd');
  var formatter = new DateFormat('dd-MM-yyyy');
  final serviceListScrollController = ScrollController();
  DateTime? previousEventTime;
  double previousScrollOffset = 0;

  // This function will be triggered when the floating button is pressed

  // if (result != null) {
  //   // Rebuild the UI
  //   print(result!.start.toString());
  //   print(result!.end.toString());
  //   var formatter = new DateFormat('dd-MM-yyyy');

  //   setState(() {
  //     startDate = formatter.format(result!.start);
  //     endDate = formatter.format(result!.end);
  //     _selectedDateRange = result;
  //   });

  //   print("_selectedDateRange : $_selectedDateRange");
  // }

  String? fromformattedDate;
  String? toformattedDate;

  @override
  void initState() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    // formattedDate = formatter.format(now);
    // print(formattedDate);
    fromformattedDate = formatter1.format(now);
    toformattedDate = formatter1.format(now);
    context.read<PayoutHistoryCubit>().initStatefun(now);
    context.read<PayoutHistoryCubit>().changeDropdownValue(dropdownValue);
    context.read<PayoutHistoryCubit>().fetchAllOrderList(
          fromdate: fromformattedDate!,
          status: "Pending",
          todate: toformattedDate!,
        );
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("heree");
      serviceListScrollController.addListener(() {
        serviceListScrollController.position.isScrollingNotifier
            .addListener(() {
          if (serviceListScrollController.position.maxScrollExtent ==
              serviceListScrollController.offset) {
            context.read<PayoutHistoryCubit>().fetchAllOrderList(
                loadMoreData: true,
                fromdate: fromformattedDate!,
                status: dropdownValue,
                todate: toformattedDate!);
          }
          //Find the scrolling speed
          final currentScrollOffset =
              serviceListScrollController.position.pixels;
          final currentTime = DateTime.now();
          previousEventTime = currentTime;
          previousScrollOffset = currentScrollOffset;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    serviceListScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "Payout History",
          bottomWidget: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Column(
                children: [
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<PayoutHistoryCubit, PayoutHistoryState>(
                      listener: (context, state) {
                        if (state.dateFetched == true) {
                          context.read<PayoutHistoryCubit>().fetchAllOrderList(
                                fromdate: state.dateRange == null
                                    ? ""
                                    : "${formatter1.format(state.dateRange!.start)}",
                                status:
                                    state.value == "All" ? "all" : state.value,
                                todate: state.dateRange == null
                                    ? ""
                                    : "${formatter1.format(state.dateRange!.end)}",
                              );
                        } else if (state.isNewValueSelected == true) {
                          dropdownValue = state.value;
                          print("entered>>>>>>>>>>>> ${state.value}");
                          context.read<PayoutHistoryCubit>().fetchAllOrderList(
                                fromdate: state.dateRange == null
                                    ? ""
                                    : "${formatter1.format(state.dateRange!.start)}",
                                status: state.value,
                                todate: state.dateRange == null
                                    ? ""
                                    : "${formatter1.format(state.dateRange!.end)}",
                              );
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        dropdownValue = state.value;
                        return Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Date Range',
                                  style: TextStyle(
                                    color: Color(0xFF3A3A3A),
                                    fontSize: 12,
                                    fontFamily: AppthemeColor().themeFont,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                7.ph,
                                InkWell(
                                  onTap: () async {
                                    context
                                        .read<PayoutHistoryCubit>()
                                        .dateRangePicker(context);
                                  },
                                  child: Container(
                                    height: 43,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xFFC1C1C1))),
                                    child: state.dateRange != null
                                        ? Center(
                                            child: Text(
                                            "${formatter.format(state.dateRange!.start)} - ${formatter.format(state.dateRange!.end)}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily:
                                                  AppthemeColor().themeFont,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ))
                                        : Center(
                                            child: Text(
                                            "${fromformattedDate} - ${toformattedDate}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily:
                                                  AppthemeColor().themeFont,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                  ),
                                )
                              ],
                            )),
                            10.pw,
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Type',
                                  style: TextStyle(
                                    color: Color(0xFF3A3A3A),
                                    fontSize: 12,
                                    fontFamily: AppthemeColor().themeFont,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                7.ph,
                                SizedBox(
                                  height: 43,
                                  child: DropdownButtonFormField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: AppthemeColor().themeFont,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    // hint: Text("data"),
                                    decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          //<-- SEE HERE
                                          borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          //<-- SEE HERE
                                          borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            EdgeInsets.only(left: 15)),
                                    dropdownColor: Colors.white,
                                    value: state.value,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    onChanged: (String? newValue) async {
                                      context
                                          .read<PayoutHistoryCubit>()
                                          .changeDropdownValue(newValue!);
                                    },
                                    items: <String>[
                                      "Pending",
                                      'Completed',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            )),
                          ],
                        );
                      },
                    ),
                  ),
                  5.ph,
                ],
              ))),
      body: Column(
        children: [
          BlocConsumer<PayoutHistoryCubit, PayoutHistoryState>(
              listener: (context, orderstate) {
            // TODO: implement listener
          }, builder: (context, orderstate) {
            if (orderstate.error != null) {
              return Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CommonImages().noPayoutsImage,
                      15.ph,
                      CommonProximaNovaTextWidget(
                        text: "No Payouts done yet!",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else if (orderstate.dataLoading ||
                orderstate.loadMoreOrderList == null) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: serviceListScrollController,
                    shrinkWrap: true,
                    itemCount: 8, // Replace with your actual data
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: buildSimmer1(
                          height: 80,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              final myOrders = orderstate.loadMoreOrderList!;
              print("<<<<<<<<<<<<${myOrders.results.length}");
              return myOrders.results.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CommonImages().noPayoutsImage,
                            15.ph,
                            CommonProximaNovaTextWidget(
                              text: "No Payouts done yet!",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: orderstate.dataLoading
                              ? null
                              : serviceListScrollController,
                          shrinkWrap: true,
                          itemCount: myOrders.results.length +
                              (myOrders.paginationTestModel.isLastPage ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (index < myOrders.results.length) {
                              return PaymentHistoryWidget(
                                  onTapFun: () {
                                    if (dropdownValue == "Completed") {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                PayoutDetailsScreen(
                                                    orderId: myOrders
                                                        .results[index].id),
                                          ));
                                    }
                                    ;
                                  },
                                  payoutData: myOrders.results[index]);
                            } else if (myOrders
                                .paginationTestModel.isLastPage) {
                              return const SizedBox.shrink();
                            }
                            // else {
                            //   return const ThemeSpinner();
                            // }
                          }),
                    );
            }
          })
        ],
      ),
    );
  }

  _selectDate(
      BuildContext context, TextEditingController fromcontroller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3100),
    );

    if (pickedDate != null) {
      // Do something with the picked date
      // myState(() {
      //   final formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      //   fromcontroller.text = formattedDate.toString();
      //   print('Selected date: ${fromcontroller.text}');
      // });
      setState(() {
        final formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
        fromcontroller.text = formattedDate.toString();
        print('Selected date: ${fromcontroller.text}');
      });
    }
  }
}

//   TextEditingController fromcontroller = TextEditingController();
//   TextEditingController tocontroller = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     context
//         .read<PayoutHistoryCubit>()
//         .fetchPayoutList(fromcontroller.text, tocontroller.text);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: commonAppBarWidget(
//           leadingArrowOnTap: () {
//             Navigator.pop(context);
//           },
//           title: "Payout History"),
//       body: Column(
//         children: [
//           10.ph,
//           DateFiltersWidget(
//             fromcontroller: fromcontroller,
//             tocontroller: tocontroller,
//             fromDateOnTap: () {
//               selectDate(context, fromcontroller);
//             },
//             toDateOnTap: () {
//               selectToDate(context, tocontroller);
//             },
//           ),
//           5.ph,
//           BlocBuilder<PayoutHistoryCubit, PayoutHistoryState>(
//             builder: (context, payoutState) {
//               if (payoutState.dataLoaded == true) {
//                 return Expanded(child: Center(child: ThemeSpinner()));
//               } else if (payoutState.payoutError.isNotEmpty) {
//                 return Center(
//                   child: Text(payoutState.payoutError.toString()),
//                 );
//               } else {
//                 return Expanded(
//                     child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: payoutState.payoutList!.data.length,
//                   itemBuilder: (context, index) => PaymentHistoryWidget(
//                       payoutData: payoutState.payoutList!.data[index]),
//                 ));
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }

//   selectDate(BuildContext context, TextEditingController fromcontroller) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2024),
//       lastDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//         fromcontroller.text = formattedDate.toString();
//         tocontroller.text = "";
//         print('Selected date: ${fromcontroller.text}');
//         // context
//         //     .read<PayoutHistoryCubit>()
//         //     .fetchPayoutList(fromcontroller.text, tocontroller.text);
//       });
//     }
//   }

//   selectToDate(BuildContext context, TextEditingController tocontroller) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2024),
//       lastDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//         tocontroller.text = formattedDate.toString();
//         print('Selected date: ${tocontroller.text}');
//         context
//             .read<PayoutHistoryCubit>()
//             .fetchPayoutList(fromcontroller.text, tocontroller.text,);
//       });
//     }
//   }
// }
