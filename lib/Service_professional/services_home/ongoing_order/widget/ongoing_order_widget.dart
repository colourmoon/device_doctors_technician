import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_button_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

class OngoingButtonsWidget extends StatelessWidget {
  final String customerName, buttontitle, phoneNumber, lat, long;
  final VoidCallback buttonOnTap;
  const OngoingButtonsWidget(
      {super.key,
        required this.customerName,
        required this.buttontitle,
        required this.buttonOnTap,
        required this.phoneNumber,
        required this.lat,
        required this.long});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonProximaNovaTextWidget(
                  text: customerName,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
                if (buttontitle == "Pending")
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0xffFF3D3D),
                          ),
                        ),
                        3.pw,
                        const CommonProximaNovaTextWidget(
                          text: "Payment Pending",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xffFF3D3D),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: InkWell(
                        onTap: () async {
                          await callORNavigationButtons().openMap(lat, long);
                        },
                        child: Image.asset(
                          "assets/services_new/location.png",
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: InkWell(
                        onTap: () async {
                          await callORNavigationButtons().makePhoneCall(phoneNumber);
                        },
                        child: Image.asset(
                          "assets/services_new/calls.png",
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          6.pw,
          if (buttontitle != "Pending")
            CommonButtonWidget(
                buttonwidth: 120,
                buttonHeight: 30,
                buttontitle: buttontitle,
                fontsize: 12,
                titlecolor: AppthemeColor().whiteColor,
                buttonColor: AppthemeColor().appMainColor,
                boardercolor: AppthemeColor().appMainColor,
                buttonOnTap: buttonOnTap),
          5.ph
        ],
      ),
    );
  }
}
