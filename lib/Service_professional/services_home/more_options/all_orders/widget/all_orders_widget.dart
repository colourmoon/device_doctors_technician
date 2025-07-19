import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

import '../../../../commons/common_button_widget.dart';

class AllOrdersWidget extends StatelessWidget {
  final VoidCallback orderOnTapFun;
  final String orderId, itemcount;
  const AllOrdersWidget(
      {super.key,
      required this.orderOnTapFun,
      required this.orderId,
      required this.itemcount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFEDF0FF),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xFF223DFE),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/services_new/bag.png",
                height: 20,
                width: 20,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonProximaNovaTextWidget(
                  text: "#$orderId",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                CommonProximaNovaTextWidget(
                  text: "service ($itemcount)",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff747474),
                ),
              ],
            ),
          )),
          CommonButtonWidget(
            buttonwidth: 98,
            buttonHeight: 30,
            fontsize: 10,
            circular: 5,
            buttontitle: "VIEW DETAILS",
            titlecolor: AppthemeColor().whiteColor,
            buttonColor: AppthemeColor().appMainColor,
            boardercolor: AppthemeColor().appMainColor,
            buttonOnTap: orderOnTapFun,
          ),
        ],
      ),
    );
  }
}
