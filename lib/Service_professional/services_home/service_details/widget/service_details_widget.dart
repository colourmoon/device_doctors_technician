import 'package:device_doctors_technician/Service_professional/services_home/more_options/profile/widget/profile_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_kit/flutter_ex_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:swipe_button_widget/swipe_button_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/utils.dart';

import '../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../../commons/color_codes.dart';
import '../../../commons/common_button_widget.dart';
import '../logic/saved_devices_cubit.dart';
import '../model/model/saved_devices_response.dart';
import '../model/service_details_model.dart';
import '../screen/add_new_device_screen.dart';

class ServiceDetailswidget extends StatelessWidget {
  final String serviceName, quantity, servicePrice;
  final bool hasVisitAndQuote;
  const ServiceDetailswidget(
      {super.key,
      required this.serviceName,
      required this.quantity,
      required this.servicePrice,
      required this.hasVisitAndQuote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasVisitAndQuote)
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xff4570C2)),
              child: const CommonProximaNovaTextWidget(
                text: "VISIT & QUOTE",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          if (hasVisitAndQuote) 3.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: CommonProximaNovaTextWidget(
                  text: "$serviceName  x $quantity",
                  fontSize: 14,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              100.width,
              CommonProximaNovaTextWidget(
                text: "₹$servicePrice",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceStatusWidget extends StatelessWidget {
  final String image, title, description, callimage, phoneNumber, lat, long;
  const ServiceStatusWidget(
      {super.key,
      required this.image,
      required this.title,
      this.callimage = "",
      this.phoneNumber = "",
      this.lat = "",
      this.long = "",
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(image, height: 14, width: 14),
                      3.pw,
                      CommonProximaNovaTextWidget(
                        text: title,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF494949),
                      )
                    ],
                  ),
                  3.ph,
                  CommonProximaNovaTextWidget(
                    text: description,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            callimage != ""
                ? Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: InkWell(
                      onTap: () async {
                        if (phoneNumber != '') {
                          await callORNavigationButtons()
                              .makePhoneCall(phoneNumber);
                        } else if (lat != "" && long != "") {
                          await callORNavigationButtons().openMap(lat, long);
                        }
                      },
                      child: Image.asset(
                        callimage,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ));
  }
}

class BillDetailswidget extends StatelessWidget {
  final String title, price;
  final bool isBold, isTitleBold;
  const BillDetailswidget(
      {super.key,
      required this.title,
      required this.price,
      this.isBold = false,
      this.isTitleBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: CommonProximaNovaTextWidget(
              text: "$title",
              fontSize: isTitleBold ? 16 : 12,
              fontWeight: isTitleBold ? FontWeight.w600 : FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 4,
            child: CommonProximaNovaTextWidget(
              textAlign: TextAlign.end,
              text: "$price",
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceDetailsFullDetailsWidget extends StatelessWidget {
  final String orderId,
      orderStatus,
      serviceBookedOn,
      statusTime,
      customerName,
      customerContact,
      totalAmount,
      platFormFee,
      tipAmount,
      visitnquotetotal,
      is_vendor_update_device_details,
      is_amc_subscription,
      is_quote,
      couponAmount,
      device_id,
      couponCode,
      wallet_part_payment,
      lat,
      complaintText,
      deviceBrand,
      device_model_name,
      service_name,
      device,
      modelName,
      status,
      grand_total,
      payment_mode,
      serialNno,
      paymentType,
      booking_payment_status,
      sub_total,
      taxPercentage,
      long,
      customerAddress;
  final BillDetails? billDetails;
  final List<Tax> taxesList;
  final List<VisitAndQuote> vistAndQuoteList;
  final List<ServiceItem> serviceBookingList;
  const ServiceDetailsFullDetailsWidget(
      {super.key,
      required this.orderId,
      required this.complaintText,
      required this.sub_total,
      required this.taxPercentage,
      required this.grand_total,
      required this.serviceBookedOn,
      required this.device_id,
      required this.is_quote,
      required this.billDetails,
      required this.statusTime,
      required this.status,
      required this.customerName,
      required this.customerContact,
      required this.customerAddress,
      required this.serviceBookingList,
      required this.totalAmount,
      required this.platFormFee,
      required this.couponAmount,
      required this.is_vendor_update_device_details,
      required this.is_amc_subscription,
      required this.service_name,
      required this.booking_payment_status,
      required this.wallet_part_payment,
      this.orderStatus = '',
      required this.taxesList,
      required this.vistAndQuoteList,
      required this.lat,
      required this.long,
      required this.paymentType,
      required this.visitnquotetotal,
      required this.tipAmount,
      required this.couponCode,
      required this.deviceBrand,
      required this.modelName,
      required this.device,
      required this.serialNno,
      required this.payment_mode,
      required this.device_model_name});

  @override
  Widget build(BuildContext context) {
    context.read<SavedDevicesCubit>().updateDeviceDetails(
            savedDevice: SavedDevice(
          brand: deviceBrand,
          deviceType: device,
          modelName: modelName,
          id: device_id,
          serialNumber: serialNno,
        ));
    if (is_amc_subscription == 'yes') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          10.ph,
          CommonProximaNovaTextWidget(
            text: "Order Id: $orderId",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ).symmetric(horizontal: 20),
          12.ph,
          _buildInfoRow('Category', 'Annual Plan'),
          11.ph,
          _buildInfoRow('Services', service_name),
          11.ph,
          BlocBuilder<SavedDevicesCubit, SavedDevicesState>(
            builder: (context, state) {
              final savedDevice = state.savedDevice;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  dottedLine,
                  15.ph,
                  Row(
                    children: [
                      SvgPicture.string(deviceDetails, height: 14, width: 14),
                      3.pw,
                      const CommonProximaNovaTextWidget(
                        text: "DEVICE DETAILS",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF494949),
                      ),
                      const Spacer(),
                      if (status != 'Pending')
                        if (is_vendor_update_device_details
                                .toLowerCase()
                                .trim() ==
                            'no')
                          GestureDetector(
                            child: SvgPicture.string(editIcon,
                                height: 14, width: 14),
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => AddNewDeviceScreen(
                                    id: device_id,
                                    deviceModelName:
                                        savedDevice?.deviceType ?? '',
                                    selectBrand: savedDevice?.brand ?? '',
                                    modelName: savedDevice?.modelName ?? "",
                                    serviceTag: savedDevice?.serialNumber ?? '',
                                  ),
                                ),
                              );
                            },
                          ),
                    ],
                  ).symmetric(horizontal: 20),
                  5.ph,
                  _buildInfoRow('Device', savedDevice?.deviceType),
                  5.ph,
                  _buildInfoRow('Device Brand', savedDevice?.brand),
                  5.ph,
                  _buildInfoRow('Model Name', savedDevice?.modelName),
                  5.ph,
                  _buildInfoRow(
                      'Service tag/Serial no', savedDevice?.serialNumber),
                  15.ph,
                ],
              );
            },
          ),
          dottedLine,
          5.ph,
          ServiceStatusWidget(
                  image: "assets/services_new/Orderedservice.svg",
                  title: "SERVICE BOOKED ON",
                  description: serviceBookedOn)
              .symmetric(horizontal: 20),
          5.ph,
          dottedLine,
          5.ph,
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15, top: 10),
            child: Row(
              children: [
                SvgPicture.string(customerNameIcon, height: 14, width: 14),
                3.pw,
                const CommonProximaNovaTextWidget(
                  text: "CUSTOMER NAME",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff494949),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15, top: 10),
            child: CommonProximaNovaTextWidget(
              text: customerName,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          5.ph,
          dottedLine,
          5.ph,
          ServiceStatusWidget(
                  image: "assets/services_new/Mobile_no.svg",
                  title: "MOBILE NO",
                  phoneNumber: customerContact,
                  callimage:
                      (orderStatus == "new" || orderStatus == "completed")
                          ? ""
                          : "assets/services_new/calls.png",
                  description: customerContact)
              .symmetric(horizontal: 20),
          5.ph,
          dottedLine,
          5.ph,
          ServiceStatusWidget(
                  image: "assets/services_new/Address.svg",
                  title: "ADDRESS",
                  lat: lat,
                  long: long,
                  callimage:
                      (orderStatus == "new" || orderStatus == "completed")
                          ? ""
                          : "assets/services_new/location.png",
                  description: customerAddress)
              .symmetric(horizontal: 22),
          5.ph,
          if (billDetails?.visitAndQuote?.isNotEmpty == true)
            dottedLine,
          if (billDetails?.visitAndQuote?.isNotEmpty == true)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: CommonProximaNovaTextWidget(
                        text: "Service Details",
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.ph,
                    for (int i = 0; i < (billDetails?.visitAndQuote?.length ??0); i++)
                      if (billDetails?.visitAndQuote?.isNotEmpty  == true)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 10
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
                                        '${billDetails?.visitAndQuote?[i].serviceName}',
                                        style: TextStyle(
                                            fontFamily: AppthemeColor().themeFont,
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
                                        text: '₹ ${billDetails?.visitAndQuote?[i].sub_total}',
                                        style: TextStyle(
                                            fontFamily: AppthemeColor().themeFont,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              if (billDetails?.taxPercentage  != null &&
                                  billDetails?.taxAmount?.isNotEmpty ==
                                      true)
                                8.ph,
                              if (billDetails?.taxPercentage  != null &&
                                  billDetails?.taxAmount?.isNotEmpty ==
                                      true)
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
                                      TextSpan(text: 'Tax (${billDetails?.taxPercentage}%) : '),
                                      TextSpan(
                                          text: '₹ ${billDetails?.visitAndQuote?[i]?.tax_amount}',
                                          style: TextStyle(
                                              fontFamily:
                                              AppthemeColor().themeFont,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              if (billDetails?.visitAndQuote?[i].serialNumber != null &&
                                  billDetails?.visitAndQuote?[i].serialNumber.isNotEmpty ==
                                      true)
                                8.ph,
                              if (billDetails?.visitAndQuote?[i].serialNumber != null &&
                                  billDetails?.visitAndQuote?[i].serialNumber.isNotEmpty ==
                                      true)
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
                                          text: vistAndQuoteList[i].serialNumber,
                                          style: TextStyle(
                                              fontFamily:
                                              AppthemeColor().themeFont,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),




                              if (billDetails?.visitAndQuote?[i].warrantyDays != null &&
                                  billDetails?.visitAndQuote?[i].warrantyDays.isNotEmpty ==
                                      true)
                                8.ph,
                              if (billDetails?.visitAndQuote?[i].warrantyDays != null &&
                                  billDetails?.visitAndQuote?[i].warrantyDays.isNotEmpty ==
                                      true)
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
                                          text: billDetails?.visitAndQuote?[i].warrantyDays,
                                          style: TextStyle(
                                              fontFamily:
                                              AppthemeColor().themeFont,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              8.ph,
                              dottedLine,
                            ],
                          ),
                        ),

                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 15, right: 15, bottom: 8),
                    //   child: RichText(
                    //     text: TextSpan(
                    //       // Note: Styles for TextSpans must be explicitly defined.
                    //       // Child text spans will inherit styles from parent
                    //       style: TextStyle(
                    //           fontSize: 14.0,
                    //           fontFamily: AppthemeColor().themeFont,
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w600),
                    //       children: <TextSpan>[
                    //         const TextSpan(text: 'Total Bill Amount : '),
                    //         TextSpan(
                    //             text: '₹ ${visitnquotetotal}',
                    //             style: TextStyle(
                    //                 fontFamily: AppthemeColor().themeFont,
                    //                 fontWeight: FontWeight.w700)),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              children: [
                SvgPicture.string(complaint, height: 14, width: 14),
                3.pw,
                const CommonProximaNovaTextWidget(
                  text: "COMPLAINT",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff494949),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15, top: 10),
            child: CommonProximaNovaTextWidget(
              text: complaintText,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          10.ph,
          if (vistAndQuoteList.isNotEmpty)
            dottedLine,
          // if (vistAndQuoteList.isNotEmpty)

            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 4),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Padding(
            //           padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            //           child: CommonProximaNovaTextWidget(
            //             text: "Service Details",
            //             color: Colors.black,
            //             fontSize: 12,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         5.ph,
            //         for (int i = 0; i < vistAndQuoteList.length; i++)
            //           Padding(
            //             padding: const EdgeInsets.only(
            //               left: 15,
            //               right: 15,
            //             ),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 RichText(
            //                   text: TextSpan(
            //                     // Note: Styles for TextSpans must be explicitly defined.
            //                     // Child text spans will inherit styles from parent
            //                     style: TextStyle(
            //                         fontSize: 14.0,
            //                         fontFamily: AppthemeColor().themeFont,
            //                         color: Colors.black,
            //                         fontWeight: FontWeight.w400),
            //                     children: <TextSpan>[
            //                       TextSpan(text: 'Service ${i + 1} : '),
            //                       TextSpan(
            //                           text:
            //                               '${vistAndQuoteList[i].serviceName}',
            //                           style: TextStyle(
            //                               fontFamily: AppthemeColor().themeFont,
            //                               fontWeight: FontWeight.w600)),
            //                     ],
            //                   ),
            //                 ),
            //                 8.ph,
            //                 RichText(
            //                   text: TextSpan(
            //                     // Note: Styles for TextSpans must be explicitly defined.
            //                     // Child text spans will inherit styles from parent
            //                     style: TextStyle(
            //                         fontSize: 14.0,
            //                         fontFamily: AppthemeColor().themeFont,
            //                         color: Colors.black,
            //                         fontWeight: FontWeight.w400),
            //                     children: <TextSpan>[
            //                       const TextSpan(text: 'Cost : '),
            //                       TextSpan(
            //                           text: '₹ ${vistAndQuoteList[i].price}',
            //                           style: TextStyle(
            //                               fontFamily: AppthemeColor().themeFont,
            //                               fontWeight: FontWeight.w600)),
            //                     ],
            //                   ),
            //                 ),
            //                 if (vistAndQuoteList[i].serialNumber != null &&
            //                     vistAndQuoteList[i].serialNumber.isNotEmpty ==
            //                         true)
            //                   8.ph,
            //                 if (vistAndQuoteList[i].serialNumber != null &&
            //                     vistAndQuoteList[i].serialNumber.isNotEmpty ==
            //                         true)
            //                   RichText(
            //                     text: TextSpan(
            //                       // Note: Styles for TextSpans must be explicitly defined.
            //                       // Child text spans will inherit styles from parent
            //                       style: TextStyle(
            //                           fontSize: 14.0,
            //                           fontFamily: AppthemeColor().themeFont,
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.w400),
            //                       children: <TextSpan>[
            //                         const TextSpan(text: 'Serial Number : '),
            //                         TextSpan(
            //                             text: vistAndQuoteList[i].serialNumber,
            //                             style: TextStyle(
            //                                 fontFamily:
            //                                     AppthemeColor().themeFont,
            //                                 fontWeight: FontWeight.w600)),
            //                       ],
            //                     ),
            //                   ),
            //                 if (vistAndQuoteList[i].warrantyDays != null &&
            //                     vistAndQuoteList[i].warrantyDays.isNotEmpty ==
            //                         true)
            //                   8.ph,
            //                 if (vistAndQuoteList[i].warrantyDays != null &&
            //                     vistAndQuoteList[i].warrantyDays.isNotEmpty ==
            //                         true)
            //                   RichText(
            //                     text: TextSpan(
            //                       // Note: Styles for TextSpans must be explicitly defined.
            //                       // Child text spans will inherit styles from parent
            //                       style: TextStyle(
            //                           fontSize: 14.0,
            //                           fontFamily: AppthemeColor().themeFont,
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.w400),
            //                       children: <TextSpan>[
            //                         const TextSpan(text: 'Warranty Days : '),
            //                         TextSpan(
            //                             text: vistAndQuoteList[i].warrantyDays,
            //                             style: TextStyle(
            //                                 fontFamily:
            //                                     AppthemeColor().themeFont,
            //                                 fontWeight: FontWeight.w600)),
            //                       ],
            //                     ),
            //                   ),
            //                 if (vistAndQuoteList[i].warrantyDays != null &&
            //                     vistAndQuoteList[i].warrantyDays.isNotEmpty ==
            //                         true)
            //                   8.ph,
            //               ],
            //             ),
            //           ),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(
            //               vertical: 8, horizontal: 15),
            //           child: CustomPaint(
            //             painter: DottedLinePainter(),
            //             child: const SizedBox(
            //               width: double.infinity,
            //               height: 1.0,
            //             ),
            //           ),
            //         ),
            //         4.ph,
            //         Padding(
            //           padding:
            //               const EdgeInsets.only(left: 15, right: 15, bottom: 8),
            //           child: RichText(
            //             text: TextSpan(
            //               // Note: Styles for TextSpans must be explicitly defined.
            //               // Child text spans will inherit styles from parent
            //               style: TextStyle(
            //                   fontSize: 14.0,
            //                   fontFamily: AppthemeColor().themeFont,
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.w600),
            //               children: <TextSpan>[
            //                 const TextSpan(text: 'Total Bill Amount : '),
            //                 TextSpan(
            //                     text: '₹ ${visitnquotetotal}',
            //                     style: TextStyle(
            //                         fontFamily: AppthemeColor().themeFont,
            //                         fontWeight: FontWeight.w700)),
            //               ],
            //             ),
            //           ),
            //         ),
            //         8.ph
            //       ],
            //     ),
            //   ),
            // ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        10.ph,
        CommonProximaNovaTextWidget(
          text: "Order Id: $orderId",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ).symmetric(horizontal: 20),
        5.ph,
        ListView.builder(
          itemCount: serviceBookingList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => ServiceDetailswidget(
              hasVisitAndQuote:
                  serviceBookingList[index].hasVisitAndQuote == 'yes'
                      ? true
                      : false,
              serviceName: serviceBookingList[index].serviceName,
              quantity: serviceBookingList[index].quantity,
              servicePrice: serviceBookingList[index].price),
        ).symmetric(horizontal: 20),
        5.ph,
        BlocBuilder<SavedDevicesCubit, SavedDevicesState>(
          builder: (context, state) {
            final savedDevice = state.savedDevice;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                dottedLine,
                15.ph,
                Row(
                  children: [
                    SvgPicture.string(deviceDetails, height: 14, width: 14),
                    3.pw,
                    const CommonProximaNovaTextWidget(
                      text: "DEVICE DETAILS",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF494949),
                    ),
                    const Spacer(),
                    if (is_vendor_update_device_details.toLowerCase().trim() ==
                            'no' &&
                        status != 'Pending')
                      GestureDetector(
                        child:
                            SvgPicture.string(editIcon, height: 14, width: 14),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddNewDeviceScreen(
                                id: device_id,
                                deviceModelName: savedDevice?.deviceType ?? '',
                                selectBrand: savedDevice?.brand ?? '',
                                modelName: savedDevice?.modelName ?? "",
                                serviceTag: savedDevice?.serialNumber ?? '',
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ).symmetric(horizontal: 20),
                5.ph,
                _buildInfoRow('Device', savedDevice?.deviceType),
                5.ph,
                _buildInfoRow('Device Brand', savedDevice?.brand),
                5.ph,
                _buildInfoRow('Model Name', savedDevice?.modelName),
                5.ph,
                _buildInfoRow(
                    'Service tag/Serial no', savedDevice?.serialNumber),
                15.ph,
              ],
            );
          },
        ),
        dottedLine,
        5.ph,
        ServiceStatusWidget(
                image: "assets/services_new/Orderedservice.svg",
                title: "Service Booked On",
                description: serviceBookedOn)
            .symmetric(horizontal: 20),
        5.ph,
        dottedLine,
        5.ph,
        ServiceStatusWidget(
                image: "assets/services_new/Orderedservice.svg",
                title: orderStatus == "new"
                    ? "Service Created at"
                    : orderStatus == "accepted"
                        ? "Service Accepted at"
                        : orderStatus == "START SERVICE" ||
                                orderStatus == "CREATE QUOTE"
                            ? "Reached Location at"
                            : orderStatus == "COMPLETE"
                                ? "Service Started at"
                                : orderStatus == "REVIEW QUOTE"
                                    ? "Quote Created at"
                                    : "Service $orderStatus at",
                // : "Service Completed at",
                description: statusTime)
            .symmetric(horizontal: 20),
        5.ph,
        dottedLine,
        5.ph,
        ServiceStatusWidget(
                image: "assets/services_new/Customer_Name.svg",
                title: "Customer Name",
                description: customerName)
            .symmetric(horizontal: 20),
        5.ph,
        dottedLine,
        5.ph,
        ServiceStatusWidget(
                image: "assets/services_new/Mobile_no.svg",
                title: "Mobile no",
                phoneNumber: customerContact,
                callimage: (orderStatus == "new" || orderStatus == "completed")
                    ? ""
                    : "assets/services_new/calls.png",
                description: customerContact)
            .symmetric(horizontal: 20),
        5.ph,
        dottedLine,
        5.ph,
        ServiceStatusWidget(
                image: "assets/services_new/Address.svg",
                title: "Address",
                lat: lat,
                long: long,
                callimage: (orderStatus == "new" || orderStatus == "completed")
                    ? ""
                    : "assets/services_new/location.png",
                description: customerAddress)
            .symmetric(horizontal: 22),
        5.ph,
        dottedLine,
        5.ph,
        Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            //   child: Row(
            //     children: [
            //       SvgPicture.asset("assets/services_new/billdetails.svg",
            //           height: 14, width: 14),
            //       3.pw,
            //       const CommonProximaNovaTextWidget(
            //         text: "Bill Details",
            //         fontSize: 12,
            //         fontWeight: FontWeight.w600,
            //         color: Color(0xff494949),
            //       )
            //     ],
            //   ),
            // ),
            // 5.ph,
            // BillDetailswidget(
            //   title: "Sub Total",
            //   price: "₹$platFormFee",
            //   isBold: true,
            // ),
            // if (taxesList.isNotEmpty)
            //   for (int i = 0; i < taxesList.length; i++)
            //     if (taxesList[i].taxAmount != "0" &&
            //         taxesList[i].taxAmount != "null" &&
            //         taxesList[i].taxAmount != "0.00")
            //       BillDetailswidget(
            //         isBold: true,
            //         title:
            //             '${taxesList[i].taxName} (${taxesList[i].tax_percentage}%)',
            //         price: "₹${taxesList[i].taxAmount}",
            //       ),
            // if (tipAmount != "0" && tipAmount != "" && tipAmount != "0.00")
            //   BillDetailswidget(
            //     title: "Tip",
            //     price: "₹$tipAmount",
            //     isBold: true,
            //   ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 4),
            //   child: CustomPaint(
            //     painter: DottedLinePainter(),
            //     child: const SizedBox(
            //       width: double.infinity,
            //       height: 1.0,
            //     ),
            //   ),
            // ),
            // if (couponAmount != "0" &&
            //     couponAmount != "null" &&
            //     couponAmount != "0.00")
            //   BillDetailswidget(
            //     isBold: true,
            //     title: couponCode,
            //     price: "- ₹$couponAmount",
            //   ),
            // BillDetailswidget(
            //   title: "Total",
            //   isTitleBold: true,
            //   isBold: true,
            //   price: "₹$totalAmount",
            // ),
            10.ph,

            if ( is_quote ==
                '1') ...[
              if (status !=
                  "Cancelled")

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/services_new/billdetails.svg",
                        height: 14, width: 14),
                    3.pw,
                    const CommonProximaNovaTextWidget(
                      text: "Bill Details",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff494949),
                    )
                  ],
                ),
              ),
              if (status !=
                  "Cancelled")
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 0),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 12),
                          child: ListView.builder(
                              physics:
                              const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: billDetails
                                  ?.visitAndQuote
                                  ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final data = billDetails
                                    ?.visitAndQuote?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5),
                                  child:Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data?.serviceName ?? '',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: const Color(0xFF5C5C5C),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '₹ ${ data?.sub_total ?? ''}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),

                                );
                              })),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax (${billDetails?.taxPercentage}%)',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xFF5C5C5C),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '₹ ${billDetails?.taxAmount}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10),
                      //   child: BookingText(
                      //       title: 'Payment Mode',
                      //       value: bookingState
                      //           .serviceOrderViewData!
                      //           .data!
                      //           .paymentMode),
                      // ),

                        if(payment_mode !='Paid')
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Payment Status',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xFF5C5C5C),
                                  fontWeight: FontWeight.w500),
                            ),
                            CommonProximaNovaTextWidget(
                              text: billDetails?.paymentStatus ??'',
                              fontSize: 14,
                              color:
                              ApplicationColours.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      // if (bookingState.serviceOrderViewData!.data!
                      //     .visitAndQuote.isNotEmpty)
                      //   ListView.builder(
                      //       shrinkWrap: true,
                      //       physics:
                      //           const NeverScrollableScrollPhysics(),
                      //       itemCount: bookingState
                      //           .serviceOrderViewData!
                      //           .data!
                      //           .visitAndQuote
                      //           .length,
                      //       itemBuilder: (context, visitIndex) {
                      //         return Padding(
                      //           padding: const EdgeInsets.only(
                      //             bottom: 5,
                      //             left: 10,
                      //             right: 10,
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Expanded(
                      //                 child:
                      //                     CommonProximaNovaTextWidget(
                      //                   text: bookingState
                      //                       .serviceOrderViewData!
                      //                       .data!
                      //                       .visitAndQuote[visitIndex]
                      //                       .serviceName,
                      //                   fontSize: 12,
                      //                   color: ApplicationColours
                      //                       .blackColor,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //               20.pw,
                      //               CommonProximaNovaTextWidget(
                      //                 text:
                      //                     "₹ ${bookingState.serviceOrderViewData!.data!.visitAndQuote[visitIndex].price}",
                      //                 fontSize: 14,
                      //                 color: ApplicationColours
                      //                     .blackColor,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }),

                      if (double.parse(tipAmount
                          .toString()
                          .replaceAll(',', '')) >
                          0)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const CommonProximaNovaTextWidget(
                                text: 'Tip',
                                fontSize: 12,
                                color:
                                ApplicationColours.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                              CommonProximaNovaTextWidget(
                                text:
                                '₹ ${tipAmount}',
                                fontSize: 14,
                                color:
                                ApplicationColours.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),



                          Padding(
                            padding: const EdgeInsets.only(
                                top: 2, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const CommonProximaNovaTextWidget(
                                  text: "Online/Wallet",
                                  fontSize: 12,
                                  color:
                                  ApplicationColours.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                CommonProximaNovaTextWidget(
                                  text:
                                  '- ₹${billDetails?.onlineAmount}',
                                  fontSize: 14,
                                  color:
                                  ApplicationColours.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),

                      const SizedBox(
                        height: 10,
                      ),
                      CustomPaint(
                        painter: DottedLinePainter(),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 1,
                        ),
                      ),
                      if (couponCode.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CommonProximaNovaTextWidget(
                                text:couponCode,
                                fontSize: 12,
                                color:
                                ApplicationColours.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                              CommonProximaNovaTextWidget(
                                text:
                                '- ₹ ${couponAmount}',
                                fontSize: 14,
                                color:
                                ApplicationColours.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      CustomPaint(
                        painter: DottedLinePainter(),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 1,
                        ),
                      ),
                      14.ph,
                      // if (bookingState.serviceOrderViewData!.data!
                      //     .visitAndQuote.isNotEmpty)
                      //   Container(
                      //     padding: const EdgeInsets.only(
                      //         bottom: 5.0, left: 10),
                      //     child:
                      //         const ServiceDetailsHeadingsWidget(
                      //       title: 'QUOTE DETAILS',
                      //     ),
                      //   ),
                      // if (bookingState.serviceOrderViewData!.data!
                      //     .visitAndQuote.isNotEmpty)
                      //   Container(
                      //     margin: const EdgeInsets.symmetric(
                      //         horizontal: 4, vertical: 10),
                      //     child: Column(
                      //       children: [
                      //         ListView.builder(
                      //             shrinkWrap: true,
                      //             physics:
                      //                 const NeverScrollableScrollPhysics(),
                      //             itemCount: bookingState
                      //                 .serviceOrderViewData!
                      //                 .data!
                      //                 .visitAndQuote
                      //                 .length,
                      //             itemBuilder:
                      //                 (context, visitIndex) {
                      //               return Column(
                      //                 children: [
                      //                   Padding(
                      //                     padding:
                      //                         const EdgeInsets
                      //                             .only(
                      //                       bottom: 5,
                      //                       left: 10,
                      //                       right: 10,
                      //                     ),
                      //                     child: Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment
                      //                               .spaceBetween,
                      //                       children: [
                      //                         Expanded(
                      //                           child:
                      //                               CommonProximaNovaTextWidget(
                      //                             text: bookingState
                      //                                     .serviceOrderViewData!
                      //                                     .data!
                      //                                     .visitAndQuote[
                      //                                         visitIndex]
                      //                                     .serviceName[
                      //                                         0]
                      //                                     .toUpperCase() +
                      //                                 bookingState
                      //                                     .serviceOrderViewData!
                      //                                     .data!
                      //                                     .visitAndQuote[
                      //                                         visitIndex]
                      //                                     .serviceName
                      //                                     .substring(
                      //                                         1),
                      //                             fontSize: 12,
                      //                             color: ApplicationColours
                      //                                 .blackColor,
                      //                             fontWeight:
                      //                                 FontWeight
                      //                                     .w600,
                      //                           ),
                      //                         ),
                      //                         20.pw,
                      //                         CommonProximaNovaTextWidget(
                      //                           text:
                      //                               "₹ ${bookingState.serviceOrderViewData!.data!.visitAndQuote[visitIndex].price}",
                      //                           fontSize: 14,
                      //                           color:
                      //                               ApplicationColours
                      //                                   .blackColor,
                      //                           fontWeight:
                      //                               FontWeight
                      //                                   .w600,
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ],
                      //               );
                      //             }),
                      //         Padding(
                      //           padding: const EdgeInsets.only(
                      //             bottom: 5,
                      //             left: 10,
                      //             right: 10,
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment
                      //                     .spaceBetween,
                      //             children: [
                      //               const Expanded(
                      //                 child:
                      //                     CommonProximaNovaTextWidget(
                      //                   text: "Payment Status",
                      //                   fontSize: 12,
                      //                   color: ApplicationColours
                      //                       .blackColor,
                      //                   fontWeight:
                      //                       FontWeight.w600,
                      //                 ),
                      //               ),
                      //               20.pw,
                      //               CommonProximaNovaTextWidget(
                      //                 text: bookingState
                      //                     .serviceOrderViewData!
                      //                     .data!
                      //                     .paymentType,
                      //                 fontSize: 14,
                      //                 color: ApplicationColours
                      //                     .blackColor,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         CustomPaint(
                      //           painter: dot.DottedLinePainter(),
                      //           child: const SizedBox(
                      //             width: double.infinity,
                      //             height: 1,
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(
                      //               left: 10,
                      //               right: 10,
                      //               bottom: 5,
                      //               top: 5),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment
                      //                     .spaceBetween,
                      //             children: [
                      //               const CommonProximaNovaTextWidget(
                      //                 text: 'Total Quotation',
                      //                 fontSize: 16,
                      //                 color: ApplicationColours
                      //                     .blackColor,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //               CommonProximaNovaTextWidget(
                      //                 text:
                      //                     '₹ ${bookingState.serviceOrderViewData!.data!.visitAndQuotePrice}',
                      //                 fontSize: 16,
                      //                 color: ApplicationColours
                      //                     .blackColor,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 15,
                            top: 5),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const CommonProximaNovaTextWidget(
                              text: 'Total Bill',
                              fontSize: 16,
                              color:
                              ApplicationColours.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                            CommonProximaNovaTextWidget(
                              text:
                              '₹ ${billDetails?.totalBill}',
                              fontSize: 16,
                              color:
                              ApplicationColours.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ]
            else ...[
              if (status !=
                  "Cancelled")
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/services_new/billdetails.svg",
                          height: 14, width: 14),
                      3.pw,
                      const CommonProximaNovaTextWidget(
                        text: "Bill Details",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff494949),
                      )
                    ],
                  ),
                ),
              if (status !=
                  "Cancelled")
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sub Total',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xFF5C5C5C),
                                  fontWeight: FontWeight.w500),
                            ),
                            CommonProximaNovaTextWidget(
                              text:
                              '₹ ${sub_total}',
                              fontSize: 14,
                              color:
                              ApplicationColours.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: ListView.builder(
                            physics:
                            const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: taxesList
                                .length ??
                                0,
                            itemBuilder: (context, index) {
                              final taxData = taxesList[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      '${taxData?.taxName} (${taxData?.tax_percentage}%)',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: const Color(
                                              0xFF5C5C5C),
                                          fontWeight:
                                          FontWeight.w500),
                                    ),
                                    Text(
                                      '₹ ${taxData?.totalPrice}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.w500),
                                    ),
                                  ],
                                ),
                              );
                            }),

                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const CommonProximaNovaTextWidget(
                        //       text: 'Tax Amount',
                        //       fontSize: 12,
                        //       color: ApplicationColours.blackColor,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //     CommonProximaNovaTextWidget(
                        //       text:
                        //           '₹ ${bookingState.serviceOrderViewData!.data!.taxAmount}',
                        //       fontSize: 14,
                        //       color: ApplicationColours.blackColor,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ],
                        // ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Payment Mode',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xFF5C5C5C),
                                  fontWeight: FontWeight.w500),
                            ),
                            CommonProximaNovaTextWidget(
                              text: payment_mode,
                              fontSize: 14,
                              color:
                              ApplicationColours.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
            if(paymentType !='Paid')...[

            ],


                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Payment Status',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xFF5C5C5C),
                                  fontWeight: FontWeight.w500),
                            ),
                            CommonProximaNovaTextWidget(
                              text: booking_payment_status,
                              fontSize: 14,
                              color:
                              ApplicationColours.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      if (double.parse(tipAmount
                          .toString()
                          .replaceAll(',', '')) >
                          0)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const CommonProximaNovaTextWidget(
                                text: 'Tip',
                                fontSize: 12,
                                color:
                                ApplicationColours.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                              CommonProximaNovaTextWidget(
                                text:
                                '₹ ${tipAmount}',
                                fontSize: 14,
                                color:
                                ApplicationColours.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),

                      // if (double.parse(bookingState
                      //         .serviceOrderViewData!
                      //         .data!
                      //         .grandTotal
                      //         .toString()
                      //         .replaceAll(',', '')) >
                      //     0)
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 2, left: 10, right: 10),
                      //   child: Row(
                      //     mainAxisAlignment:
                      //         MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       const CommonProximaNovaTextWidget(
                      //         text: "Online Paid",
                      //         fontSize: 12,
                      //         color:
                      //             ApplicationColours.blackColor,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //       CommonProximaNovaTextWidget(
                      //         text:
                      //             '₹ ${bookingState.serviceOrderViewData!.data!.grandTotal}',
                      //         fontSize: 14,
                      //         color:
                      //             ApplicationColours.blackColor,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomPaint(
                        painter: DottedLinePainter(),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 1,
                        ),
                      ),
                      if (couponCode !=
                          '')
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CommonProximaNovaTextWidget(
                                text: couponCode,
                                fontSize: 12,
                                color:
                                ApplicationColours.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                              CommonProximaNovaTextWidget(
                                text:
                                '- ₹ ${couponAmount}',
                                fontSize: 14,
                                color:
                                ApplicationColours.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      CustomPaint(
                        painter: DottedLinePainter(),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 1,
                        ),
                      ),
                      14.ph,
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 15,
                            top: 5),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const CommonProximaNovaTextWidget(
                              text: 'Total Bill',
                              fontSize: 16,
                              color:
                              ApplicationColours.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                            CommonProximaNovaTextWidget(
                              text:
                              '₹ ${grand_total }',
                              fontSize: 16,
                              color:
                              ApplicationColours.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),


      ],
    );
  }

  Widget _buildInfoRow(String title, String? value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.21,
            ),
          ),
        ),
        Text(
          (value?.isNotEmpty == true)
              ? '${value![0].toUpperCase()}${value.substring(1)}'
              : 'N/A',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            height: 0,
          ),
        )
      ],
    ).symmetric(horizontal: 20);
  }
}

