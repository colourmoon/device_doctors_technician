import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';

import '../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../new_orders/logic/cubit/new_orders_cubit.dart';
import '../../new_orders/widget/new_order_widget.dart';
import '../logic/cubit/service_details_cubit.dart';
import '../logic/sendqoute/cubit/send_quote_cubit.dart';
import '../model/service_details_model.dart';
import '../widget/service_details_widget.dart';
import 'create_qoute_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewQuoteScreen extends StatelessWidget {
  final String orderId, serviceId, total, type,paymentMode;

  const ReviewQuoteScreen(
      {super.key,
      required this.orderId,
      required this.serviceId,
      required this.total,
      required this.paymentMode,
      this.type = ""});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceDetailsCubit>().fetchServiceDetails(orderId: orderId);
    List<VisitAndQuote> ServiceItems = [];
    String totalAmount = "";
    return Scaffold(
      backgroundColor: const Color(0xffF1F0F5),
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "Review Quote"),
      body: BlocConsumer<ServiceDetailsCubit, ServiceDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          ServiceItems = state.serviceDetails!.visitAndQuote;
          totalAmount = state.serviceDetails!.visitAndQuotePrice;
          if (state.isLoading == true) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => const OrdersLoadingWidget()),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CommonProximaNovaTextWidget(
                              text: "Customer Details",
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            5.ph,
                            RichText(
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: AppthemeColor().themeFont,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                children: <TextSpan>[
                                  const TextSpan(text: 'Customer Name: '),
                                  TextSpan(
                                      text:
                                          '${state.serviceDetails!.customerName}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            5.ph,
                            RichText(
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: AppthemeColor().themeFont,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                children: <TextSpan>[
                                  const TextSpan(text: 'Customer Address: '),
                                  TextSpan(
                                      text:
                                          state.serviceDetails!.customerAddress,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            child: CommonProximaNovaTextWidget(
                              text: "Service Details",
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          5.ph,
                          for (int i = 0;
                              i < state.serviceDetails!.visitAndQuote.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: AppthemeColor().themeFont,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        TextSpan(text: 'Service ${i + 1} : '),
                                        TextSpan(
                                            text:
                                                '${state.serviceDetails!.visitAndQuote[i].serviceName}',
                                            style: TextStyle(
                                                fontFamily:
                                                    AppthemeColor().themeFont,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  8.ph,
                                  RichText(
                                    text: TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: AppthemeColor().themeFont,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        const TextSpan(text: 'Cost : '),
                                        TextSpan(
                                            text:
                                            '₹ ${state.serviceDetails!.visitAndQuote[i].price}',
                                            style: TextStyle(
                                                fontFamily:
                                                AppthemeColor().themeFont,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  if(
                                  state.serviceDetails?.visitAndQuote[i].serialNumber != null &&  state.serviceDetails?.visitAndQuote[i].serialNumber.isNotEmpty == true)
                                  8.ph,

                                  if(
                                  state.serviceDetails?.visitAndQuote[i].serialNumber != null &&  state.serviceDetails?.visitAndQuote[i].serialNumber.isNotEmpty == true)
                                  RichText(
                                    text: TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: AppthemeColor().themeFont,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        const TextSpan(text: 'Serial Number : '),
                                        TextSpan(
                                            text:
                                            state.serviceDetails!.visitAndQuote[i].serialNumber,
                                            style: TextStyle(
                                                fontFamily:
                                                AppthemeColor().themeFont,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  if(
                                  state.serviceDetails?.visitAndQuote[i].warrantyDays != null &&  state.serviceDetails?.visitAndQuote[i].warrantyDays.isNotEmpty == true)
                                  8.ph,
                                  if(
                                  state.serviceDetails?.visitAndQuote[i].warrantyDays != null &&  state.serviceDetails?.visitAndQuote[i].warrantyDays.isNotEmpty == true)
                                  RichText(
                                    text: TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: AppthemeColor().themeFont,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                        const TextSpan(text: 'Warranty Days : '),
                                        TextSpan(
                                            text:
                                            state.serviceDetails?.visitAndQuote[i].warrantyDays,
                                            style: TextStyle(
                                                fontFamily:
                                                AppthemeColor().themeFont,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  if(
                                  state.serviceDetails?.visitAndQuote[i].warrantyDays != null &&  state.serviceDetails?.visitAndQuote[i].warrantyDays.isNotEmpty == true)
                                    8.ph,
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            child: CustomPaint(
                              painter: DottedLinePainter(),
                              child: const SizedBox(
                                width: double.infinity,
                                height: 1.0,
                              ),
                            ),
                          ),
                          4.ph,
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 8),
                            child: RichText(
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: AppthemeColor().themeFont,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  const TextSpan(text: 'Total Bill Amount : '),
                                  TextSpan(
                                      text:
                                          '₹ ${state.serviceDetails?.visitAndQuotePrice}',
                                      style: TextStyle(
                                          fontFamily: AppthemeColor().themeFont,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                          8.ph
                        ],
                      ),
                    ),
                  ),
                  15.ph,
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocListener<SendQuoteCubit, SendQuoteState>(
            listener: (context, state) {
              if (state is SendQuotesuccess) {
                context.read<NewOrdersCubit>().fetchNewOrders(type: "ongoing");
                if (type == "details") {
                  print(">>>>>>>>>>>>>>>>>>>>>>>$type");
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  print(">>>>>>>>>>>>>>>>>>>>>>>$type");

                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              }
              // TODO: implement listener
            },
            child: BlocBuilder<SendQuoteCubit, SendQuoteState>(
              builder: (context, pstate) {
                return SwipeButtons(
                  isLoading: pstate is SendQuoteloading ? true : false,
                  onButtonDragged: () {
                    context.read<SendQuoteCubit>().sendquoate(
                        orderId: orderId,
                        serviceId: serviceId,
                        servicesList: ServiceItems);
                    // submitForms();
                    // bottomSheet();
                  },
                  buttontitle: "SEND QUOTE",
                );
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CreateQuoteScreen(
                        serviceItems: ServiceItems,
                        orderId: orderId,
                        serviceId: serviceId,
                        totalamount: totalAmount, paymentMode:  paymentMode, costAmount: 0,
                      ),
                    ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonProximaNovaTextWidget(
                    text: "Edit Quote",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xffFF3D3D),
                  ),
                  Icon(
                    Icons.edit,
                    size: 13,
                    color: Color(0xffFF3D3D),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
