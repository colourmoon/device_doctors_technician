import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

import '../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../../commons/color_codes.dart';
import '../../../commons/common_button_widget.dart';
import '../../../commons/shimmer_widgets/shimmer_data.dart';
import '../model/new_orders_model.dart';

class NewOrderWidget extends StatelessWidget {
  final bool isRating;
  final bool device_details_updated;
  final bool is_amc_subscription;

  final VoidCallback orderOnTapFun;
  final Widget buttonWidget;
  final String orderId;
  final String price;
  final String date;
  final String deviceBrand;
  final String model_name;
  final String service_tag;
  final List<ServiceItem> itemsList;

  const NewOrderWidget({
    super.key,
    required this.orderOnTapFun,
    required this.device_details_updated,
    required this.is_amc_subscription,
    required this.buttonWidget,
    required this.deviceBrand,
    required this.model_name,
    required this.service_tag,
    required this.orderId,
    required this.price,
    required this.date,
    required this.itemsList,
    this.isRating = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: GestureDetector(
        onTap: orderOnTapFun,
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFEDF0FF),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonProximaNovaTextWidget(
                            text: "Order Id: #$orderId",
                            color: const Color(0xFF3574E0),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (!is_amc_subscription)
                          CommonProximaNovaTextWidget(
                            text: "₹$price",
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                      ],
                    ),
                    for (int i = 0; i < itemsList.length; i++)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: CommonProximaNovaTextWidget(
                                text: itemsList[i].serviceName ?? '',
                                color: Colors.black,
                                fontSize: 14,
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (itemsList[i].hasVisitAndQuote.toLowerCase() ==
                              "yes")
                            8.pw,
                          if (itemsList[i].hasVisitAndQuote.toLowerCase() ==
                              "yes")
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF223DFE),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              child: const CommonProximaNovaTextWidget(
                                text: "VISIT & QUOTE",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            )
                        ],
                      ),
                    if (device_details_updated) 2.ph,
                    if (device_details_updated)
                      const Text(
                        'Device Details didn\'t Uplaoded',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    2.ph,
                    CommonProximaNovaTextWidget(
                      text: date,
                      color: const Color(0xFF5F5F5F),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              if(device_details_updated && is_amc_subscription)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      const Text(
                        'DEVICE DETAILS',
                        style: TextStyle(
                          color: Color(0xFF494949),
                          fontSize: 12,
                          fontFamily: 'Gilroy-Medium',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Device Brand : ${deviceBrand?.isNotEmpty == true ? deviceBrand : 'N/A'}',
                        style: const TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 12,
                          fontFamily: 'Gilroy-Medium',
                          fontWeight: FontWeight.w400,
                          height: 1.21,
                        ),
                      ),
                      Text(
                        'Model Name : ${model_name?.isNotEmpty == true ? model_name : 'N/A'}',
                        style: const TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 12,
                          fontFamily: 'Gilroy-Medium',
                          fontWeight: FontWeight.w400,
                          height: 1.21,
                        ),
                      ),
                      Text(
                        'Service tag/Serial no: ${service_tag?.isNotEmpty == true ? service_tag : 'N/A'}',
                        style: const TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 12,
                          fontFamily: 'Gilroy-Medium',
                          fontWeight: FontWeight.w400,
                          height: 1.21,
                        ),
                      ),
                    ],
                  ),
                ),

              if (isRating == true)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                    child: const SizedBox(
                      width: double.infinity,
                      height: 1.0,
                    ),
                  ),
                ),
              buttonWidget,
              10.ph
            ],
          ),
        ),
      ),
    );
  }
}

class NewOrderButtonsWidget extends StatelessWidget {
  final VoidCallback acceptOnTap, rejectOnTap;
  final double buttonHeight;
  const NewOrderButtonsWidget(
      {super.key,
      required this.acceptOnTap,
      required this.rejectOnTap,
      required this.buttonHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: CommonButtonWidget(
              circular: 5,
              buttonHeight: buttonHeight,
              buttontitle: "ACCEPT ORDER",
              titlecolor: AppthemeColor().whiteColor,
              buttonColor: AppthemeColor().greenButtonColor,
              boardercolor: AppthemeColor().greenButtonColor,
              buttonOnTap: acceptOnTap,
            ),
          ),
          10.pw,
          Expanded(
            child: CommonButtonWidget(
              circular: 5,
              buttonHeight: buttonHeight,
              buttontitle: "REJECT ORDER",
              titlecolor: AppthemeColor().whiteColor,
              buttonColor: AppthemeColor().redButtonColor,
              boardercolor: AppthemeColor().redButtonColor,
              buttonOnTap: rejectOnTap,
            ),
          ),
        ],
      ),
    );
  }
}

class OrdersLoadingWidget extends StatelessWidget {
  const OrdersLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSimmer1(
                    height: 20,
                    width: 150,
                    radius: const BorderRadius.all(Radius.circular(5.0))),
                5.ph,
                buildSimmer1(
                    height: 20,
                    width: 50,
                    radius: const BorderRadius.all(Radius.circular(5.0)))
              ],
            ),
            5.ph,
            buildSimmer1(
                height: 20,
                width: 400,
                radius: const BorderRadius.all(Radius.circular(5.0))),
            5.ph,
            buildSimmer1(
                height: 20,
                width: 400,
                radius: const BorderRadius.all(Radius.circular(5.0))),
            5.ph,
            Row(
              children: [
                Expanded(
                  child: buildSimmer1(
                      height: 30,
                      width: 400,
                      radius: const BorderRadius.all(Radius.circular(5.0))),
                ),
                20.ph,
                Expanded(
                  child: buildSimmer1(
                      height: 30,
                      width: 400,
                      radius: const BorderRadius.all(Radius.circular(5.0))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