class SwipeButtons extends StatelessWidget {
  final String buttontitle;
  final bool? isLoading;
  final double fontSize;
  final Function() onButtonDragged;
  const SwipeButtons(
      {super.key,
      required this.buttontitle,
      this.fontSize = 14,
      required this.onButtonDragged,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    const threeRight =
        '''<svg width="27" height="11" viewBox="0 0 27 11" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M6.36794 4.85872L1.3671 0.691346C1.1971 0.550724 0.978298 0.4832 0.758614 0.503561C0.53893 0.523922 0.336267 0.630509 0.195005 0.799981C0.0537425 0.969452 -0.0146061 1.188 0.00492635 1.40776C0.0244588 1.62751 0.13028 1.83058 0.299218 1.97248L4.53169 5.49931L0.299218 9.02614C0.129629 9.16784 0.0232229 9.37107 0.00337299 9.59117C-0.0164769 9.81128 0.051853 10.0303 0.193353 10.2C0.334852 10.3698 0.537949 10.4764 0.758029 10.4965C0.97811 10.5166 1.19717 10.4486 1.3671 10.3073L6.36794 6.13985C6.46171 6.06151 6.53713 5.96354 6.58889 5.85285C6.64065 5.74217 6.66747 5.62147 6.66747 5.49928C6.66747 5.37709 6.64065 5.2564 6.58889 5.14571C6.53713 5.03503 6.46171 4.93706 6.36794 4.85872Z" fill="black"/>
<path d="M16.3679 4.85872L11.3671 0.691346C11.1971 0.550724 10.9783 0.4832 10.7586 0.503561C10.5389 0.523922 10.3363 0.630509 10.195 0.799981C10.0537 0.969452 9.98539 1.188 10.0049 1.40776C10.0245 1.62751 10.1303 1.83058 10.2992 1.97248L14.5317 5.49931L10.2992 9.02614C10.1296 9.16784 10.0232 9.37107 10.0034 9.59117C9.98352 9.81128 10.0519 10.0303 10.1934 10.2C10.3349 10.3698 10.5379 10.4764 10.758 10.4965C10.9781 10.5166 11.1972 10.4486 11.3671 10.3073L16.3679 6.13985C16.4617 6.06151 16.5371 5.96354 16.5889 5.85285C16.6406 5.74217 16.6675 5.62147 16.6675 5.49928C16.6675 5.37709 16.6406 5.2564 16.5889 5.14571C16.5371 5.03503 16.4617 4.93706 16.3679 4.85872Z" fill="black"/>
<path d="M26.3679 4.85872L21.3671 0.691346C21.1971 0.550724 20.9783 0.4832 20.7586 0.503561C20.5389 0.523922 20.3363 0.630509 20.195 0.799981C20.0537 0.969452 19.9854 1.188 20.0049 1.40776C20.0245 1.62751 20.1303 1.83058 20.2992 1.97248L24.5317 5.49931L20.2992 9.02614C20.1296 9.16784 20.0232 9.37107 20.0034 9.59117C19.9835 9.81128 20.0519 10.0303 20.1934 10.2C20.3349 10.3698 20.5379 10.4764 20.758 10.4965C20.9781 10.5166 21.1972 10.4486 21.3671 10.3073L26.3679 6.13985C26.4617 6.06151 26.5371 5.96354 26.5889 5.85285C26.6406 5.74217 26.6675 5.62147 26.6675 5.49928C26.6675 5.37709 26.6406 5.2564 26.5889 5.14571C26.5371 5.03503 26.4617 4.93706 26.3679 4.85872Z" fill="black"/>
</svg>
''';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SwipeButton.expand(
        activeThumbColor: Colors.white,
        thumbPadding: const EdgeInsets.all(5),
        activeTrackColor: const Color(0xFF223DFE),
        thumb: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.string(
            threeRight,
            height: 14,
          ),
        ),
        elevationThumb: 4,
        onSwipe: () async {
          await onButtonDragged
              .call(); // or pass the appropriate value if needed
          await Future.delayed(const Duration(seconds: 2));
          if (isLoading!) {
            // success
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Swiped!"),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            // failed or cancelled
          }
        },
        child: Text(
          buttontitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CompleteOrderEarningsWidget extends StatelessWidget {
  final String price;
  const CompleteOrderEarningsWidget({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: DottedBorder(
        color: AppthemeColor().greenButtonColor,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        strokeWidth: 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/services_new/save-money.png",
                    ),
                    height: 20,
                    width: 20,
                  ),
                  Text(
                    ' Yay! Your Earning on this Order ₹$price',
                    style: TextStyle(
                      color: AppthemeColor().greenButtonColor,
                      fontSize: 14,
                      fontFamily: AppthemeColor().themeFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const deviceDetails = """
<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M13.3369 10.1828V3.2438C13.3369 2.66331 12.8875 2.18837 12.3381 2.18837H1.66284C1.11349 2.18837 0.664062 2.66331 0.664062 3.2438V10.1828H13.3369ZM12.3213 9.16718V3.2438C12.3213 3.23285 12.3184 3.21573 12.3117 3.20401H1.68926C1.68251 3.21573 1.6797 3.23285 1.6797 3.2438V9.16718H12.3213Z" fill="#494949"/>
<path fill-rule="evenodd" clip-rule="evenodd" d="M0.689388 11.8116H13.3106C13.6898 11.8116 14 11.5014 14 11.1222V10.4328H0V11.1222C0 11.5014 0.310202 11.8116 0.689388 11.8116ZM8.33714 10.589H5.66285V10.8448C5.66285 10.9854 5.7725 11.1005 5.90653 11.1005H8.09347C8.2275 11.1005 8.33714 10.9854 8.33714 10.8448V10.589Z" fill="#494949"/>
</svg>
""";
const editIcon = """
<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_1238_2592)">
<path d="M2.87984 13.472C3.03984 13.472 3.07184 13.456 3.21584 13.424L6.09584 12.848C6.39984 12.768 6.70384 12.624 6.94384 12.384L13.9198 5.408C14.9918 4.336 14.9918 2.496 13.9198 1.424L13.3278 0.800002C12.2558 -0.271998 10.3998 -0.271998 9.32784 0.800002L2.35184 7.792C2.12784 8.016 1.96784 8.336 1.88784 8.64L1.27984 11.552C1.19984 12.096 1.35984 12.624 1.74384 13.008C2.04784 13.312 2.49584 13.472 2.87984 13.472ZM3.42384 8.944L10.3998 1.952C10.8638 1.488 11.7118 1.488 12.1598 1.952L12.7678 2.56C13.3118 3.104 13.3118 3.872 12.7678 4.4L5.80784 11.392L2.84784 11.888L3.42384 8.944Z" fill="#223DFE"/>
<path d="M13.8558 14.464H2.04779C1.58379 14.464 1.27979 14.768 1.27979 15.232C1.27979 15.696 1.66379 16 2.04779 16H13.7918C14.2558 16 14.6398 15.696 14.6398 15.232C14.6238 14.768 14.2398 14.464 13.8558 14.464Z" fill="#223DFE"/>
</g>
<defs>
<clipPath id="clip0_1238_2592">
<rect width="16" height="16" fill="white"/>
</clipPath>
</defs>
</svg>
""";
const complaint = '''
<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_1264_2633)">
<path d="M11.4335 2.56663C10.3679 1.47849 8.94242 0.815784 7.42364 0.702441C5.90486 0.589098 4.39679 1.03288 3.18148 1.9508C1.96617 2.86872 1.12684 4.1979 0.820468 5.68978C0.514094 7.18165 0.761655 8.73404 1.51685 10.0566L1.10852 11.6666C1.06767 11.8357 1.07095 12.0124 1.11803 12.1798C1.16512 12.3472 1.25444 12.4998 1.37741 12.6227C1.50039 12.7457 1.65291 12.835 1.82033 12.8821C1.98775 12.9292 2.16447 12.9325 2.33352 12.8916L3.92019 12.4716C4.86156 12.9972 5.92205 13.2723 7.00019 13.2708C7.44947 13.2713 7.89744 13.2224 8.33602 13.125C9.43656 12.8864 10.4525 12.3557 11.2768 11.5886C12.1012 10.8214 12.7036 9.84631 13.0206 8.76576C13.3376 7.68521 13.3575 6.53919 13.0782 5.44828C12.7989 4.35737 12.2308 3.36191 11.4335 2.56663ZM12.326 7.8983C12.1809 8.7651 11.8261 9.58327 11.2924 10.2815C10.7587 10.9798 10.0623 11.537 9.26401 11.9045C8.46569 12.272 7.5896 12.4388 6.71208 12.3902C5.83457 12.3416 4.98224 12.0792 4.22935 11.6258C4.16278 11.5844 4.08607 11.5622 4.00769 11.5616C3.969 11.556 3.9297 11.556 3.89102 11.5616L2.14102 12.0341C2.11613 12.0396 2.09026 12.0388 2.0658 12.0316C2.04133 12.0245 2.01905 12.0113 2.00103 11.9933C1.98301 11.9753 1.96982 11.953 1.96268 11.9285C1.95554 11.9041 1.95468 11.8782 1.96019 11.8533L2.43269 10.1033C2.45019 10.0469 2.45508 9.9874 2.44702 9.92893C2.43895 9.87047 2.41813 9.81449 2.38602 9.76496C1.93989 9.01896 1.68058 8.17622 1.63017 7.30845C1.57976 6.44069 1.73974 5.57359 2.09649 4.78095C2.45324 3.9883 2.99621 3.29358 3.67918 2.75589C4.36216 2.21821 5.16492 1.85348 6.01915 1.69275C6.87339 1.53202 7.75382 1.58004 8.58551 1.83272C9.41719 2.08541 10.1755 2.53528 10.796 3.14406C11.4164 3.75283 11.8806 4.50249 12.149 5.32923C12.4175 6.15597 12.4822 7.03533 12.3377 7.89246L12.326 7.8983ZM9.05935 5.56496L7.61852 6.99996L9.05935 8.4408C9.14128 8.52283 9.1873 8.63402 9.1873 8.74996C9.1873 8.8659 9.14128 8.9771 9.05935 9.05913C8.97732 9.14106 8.86612 9.18708 8.75019 9.18708C8.63425 9.18708 8.52305 9.14106 8.44102 9.05913L7.00019 7.6183L5.55935 9.05913C5.47732 9.14106 5.36612 9.18708 5.25019 9.18708C5.13425 9.18708 5.02305 9.14106 4.94102 9.05913C4.85909 8.9771 4.81307 8.8659 4.81307 8.74996C4.81307 8.63402 4.85909 8.52283 4.94102 8.4408L6.38185 6.99996L4.94102 5.55913C4.86374 5.47619 4.82167 5.3665 4.82367 5.25316C4.82567 5.13982 4.87158 5.03167 4.95174 4.95152C5.0319 4.87136 5.14004 4.82544 5.25338 4.82344C5.36672 4.82144 5.47642 4.86352 5.55935 4.9408L7.00019 6.38163L8.44102 4.9408C8.52396 4.86352 8.63365 4.82144 8.74699 4.82344C8.86033 4.82544 8.96847 4.87136 9.04863 4.95152C9.12879 5.03167 9.17471 5.13982 9.17671 5.25316C9.17871 5.3665 9.13663 5.47619 9.05935 5.55913V5.56496Z" fill="#494949"/>
</g>
<defs>
<clipPath id="clip0_1264_2633">
<rect width="14" height="14" fill="white"/>
</clipPath>
</defs>
</svg>
''';
const customerNameIcon = '''

<svg width="13" height="14" viewBox="0 0 13 14" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M1.51562 4.55939C1.51562 7.06705 3.56735 9.11877 6.07501 9.11877C8.58267 9.11877 10.6344 7.06705 10.6344 4.55939C10.6344 2.05172 8.58267 0 6.07501 0C3.56735 0 1.51562 2.05172 1.51562 4.55939ZM9.5616 4.55939C9.5616 6.47701 7.99264 8.04598 6.07501 8.04598C4.15739 8.04598 2.58842 6.47701 2.58842 4.55939C2.58842 2.64176 4.15739 1.0728 6.07501 1.0728C7.99264 1.0728 9.5616 2.64176 9.5616 4.55939Z" fill="#494949"/>
<path d="M0.764368 14.0001C2.18582 12.5786 4.06322 11.8008 6.07471 11.8008C8.08621 11.8008 9.9636 12.5786 11.3851 14.0001L12.1494 13.2357C10.5268 11.6265 8.36782 10.728 6.07471 10.728C3.78161 10.728 1.62261 11.6265 0 13.2357L0.764368 14.0001Z" fill="#494949"/>
</svg>

''';
