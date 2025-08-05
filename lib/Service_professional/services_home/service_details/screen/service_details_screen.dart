import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/services_home/service_details/model/service_details_model.dart';

import '../../../../comman/Api/Base-Api.dart';
import '../../../../comman/Api/end_points.dart';
import '../../../../comman/env.dart';
import '../../../../utility/auth_shared_pref.dart';
import '../../../../utility/themeToast.dart';
import '../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../../commons/common_button_widget.dart';
import '../../../commons/common_textformfield.dart';
import '../../../services_bottombar/logic/orderscountcubit/orders_count_cubit.dart';
import '../../../services_bottombar/screen/services_bottombar_screen.dart';
import '../../../services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import '../../new_orders/logic/cubit/new_orders_cubit.dart';
import '../../new_orders/widget/new_order_widget.dart';
import '../logic/cubit/service_details_cubit.dart';
import '../logic/service_cart_cubit/service_cart_cubit.dart';
import '../widget/service_details_widget.dart';
// import 'package:swipe_button_widget/swipe_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/success_sheet_widget.dart';
import 'create_qoute_screen.dart';
import 'review_quote_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderStatus, orderId;
  const OrderDetailsScreen(
      {super.key, required this.orderStatus, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isreached = false;
  bool isStarted = false;
  final _key = GlobalKey<FormState>();
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    print("service status: ${widget.orderStatus}");
    context
        .read<ServiceDetailsCubit>()
        .fetchServiceDetails(orderId: widget.orderId);

    // servicecubit.fetchServiceDetails(orderId: "41");
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
    super.initState();
  }

  @override
  void dispose() {
    _controllers.clear();
    // password.clear();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _submitOtp();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _controllers.length - 1) {
        _focusNodes[index].unfocus();
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _submitOtp();
      }
    } else {
      if (index > 0) {
        _focusNodes[index].unfocus();
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  String otp = "";
  String _submitOtp() {
    otp = _controllers.fold('', (otp, controller) => otp + controller.text);
    return otp;
  }

  final valueListenable = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceDetailsCubit, ServiceDetailsState>(
      listener: (context, state) {
        print(
            "state emiited******${state.isStatusLoading} ${state.completeSuccesss}");
        if (state.reachedSuccesss != null && state.reachedSuccesss != "") {
          context.read<OrdersCountCubit>().getOrdersCount();
          context.read<NewOrdersCubit>().fetchNewOrders(type: "accepted");
          Navigator.pop(context);
          // bottomSheet();
        } else if (state.completeSuccesss != null &&
            state.completeSuccesss != "") {
          context.read<OrdersCountCubit>().getOrdersCount();
          context.read<NewOrdersCubit>().fetchNewOrders(type: "ongoing");
          Navigator.pop(context);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        print("widget.orderStatus : ${widget.orderStatus}");
        if (state.isLoading == true) {
          return Scaffold(
              appBar: commonAppBarWidget(
                  leadingArrowOnTap: () {
                    Navigator.pop(context);
                  },
                  title: "Service Details"),
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        const OrdersLoadingWidget()),
              ));
        }
        final serviceDetails = state.serviceDetails;
        if (serviceDetails != null) {
          String buttonName = 'Mark As Completed?';
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: commonAppBarWidget(
                leadingArrowOnTap: () {
                  Navigator.pop(context);
                },
                title: "Service Details"),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // 5.ph,
                if (widget.orderStatus == "new")
                  BlocConsumer<NewOrdersCubit, NewOrdersState>(
                    listener: (context, newstate) {
                      // print('success triggered ****${newstate.newOrder}');
                      if (newstate.acceptOrderSuccess != null) {
                        context.read<OrdersCountCubit>().getOrdersCount();
                        context
                            .read<NewOrdersCubit>()
                            .fetchNewOrders(type: "new");
                      } else if (newstate.rejectOrderSuccess != null) {
                        print('success triggered');
                        context.read<OrdersCountCubit>().getOrdersCount();
                        context
                            .read<NewOrdersCubit>()
                            .fetchNewOrders(type: "new");
                      } else if (newstate.newOrder == null) {
                        Navigator.maybePop(context);
                      } else if (newstate.newOrder!.isNotEmpty) {
                        Navigator.maybePop(context);
                      }
                      // TODO: implement listener
                    },
                    builder: (context, newstate) {
                      if (newstate.isLoading == true ||
                          state.isLoading == true) {
                        return const Center(
                          child: ThemeSpinner(),
                        );
                      }
                      return NewOrderButtonsWidget(
                          buttonHeight: 40,
                          acceptOnTap: () {
                            context
                                .read<NewOrdersCubit>()
                                .acceptOrder(orderId: serviceDetails.orderId);
                          },
                          rejectOnTap: () {
                            context
                                .read<NewOrdersCubit>()
                                .rejectOrder(orderId: serviceDetails.orderId);
                          });
                    },
                  ),
                if (widget.orderStatus == "accepted")
                  SwipeButtons(
                    isLoading:
                        (state.isStatusLoading && state.reachedFailed == null),
                    onButtonDragged: () {
                      context
                          .read<ServiceDetailsCubit>()
                          .reachedLocation(orderId: serviceDetails.orderId);
                    },
                    buttontitle: "REACHED LOCATION",
                  ),
                if (widget.orderStatus == "START SERVICE")
                  SwipeButtons(
                    isLoading: state.isStatusLoading == true ? true : false,
                    // isLoading: state.isStatusLoading!,
                    onButtonDragged: () {
                      bottomSheet(context.read<ServiceDetailsCubit>());
                    },
                    buttontitle: "START SERVICE",
                  ),

                if (widget.orderStatus == "START SERVICE" &&
                    serviceDetails.is_amc_subscription == 'yes' &&
                    serviceDetails.visitAndQuote.isEmpty)
                  TextButton(
                      onPressed: () {
                        String? serviceId;
                        for (var item in serviceDetails.serviceItems) {
                          if (item.hasVisitAndQuote == "yes") {
                            serviceId = item.id;
                          }
                        }
                        serviceDetails.serviceItems.first.id;

                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CreateQuoteScreen(
                                serviceItems: [],
                                orderId: widget.orderId,
                                paymentMode: state.serviceDetails?.paymentMode ?? "",
                                serviceId: serviceId ??
                                    serviceDetails.serviceItems.first.id,
                                totalamount: '',
                              ),
                            ));
                      },
                      child: const CommonProximaNovaTextWidget(
                        text: 'Create Quote',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      )),
                if (widget.orderStatus == "REVIEW QUOTE")
                  Column(
                    children: [
                      SwipeButtons(
                        isLoading: state.isStatusLoading == true ? true : false,
                        onButtonDragged: () {
                          String? serviceId;
                          for (var item in serviceDetails.serviceItems) {
                            if (item.hasVisitAndQuote == "yes") {
                              serviceId = item.id;
                            }
                          }

                          List<jsonModel> serviceList = [];
                          for (var element in serviceDetails.visitAndQuote) {
                            serviceList.add(jsonModel(
                              serviceName: element.serviceName,
                              amount: element.price,
                              serialNumber: element.serialNumber,
                              warrantyDays: element.warrantyDays,
                            ));
                          }

                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ReviewQuoteScreen(
                                  type: "details",
                                  total: serviceDetails.visitAndQuotePrice,
                                  orderId: serviceDetails.id,
                                  serviceId: serviceId ?? "", paymentMode:  state.serviceDetails?.paymentMode ?? "",
                                ),
                              ));
                          // bottomSheet();
                        },
                        buttontitle: "REVIEW QUOTE",
                      ),
                      TextButton(
                          onPressed: () {
                            completeServiceBottomSheet(
                                servicecubit:
                                    context.read<ServiceDetailsCubit>(),
                                success: () {
                                  print('⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙2');
                                  successSheet(context,() {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) => const ServicesBottomBarScreen(initialIndex: 1),
                                      ),
                                          (route) => false,
                                    );
                                  },);
                                },
                                gcontext: context, paymentMode: state.serviceDetails?.paymentMode ?? "");
                          },
                          child: CommonProximaNovaTextWidget(
                            text: buttonName,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ))
                    ],
                  ),
                if (widget.orderStatus == "CREATE QUOTE")
                  Column(
                    children: [
                      SwipeButtons(
                        isLoading: state.isStatusLoading,
                        onButtonDragged: () {
                          String? serviceId;
                          for (var item in serviceDetails.serviceItems) {
                            if (item.hasVisitAndQuote == "yes") {
                              serviceId = item.id;
                            }
                          }
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CreateQuoteScreen(
                                  orderId: serviceDetails.id,
                                  serviceId: serviceId ?? "",
                                  serviceItems: [],
                                  totalamount: "", paymentMode: state.serviceDetails?.paymentMode ?? "",
                                ),
                              ));
                          // bottomSheet();
                        },
                        buttontitle: "CREATE QUOTE",
                      ),
                      TextButton(
                          onPressed: () {


                            completeServiceBottomSheet(
                                servicecubit:
                                    context.read<ServiceDetailsCubit>(),
                                success: () {

                                  print('⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙⋙3');
                                  successSheet(context,() {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) => const ServicesBottomBarScreen(initialIndex: 1),
                                      ),
                                          (route) => false,
                                    );
                                  },);
                                },
                                gcontext: context, paymentMode: '');
                          },
                          child: CommonProximaNovaTextWidget(
                            text: buttonName,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ))
                    ],
                  ),

                if (widget.orderStatus == "COMPLETE")
                  SwipeButtons(
                    isLoading: state.isStatusLoading,
                    onButtonDragged: () {
                      completeService(

                        context.read<ServiceDetailsCubit>(),
                        isRecivedPayment:
                            serviceDetails.is_pay_after_service == 'yes',
                        orderId: state.serviceDetails?.orderId ?? "",
                        visitAndQuotePrice: state.serviceDetails?.isQuote ?? "",
                        paymentMode: state.serviceDetails?.paymentMode ?? "",
                      );
                    },
                    buttontitle: "COMPLETE SERVICE",
                  ),
                if (serviceDetails.isQuote == '1' &&
                    (state.serviceDetails?.paymentType ?? "") == 'Pending' &&
                    (state.serviceDetails?.is_pay_after_service ?? "") ==
                        'yes' &&
                    (widget.orderStatus.toLowerCase() ?? "") == 'completed')
                  SwipeButtons(
                    isLoading: state.isStatusLoading,
                    onButtonDragged: () {
                      recivedPayment(
                        orderId: state.serviceDetails?.orderId ?? "",
                        showDropDown: true,
                        context: context,
                      );
                    },
                    fontSize: 10,
                    buttontitle: "RECEIVED PAYMENT MARK AS COMPLETE",
                  ),
                if (widget.orderStatus == "COMPLETE")
                  const SizedBox(
                    height: 10,
                  ),
                if (widget.orderStatus == "COMPLETE" &&
                    (serviceDetails.is_rescheduled ?? "") != 'yes')
                  ValueListenableBuilder(
                    valueListenable: valueListenable,
                    builder: (context, value, child) => Visibility(
                      visible: valueListenable.value,
                      child: InkWell(
                        onTap: () {
                          selectTimingsBottomSheet(context,
                              orderId: serviceDetails.id ?? '', success: () {
                            valueListenable.value = false;
                          });
                        },
                        child: const Text(
                          'Reschedule the Service',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                // if (widget.orderStatus == "completed")
                //   CompleteOrderEarningsWidget(
                //     price: serviceDetails.earnings,
                //     // ((double.tryParse(state.serviceDetails!.subTotal) ??
                //     //             0) +(double.tryParse(state.serviceDetails!.tip) ??
                //     //             0)+
                //     //         double.parse(
                //     //             state.serviceDetails!.visitAndQuotePrice))
                //     //     .toString()),
                //   ),
                10.ph,
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ServiceDetailsFullDetailsWidget(
                    is_quote: serviceDetails.isQuote,
                    sub_total: serviceDetails.sub_total ??"",
                    taxPercentage: serviceDetails.taxPercentage ??"",
                    payment_mode: serviceDetails.paymentMode ??"",
                    grand_total: serviceDetails.grandTotal ??"",
                    wallet_part_payment: serviceDetails.wallet_part_payment ??'',
                    billDetails:serviceDetails.billDetails,
                    couponCode: serviceDetails.couponcode,
                    tipAmount: serviceDetails.tip,
                    visitnquotetotal: serviceDetails.visitAndQuotePrice,
                    lat: serviceDetails.custLatitude,
                    long: serviceDetails.custLongitude,
                    vistAndQuoteList: serviceDetails.visitAndQuote,
                    taxesList: serviceDetails.taxes,
                    orderStatus: widget.orderStatus,
                    couponAmount: serviceDetails.couponDiscount,
                    platFormFee: serviceDetails.subTotal,
                    totalAmount: serviceDetails.grandTotal,
                    orderId: serviceDetails.sessionId,
                    serviceBookedOn:
                        "${serviceDetails.serviceDate} at ${serviceDetails.serviceTime}",
                    statusTime: widget.orderStatus == "REVIEW QUOTE"
                        ? "${serviceDetails.quotationDate}"
                        : (serviceDetails.visitAndQuote.isNotEmpty &&
                                widget.orderStatus == "START SERVICE")
                            ? "${serviceDetails.quotationDate}"
                            : "${serviceDetails.completedDate}",
                    customerName: serviceDetails.customerName,
                    customerContact: serviceDetails.customerMobile,
                    customerAddress: serviceDetails.customerAddress,
                    serviceBookingList: serviceDetails.serviceItems,
                    deviceBrand: serviceDetails.device_brand ?? "",
                    modelName: serviceDetails.model_name ?? '',
                    serialNno: serviceDetails.serial_number ?? '',
                    is_vendor_update_device_details:
                        serviceDetails.is_vendor_update_device_details ?? '',
                    device_id: serviceDetails.id ?? '',
                    device_model_name: serviceDetails.device_model_name ?? '',
                    device: serviceDetails.device_type ?? '',
                    is_amc_subscription:
                        serviceDetails.is_amc_subscription ?? '',
                    complaintText: serviceDetails.complaint ?? '',
                    service_name: serviceDetails.service_name ?? '',
                    status: serviceDetails.status ?? '',
                  ),
                  5.ph,
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar:
              commonAppBarWidget(leadingArrowOnTap: () {}, title: "Order view"),
        );
      },
    );
  }

  bottomSheet(ServiceDetailsCubit servicecubit) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: StatefulBuilder(builder: ((context, setState) {
                return BlocConsumer<ServiceDetailsCubit, ServiceDetailsState>(
                  listener: (context, newstate) {
                    if (newstate.pinVerified != null) {
                      context.read<OrdersCountCubit>().getOrdersCount();
                      context
                          .read<NewOrdersCubit>()
                          .fetchNewOrders(type: "ongoing");
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  bloc: servicecubit,
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                            ),
                            child: CommonProximaNovaTextWidget(
                              text: "Enter PIN to Start Service",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        10.ph,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CustomPaint(
                            painter: DottedLinePainter(),
                            child: const SizedBox(
                              width: double.infinity,
                              height: 1.0,
                            ),
                          ),
                        ),
                        5.ph,
                        const CommonProximaNovaTextWidget(
                          text: "Enter 4 Digit PIN",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3A3A3A),
                        ),
                        15.ph,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              4,
                              (index) => SizedBox(
                                width: 48,
                                height: 74,
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(
                                        '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                                  ],
                                  controller: _controllers[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                  focusNode: _focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  obscureText: false,
                                  onChanged: (value) =>
                                      _onOtpChanged(value, index),
                                  decoration: InputDecoration(
                                    counterStyle:
                                        const TextStyle(color: Colors.red),
                                    counterText: '',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 22),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    // if (value == null || value.isEmpty) {
                                    //   return 'Please enter mobile number';
                                    // } else if (value.length < 4) {
                                    //   return 'Please enter valid mobile number';
                                    // }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        15.ph,
                        SwipeButtons(
                          isLoading:
                              (state.isStatusLoading && state.pinError == null),
                          onButtonDragged: () {
                            servicecubit.validatePin(
                                orderId: state.serviceDetails!.orderId,
                                pin: otp);
                            // Navigator.pop(context);
                            // Navigator.pop(context);
                          },
                          buttontitle: "START NOW",
                        ),
                        10.ph,
                      ],
                    );
                  },
                );
              }))),
        );
      },
    );
  }

  completeService(ServiceDetailsCubit servicecubit,
      {bool isRecivedPayment = false,
      required String orderId,
      required String visitAndQuotePrice,
      required String paymentMode}) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: StatefulBuilder(builder: ((context, setState) {
                return BlocConsumer<ServiceDetailsCubit, ServiceDetailsState>(
                  listener: (context, newstate) {
                    if (newstate.reachedSuccesss == 'success') {
                      if (isRecivedPayment) {
                        recivedPayment(
                          orderId: orderId,
                          context: context,
                        );
                      } else if (paymentMode == 'COD' &&
                          visitAndQuotePrice == '0' &&
                          newstate.reachedSuccesss == 'success') {
                        recivedPayment(
                          orderId: orderId,
                          showDropDown: false,
                          context: context,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const ServicesBottomBarScreen(
                                    initialIndex: 1,
                                  )),
                          (route) => false,
                        );
                      }
                    }
                  },
                  bloc: servicecubit,
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                            ),
                            child: CommonProximaNovaTextWidget(
                              text: "Enter PIN to Complete Service",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        10.ph,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CustomPaint(
                            painter: DottedLinePainter(),
                            child: const SizedBox(
                              width: double.infinity,
                              height: 1.0,
                            ),
                          ),
                        ),
                        5.ph,
                        const CommonProximaNovaTextWidget(
                          text: "Enter 4 Digit PIN",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3A3A3A),
                        ),
                        15.ph,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              4,
                              (index) => SizedBox(
                                width: 48,
                                height: 74,
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(
                                        '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                                  ],
                                  controller: _controllers[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                  focusNode: _focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  obscureText: false,
                                  onChanged: (value) =>
                                      _onOtpChanged(value, index),
                                  decoration: InputDecoration(
                                    counterStyle:
                                        const TextStyle(color: Colors.red),
                                    counterText: '',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 22),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    // if (value == null || value.isEmpty) {
                                    //   return 'Please enter mobile number';
                                    // } else if (value.length < 4) {
                                    //   return 'Please enter valid mobile number';
                                    // }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        15.ph,
                        SwipeButtons(
                          isLoading: (state.isStatusLoading),
                          onButtonDragged: () {
                            String otp = "";
                            String submitOtp() {
                              otp = _controllers.fold('',
                                  (otp, controller) => otp + controller.text);
                              return otp;
                            }

                            context.read<ServiceDetailsCubit>().completeOrder(
                                  reason: "",
                                  orderId: servicecubit
                                          .state.serviceDetails?.orderId ??
                                      "",
                                  otp: submitOtp(),
                                  context: context,
                                  success: () {
                                    if(paymentMode =='COD') {
                                      recivedPayment(
                                        orderId:
                                        state.serviceDetails?.orderId ?? "",
                                        context: context,
                                        showDropDown: false,
                                      );
                                    }
                                  },
                                );
                          },
                          buttontitle: "Complete NOW",
                        ),
                        10.ph,
                      ],
                    );
                  },
                );
              }))),
        );
      },
    );
  }

    recivedPayment({
    required String orderId,
    bool showDropDown = true,
    required BuildContext context,
  }) {
    final repo = OrderPaymentRepository();
    String? _selected;
    print('=!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      // isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: StatefulBuilder(builder: ((context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    SvgPicture.string(
                      pinToStart,
                      height: 107,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: CommonProximaNovaTextWidget(
                          text:
                              "Tell to Customer to complete the Payment so that Service will be Mark as Completed",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                          textAlign: TextAlign.center),
                    ),
                    15.ph,
                    if (showDropDown)
                      IntrinsicWidth(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            border: OutlineInputBorder(),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              value: _selected,
                              hint: Text("Pay via"),
                              items: const [
                                DropdownMenuItem(
                                    value: "cash", child: Text("Cash")),
                                DropdownMenuItem(
                                    value: "online", child: Text("Online")),
                              ],
                              onChanged: (val) {
                                setState(() => _selected = val);
                              },
                            ),
                          ),
                        ),
                      ),
                    15.ph,
                    ValueListenableBuilder(
                      builder: (context, value, child) => value
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : SwipeButtons(
                              onButtonDragged: () async {
                                if (!showDropDown) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const ServicesBottomBarScreen(
                                              initialIndex: 1),
                                    ),
                                    (route) => false,
                                  );
                                }
                                if (_selected == null) {
                                  Fluttertoast.showToast(
                                      msg: 'Please Select Payment Method');
                                  return;
                                }
                                bool result =
                                    await repo.completePayAfterService(
                                  context: context,
                                  accessToken: (Constants.prefs?.getString(
                                              "provider_access_token") ??
                                          '')
                                      .trim(),
                                  orderId: orderId.trim(),
                                  paymentType: _selected ?? '',
                                );

                                if (result) {
                                  print(
                                      "Payment successfully marked as complete.");
                                } else {
                                  print("Payment marking failed.");
                                }
                                // Navigator.pop(context);
                                // Navigator.pop(context);
                              },
                              buttontitle: "RECIVED PAYMENT & MARK COMPLETE",
                              fontSize: 10,
                            ),
                      valueListenable: repo.markCompleteNotifier,
                    ),
                    10.ph,
                  ],
                );
              }))),
        );
      },
    );
  }

  static completeServiceBottomSheet(
      {required ServiceDetailsCubit servicecubit,
        required String paymentMode,
        required Function() success,
      required BuildContext gcontext}) {
    List<String> options = [
      'Client changes Mind No Service Required',
      'Expecting Low Cost',
      'He got Better offer ',
      "No Reason Given"
    ];
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isScrollControlled: false,
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            borderSide: BorderSide.none),
        context: gcontext,
        builder: (context) {
          return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
            bloc: servicecubit,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, bottom: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xffF1F0F5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: CommonProximaNovaTextWidget(
                              text: "Reasons ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          CustomPaint(
                            painter: DottedLinePainter(),
                            child: const SizedBox(
                              width: double.infinity,
                              height: 1.5,
                            ),
                          ),
                          Column(
                            children: options.map((option) {
                              return SizedBox(
                                height: 40,
                                child: ListTile(
                                  contentPadding: EdgeInsets
                                      .zero, // Remove default ListTile padding
                                  title: Row(
                                    children: [
                                      Radio(
                                        activeColor: AppthemeColor().themecolor,
                                        value: option,
                                        groupValue: state.selectedOption,
                                        onChanged: (value) {
                                          servicecubit.updateSelectedOption(
                                              value as String);
                                        },
                                      ),
                                      const SizedBox(
                                          width:
                                              2), // Adjust the width between the radio button and the title
                                      Text(option),
                                    ],
                                  ),
                                  onTap: () {
                                    servicecubit.updateSelectedOption(option);
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: CommonButtonWidget(
                              buttontitle: "SUBMIT",
                              titlecolor: AppthemeColor().whiteColor,
                              buttonColor: AppthemeColor().themecolor,
                              boardercolor: AppthemeColor().themecolor,
                              buttonOnTap: ()  {

                                 servicecubit.completeOrder(
                                  reason: state.selectedOption!,
                                  orderId: state.serviceDetails!.orderId,
                                  otp: '',
                                  context: context,
                                  success: ()   {
                                    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                                    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                                    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                                    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                                    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                                    print('${state.serviceDetails?.paymentMode ?? ""}');
        if( (state.serviceDetails?.paymentMode ?? "").toLowerCase() == 'cod') {
          success.call();

          print('___________________________________');
          // Navigator.pop(context);


        }else{
          Navigator.pop(context);
        }

                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              );
            },
          );
        });
  }
}

typedef BookCallCallback = Function(String temSelectedTime,
    String complaintHere, String selectDate, String addressId);

selectTimingsBottomSheet(BuildContext context,
    {bool isBookVisit = false,
    Function? success,
    String? addressId,
    required String orderId,
    bool isAMCTimeSlot = false}) {
  TextEditingController remarkController = TextEditingController();

  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // enableDrag: true,
      isScrollControlled: true,
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          borderSide: BorderSide.none),
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => ServiceCartCubit()
            ..fetchDateList()
            ..clean(),
          child: BlocBuilder<ServiceCartCubit, ServiceCartState>(
              builder: (context, addressState) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, bottom: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            10.ph,
                            const CommonProximaNovaTextWidget(
                              text: "Reschedule Details",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            10.ph,
                            // 🔻 Date Dropdown
                            if (addressState.dateList != null &&
                                addressState.dateList!.data.isNotEmpty)
                              DropdownButtonFormField<ServiceDate>(
                                value: addressState.selectedDate,
                                decoration: InputDecoration(
                                  labelText: 'Select Date',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Color(0xFFC1C1C1),
                                      )),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.red,
                                      )),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Color(0xFFC1C1C1),
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Color(0xFFC1C1C1),
                                      )),
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: addressState.dateList!.data.map((date) {
                                  return DropdownMenuItem(
                                    value: date,
                                    child: Text("${date.day}, ${date.month}"),
                                  );
                                }).toList(),
                                onChanged: (selectedDate) {
                                  if (selectedDate != null) {
                                    context
                                        .read<ServiceCartCubit>()
                                        .setSelectedDate(
                                          selectedDate,
                                          isAMCTimeSlot: isAMCTimeSlot,
                                        );
                                  }
                                },
                              )
                            else
                              const Text("No available dates."),

                            const SizedBox(height: 15),

                            // 🔻 Time Slot Dropdown
                            if (!(addressState.timeLoader == true))
                              addressState.timeList?.data.isNotEmpty == true
                                  ? DropdownButtonFormField<String>(
                                      value: addressState.temSelectedTime != ''
                                          ? addressState.temSelectedTime
                                          : null,
                                      decoration: InputDecoration(
                                        labelText: 'Select Time Slot',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFC1C1C1),
                                            )),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.red,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFC1C1C1),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFC1C1C1),
                                            )),
                                      ),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: addressState.timeList!.data
                                          .map((timeSlot) {
                                        return DropdownMenuItem<String>(
                                          value: timeSlot.time,
                                          child: Text(timeSlot.time),
                                        );
                                      }).toList(),
                                      onChanged: (selectedTime) {
                                        if (selectedTime != null) {
                                          context
                                              .read<ServiceCartCubit>()
                                              .setTemporaryTime(selectedTime);
                                        }
                                      },
                                    )
                                  : const Text("No time slots found")
                            else
                              const ThemeSpinner(),
                            16.ph,

                            CommonTextformfieldWidget(
                              fieldOntap: () {},
                              maxLength: 1000,
                              maxLines: 4,
                              hintText: 'Remarks',
                              keyboardType: TextInputType.name,
                              controller: remarkController,
                              formatters: [
                                // LengthLimitingTextInputFormatter(20),
                                // FilteringTextInputFormatter.allow(
                                //   RegExp(r'[A-Z][a-z]'),
                                // ),
                                // FilteringTextInputFormatter.deny(
                                //   RegExp(r'^0+'), //users can't type 0 at 1st position
                                // ),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Bank Name';
                                }
                                return null;
                              },
                            ),
                            BlocBuilder<ServiceCartCubit, ServiceCartState>(
                              builder: (context, state) {
                                return SizedBox(
                                  height: 125,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        // ✅ Image Picker 1
                                        GestureDetector(
                                          onTap: () => context
                                              .read<ServiceCartCubit>()
                                              .pickImage1FromGallery(context),
                                          child: Container(
                                            width: 160,
                                            height: 125,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFD3DBE8)),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: state.image1 == null
                                                ? _buildUploadPlaceholder()
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.file(
                                                      File(state.image1!.path),
                                                      width: 160,
                                                      height: 125,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                          ),
                                        ),

                                        16.pw,

                                        // ✅ Image Picker 2
                                        GestureDetector(
                                          onTap: () => context
                                              .read<ServiceCartCubit>()
                                              .pickImage2FromGallery(context),
                                          child: Container(
                                            width: 160,
                                            height: 125,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFD3DBE8)),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: state.image2 == null
                                                ? _buildUploadPlaceholder()
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.file(
                                                      File(state.image2!.path),
                                                      width: 160,
                                                      height: 125,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            16.ph,
                            BlocBuilder<ServiceCartCubit, ServiceCartState>(
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          AppthemeColor().appMainColor,
                                    ),
                                    onPressed: state.rescheduling
                                        ? null // ⛔ Disable button during loading
                                        : () async {
                                            if (addressState.temSelectedTime !=
                                                '') {
                                              final cubit = context
                                                  .read<ServiceCartCubit>();
                                              cubit.setSelectedTime(
                                                  addressState.temSelectedTime);

                                              await cubit
                                                  .rescheduleCurrentOrder(
                                                orderId:
                                                    orderId, // replace with actual order ID
                                                remarks: remarkController.text,
                                                success:
                                                    success, // or get from a TextField
                                              );

                                              Navigator.pop(context);
                                            } else {
                                              ThemeToast().ErrorToast(
                                                  "Please select any time slots");
                                            }
                                          },
                                    child: state.rescheduling
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const CommonProximaNovaTextWidget(
                                            text: "Reschedule the Service",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                  ),
                                );
                              },
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      });
}

