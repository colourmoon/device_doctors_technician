import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ex_kit/flutter_ex_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:intl/intl.dart';

import '../../../../commons/common_images.dart';
import '../../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../../../../commons/shimmer_widgets/shimmer_data.dart';
import '../../../completed_orders/widget/completed_orders_widget.dart';
import '../../../service_details/screen/service_details_screen.dart';
import '../logic/cubit/all_orders_cubit.dart';
import '../model/all_order_type.dart';
import '../widget/all_orders_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  DateTimeRange? _selectedDateRange;

  AllOrderType dropdownValue = const AllOrderType(type: 'All', title: 'All');
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
    // var now = new DateTime.now();
    // var formatter1 = new DateFormat('yyyy-MM-dd');
    // fromformattedDate = formatter1.format(now);
    // toformattedDate = formatter1.format(now);
    // context.read<AllOrdersCubit>().initStatefun(now);
    print(fromformattedDate);
    context.read<AllOrdersCubit>().clean();
    context.read<AllOrdersCubit>().changeDropdownValue(dropdownValue);
    // context.read<AllOrdersCubit>().d(dropdownValue);

    context.read<AllOrdersCubit>().fetchAllOrderList(
          fromdate: ''!,
          status: dropdownValue.type == "All" ? "all" : dropdownValue.type,
          todate: ''!,
        );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("heree");
      serviceListScrollController.addListener(() {
        serviceListScrollController.position.isScrollingNotifier
            .addListener(() {
          if (serviceListScrollController.position.maxScrollExtent ==
              serviceListScrollController.offset) {
            context.read<AllOrdersCubit>().fetchAllOrderList(
                loadMoreData: true,
                fromdate: fromformattedDate!,
                status:
                    dropdownValue.type == "All" ? "all" : dropdownValue.type,
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
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "All Orders",
          bottomWidget: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Column(
                children: [
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<AllOrdersCubit, AllOrdersState>(
                      listener: (context, state) {
                        if (state.dateFetched == true &&
                            state.dateRange != null) {
                          final String from =
                              formatter1.format(state.dateRange!.start);
                          final String to =
                              formatter1.format(state.dateRange!.end);
                          fromformattedDate = from;
                          toformattedDate = to;

                          context.read<AllOrdersCubit>().fetchAllOrderList(
                                fromdate: from,
                                status: state.allOrderType.type,
                                todate: to,
                              );
                        } else if (state.isNewValueSelected == true) {
                          // fromformattedDate =
                          //     "${formatter1.format(state.dateRange!.start)}";
                          // toformattedDate =
                          //     "${formatter1.format(state.dateRange!.end)}";

                          dropdownValue = state.allOrderType;
                          print("entered>>>>>>>>>>>> ${state.allOrderType}");
                          context.read<AllOrdersCubit>().fetchAllOrderList(
                                fromdate: state.dateRange == null
                                    ? (fromformattedDate ??
                                        "") // fallback to empty string or handle safely
                                    : formatter1.format(state.dateRange!.start),
                                todate: state.dateRange == null
                                    ? (toformattedDate ?? "") // same here
                                    : formatter1.format(state.dateRange!.end),
                                status: state.allOrderType.type,
                              );
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            Column(
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
                                        .read<AllOrdersCubit>()
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
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        state.dateRange != null &&
                                                state.dateFetched == false
                                            ? Center(
                                                child: Text(
                                                state.dateRange != null
                                                    ? "${state.dateRange!.start != null ? formatter.format(state.dateRange!.start) : ''} - "
                                                        "${state.dateRange!.end != null ? formatter.format(state.dateRange!.end) : ''}"
                                                    : "Select date range",
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
                                                (fromformattedDate != null &&
                                                        toformattedDate != null)
                                                    ? "${fromformattedDate ?? 'To'} - ${toformattedDate ?? 'From'}"
                                                    : "Select date range",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      AppthemeColor().themeFont,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        10.width,
                                        SvgPicture.string('''
                            
                            <svg width="16" height="15" viewBox="0 0 16 15" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M13.8372 1.40625H11.8057V0.46875C11.8057 0.209531 11.5961 0 11.3369 0C11.0777 0 10.8682 0.209531 10.8682 0.46875V1.40625H8.05566V0.46875C8.05566 0.209531 7.84566 0 7.58691 0C7.32816 0 7.11816 0.209531 7.11816 0.46875V1.40625H4.30566V0.46875C4.30566 0.209531 4.09566 0 3.83691 0C3.57816 0 3.36816 0.209531 3.36816 0.46875V1.40625H1.33707C0.646602 1.40625 0.0869141 1.96547 0.0869141 2.65594V13.7498C0.0869141 14.4403 0.646602 15 1.33707 15H13.8372C14.5277 15 15.0869 14.4403 15.0869 13.7498V2.65594C15.0869 1.96547 14.5277 1.40625 13.8372 1.40625ZM14.1494 13.7498C14.1494 13.9223 14.0093 14.0625 13.8372 14.0625H1.33707C1.16457 14.0625 1.02441 13.9223 1.02441 13.7498V2.65594C1.02441 2.48391 1.16457 2.34375 1.33707 2.34375H3.36816V3.28125C3.36816 3.54047 3.57816 3.75 3.83691 3.75C4.09566 3.75 4.30566 3.54047 4.30566 3.28125V2.34375H7.11816V3.28125C7.11816 3.54047 7.32816 3.75 7.58691 3.75C7.84566 3.75 8.05566 3.54047 8.05566 3.28125V2.34375H10.8682V3.28125C10.8682 3.54047 11.0777 3.75 11.3369 3.75C11.5961 3.75 11.8057 3.54047 11.8057 3.28125V2.34375H13.8372C14.0093 2.34375 14.1494 2.48391 14.1494 2.65594V13.7498Z" fill="#686868"/>
                            <path d="M5.24316 5.625H3.36816V7.03125H5.24316V5.625Z" fill="#686868"/>
                            <path d="M5.24316 7.96875H3.36816V9.375H5.24316V7.96875Z" fill="#686868"/>
                            <path d="M5.24316 10.3125H3.36816V11.7188H5.24316V10.3125Z" fill="#686868"/>
                            <path d="M8.52441 10.3125H6.64941V11.7188H8.52441V10.3125Z" fill="#686868"/>
                            <path d="M8.52441 7.96875H6.64941V9.375H8.52441V7.96875Z" fill="#686868"/>
                            <path d="M8.52441 5.625H6.64941V7.03125H8.52441V5.625Z" fill="#686868"/>
                            <path d="M11.8057 10.3125H9.93066V11.7188H11.8057V10.3125Z" fill="#686868"/>
                            <path d="M11.8057 7.96875H9.93066V9.375H11.8057V7.96875Z" fill="#686868"/>
                            <path d="M11.8057 5.625H9.93066V7.03125H11.8057V5.625Z" fill="#686868"/>
                            </svg>
                            ''')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                  child: DropdownButtonFormField<AllOrderType>(
                                    padding: EdgeInsets.all(0),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: AppthemeColor().themeFont,
                                      fontWeight: FontWeight.w600,
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
                                    value: AllOrderType.values.first,

                                    

                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    onChanged: (AllOrderType? newValue) async {
                                      context
                                          .read<AllOrdersCubit>()
                                          .changeDropdownValue(newValue!);
                                    },
                                    items: AllOrderType.values
                                        .map<DropdownMenuItem<AllOrderType>>(
                                            (AllOrderType value) {
                                      return DropdownMenuItem<AllOrderType>(
                                        value: value,
                                        child: SizedBox(
                                          width: 80,
                                          child: Text(
                                            value.title,
                                            overflow: TextOverflow.ellipsis,
                                            style:   const TextStyle(
                                              fontFamily: 'ProximaNova',
                                              fontSize: 10,

                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
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
          BlocConsumer<AllOrdersCubit, AllOrdersState>(
              listener: (context, orderstate) {},
              builder: (context, orderstate) {
                if (orderstate.dataLoading ||
                    orderstate.loadMoreOrderList == null) {
                  return const Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                } else if (orderstate.error != null &&
                    orderstate.error?.isNotEmpty == true) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: CommonProximaNovaTextWidget(
                      text: orderstate.error ?? '',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ));
                } else {
                  final myOrders = orderstate.loadMoreOrderList!;
                  print("<<<<<<<<<<<<${myOrders.results.length}");
                  return myOrders.results.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonImages().noOrdersImage,
                                5.ph,
                                const CommonProximaNovaTextWidget(
                                  text: "No Orders Found",
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
                              physics: const BouncingScrollPhysics(),
                              controller: orderstate.dataLoading
                                  ? null
                                  : serviceListScrollController,
                              shrinkWrap: true,
                              itemCount: myOrders.results.length +
                                  (myOrders.paginationTestModel.isLastPage
                                      ? 0
                                      : 1),
                              itemBuilder: (context, index) {
                                if (index < myOrders.results.length) {
                                  return AllOrdersWidget(
                                    itemcount: myOrders.results[index].id,
                                    orderId: myOrders.results[index].sessionId,
                                    orderOnTapFun: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                OrderDetailsScreen(
                                                    orderStatus: myOrders
                                                        .results[index].status,
                                                    orderId: myOrders
                                                        .results[index].id),
                                          ));
                                    },
                                  );
                                } else if (myOrders
                                    .paginationTestModel.isLastPage) {
                                  return const SizedBox.shrink();
                                } else if (orderstate.dataLoading) {
                                  return const ThemeSpinner();
                                }
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