Widget _buildUploadPlaceholder() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.string(uploadIcon),
      6.pw,
      const Text(
        'Upload Image',
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Gilroy-Medium',
          fontWeight: FontWeight.w400,
        ),
      )
    ],
  );
}

const uploadIcon = """
<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M0.400142 10.6268C0.621135 10.6268 0.800285 10.8059 0.800285 11.0269V15.1997H15.2059L15.2059 11.0269C15.2059 10.8059 15.3851 10.6268 15.606 10.6268C15.827 10.6268 16.0062 10.8059 16.0062 11.0269L16.0062 15.4028C16.0062 15.6593 15.8213 16 15.4427 16H0.563493C0.184931 16 0 15.6593 0 15.4028V11.0269C0 10.8059 0.17915 10.6268 0.400142 10.6268Z" fill="black"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M8.00366 0C8.22465 0 8.4038 0.17915 8.4038 0.400142V13.4353C8.4038 13.6563 8.22465 13.8354 8.00366 13.8354C7.78267 13.8354 7.60352 13.6563 7.60352 13.4353V0.400142C7.60352 0.17915 7.78267 0 8.00366 0Z" fill="black"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M8.28343 0.114183C8.44136 0.268765 8.44407 0.522106 8.28949 0.680037L4.53181 4.51915C4.37722 4.67708 4.12388 4.67979 3.96595 4.52521C3.80802 4.37063 3.8053 4.11729 3.95989 3.95936L7.71757 0.120248C7.87215 -0.0376833 8.1255 -0.0403986 8.28343 0.114183Z" fill="black"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M7.72376 0.114183C7.88169 -0.0403986 8.13504 -0.0376833 8.28962 0.120248L12.0473 3.95936C12.2019 4.11729 12.1992 4.37063 12.0412 4.52521C11.8833 4.67979 11.63 4.67708 11.4754 4.51915L7.7177 0.680037C7.56312 0.522106 7.56583 0.268765 7.72376 0.114183Z" fill="black"/>
</svg>
""";
const pinToStart = """
<svg width="107" height="107" viewBox="0 0 107 107" fill="none" xmlns="http://www.w3.org/2000/svg">
<circle cx="53.5" cy="53.5" r="53.5" fill="#DFE3FF"/>
<path d="M43.0767 48.5166H77.4074V51.5761H43.0767V48.5166Z" fill="#223DFE"/>
<path d="M77.4076 47.3566V45.275C77.4076 44.8289 77.2304 44.4011 76.915 44.0857C76.5995 43.7702 76.1717 43.593 75.7256 43.593H44.7577C44.3116 43.593 43.8838 43.7702 43.5683 44.0857C43.2529 44.4011 43.0757 44.8289 43.0757 45.275V47.3566H77.4076Z" fill="#223DFE"/>
<path d="M43.0767 52.7361V62.7248C43.0767 63.1709 43.2539 63.5988 43.5693 63.9142C43.8847 64.2296 44.3126 64.4068 44.7587 64.4068H75.7307C76.1768 64.4068 76.6046 64.2296 76.92 63.9142C77.2355 63.5988 77.4127 63.1709 77.4127 62.7248V52.7361H43.0767ZM52.4576 60.558H45.693V56.5838H52.4576V60.558ZM60.4459 59.1509H56.2264C56.0726 59.1509 55.9251 59.0898 55.8163 58.981C55.7075 58.8722 55.6464 58.7247 55.6464 58.5709C55.6464 58.4171 55.7075 58.2695 55.8163 58.1608C55.9251 58.052 56.0726 57.9909 56.2264 57.9909H60.4459C60.5997 57.9909 60.7473 58.052 60.856 58.1608C60.9648 58.2695 61.0259 58.4171 61.0259 58.5709C61.0259 58.7247 60.9648 58.8722 60.856 58.981C60.7473 59.0898 60.5997 59.1509 60.4459 59.1509ZM67.3288 59.1509H63.1087C62.9549 59.1509 62.8073 59.0898 62.6986 58.981C62.5898 58.8722 62.5287 58.7247 62.5287 58.5709C62.5287 58.4171 62.5898 58.2695 62.6986 58.1608C62.8073 58.052 62.9549 57.9909 63.1087 57.9909H67.3288C67.4826 57.9909 67.6301 58.052 67.7389 58.1608C67.8477 58.2695 67.9088 58.4171 67.9088 58.5709C67.9088 58.7247 67.8477 58.8722 67.7389 58.981C67.6301 59.0898 67.4826 59.1509 67.3288 59.1509ZM74.2111 59.1509H69.9916C69.8377 59.1509 69.6902 59.0898 69.5814 58.981C69.4727 58.8722 69.4116 58.7247 69.4116 58.5709C69.4116 58.4171 69.4727 58.2695 69.5814 58.1608C69.6902 58.052 69.8377 57.9909 69.9916 57.9909H74.2111C74.3649 57.9909 74.5124 58.052 74.6212 58.1608C74.73 58.2695 74.7911 58.4171 74.7911 58.5709C74.7911 58.7247 74.73 58.8722 74.6212 58.981C74.5124 59.0898 74.3649 59.1509 74.2111 59.1509Z" fill="#223DFE"/>
<path d="M53.2413 65.5658V70.9842H32.9123V37.0159H53.2413V42.4343H55.5613V36.6679V32.8683C55.5611 32.3198 55.3432 31.7938 54.9553 31.406C54.5675 31.0182 54.0415 30.8002 53.493 30.8H32.6606C32.1121 30.8002 31.5861 31.0182 31.1982 31.406C30.8104 31.7938 30.5924 32.3198 30.5923 32.8683V36.6679V71.2939V75.1347C30.5932 75.6827 30.8115 76.2079 31.1993 76.5951C31.587 76.9823 32.1126 77.1999 32.6606 77.2001H53.493C54.0415 77.1999 54.5675 76.9819 54.9553 76.5941C55.3432 76.2062 55.5611 75.6803 55.5613 75.1318V71.291V65.5658H53.2413ZM40.784 33.3283H45.3695C45.5234 33.3283 45.6709 33.3894 45.7796 33.4981C45.8884 33.6069 45.9495 33.7544 45.9495 33.9083C45.9495 34.0621 45.8884 34.2096 45.7796 34.3184C45.6709 34.4272 45.5234 34.4883 45.3695 34.4883H40.784C40.6302 34.4883 40.4827 34.4272 40.3739 34.3184C40.2652 34.2096 40.204 34.0621 40.204 33.9083C40.204 33.7544 40.2652 33.6069 40.3739 33.4981C40.4827 33.3894 40.6302 33.3283 40.784 33.3283ZM46.8224 74.6718H39.3311C39.1773 74.6718 39.0298 74.6107 38.921 74.502C38.8123 74.3932 38.7511 74.2457 38.7511 74.0918C38.7511 73.938 38.8123 73.7905 38.921 73.6817C39.0298 73.5729 39.1773 73.5118 39.3311 73.5118H46.8224C46.9763 73.5118 47.1238 73.5729 47.2325 73.6817C47.3413 73.7905 47.4024 73.938 47.4024 74.0918C47.4024 74.2457 47.3413 74.3932 47.2325 74.502C47.1238 74.6107 46.9763 74.6718 46.8224 74.6718Z" fill="#223DFE"/>
</svg>
""";

Future successSheet(BuildContext context,Function() onSwipeComplete) async{
  await Future.delayed(Durations.extralong4);
 return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (_) => SuccessSheetWidget(
      onSwipeComplete: () {
        onSwipeComplete.call();

      },
    ),
  );
}
