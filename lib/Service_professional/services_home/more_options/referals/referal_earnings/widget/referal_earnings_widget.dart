import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/refer_list_model.dart';

import '../../../../../commons/color_codes.dart';
import '../../../../../commons/common_button_widget.dart';
import '../../refer_a_friend/screen/refer_a_friend_screen.dart';

class ReferalAmountWidget extends StatelessWidget {
  final String amount;
  const ReferalAmountWidget({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
          color: AppthemeColor().greenButtonColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CommonProximaNovaTextWidget(
            textAlign: TextAlign.center,
            text: "Refer your Friends",
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          3.ph,
          const CommonProximaNovaTextWidget(
            textAlign: TextAlign.center,
            text: "and Earn",
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          SizedBox(
            height: 160,
            width: 170,
            child: Image.asset(
              "assets/services_new/Gift_box.png",
            ),
          ),
          0.ph,
          CommonProximaNovaTextWidget(
            textAlign: TextAlign.center,
            text: amount != '' ? amount : "₹0",
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          13.ph,
          CommonButtonWidget(
            buttonHeight: 40,
            buttonwidth: 150,
            fontsize: 16,
            buttontitle: "Refer a Friend",
            titlecolor: AppthemeColor().greenButtonColor,
            buttonColor: AppthemeColor().whiteColor,
            boardercolor: AppthemeColor().whiteColor,
            buttonOnTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ReferAFriendScreen(
                      amount: amount,
                    ),
                  ));
            },
          ),
          20.ph,
        ],
      ),
    );
  }
}

class ReferalEarningsWidget extends StatelessWidget {
  final ReferList referData;
  const ReferalEarningsWidget({super.key, required this.referData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonProximaNovaTextWidget(
                      textAlign: TextAlign.center,
                      text: referData.name,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    1.ph,
                    CommonProximaNovaTextWidget(
                      textAlign: TextAlign.center,
                      text: referData.createdAt,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff3A3A3A),
                    ),
                  ],
                ),
              ),
              CommonProximaNovaTextWidget(
                textAlign: TextAlign.center,
                text: referData.status,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppthemeColor().greenButtonColor,
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Color(0xffE2E2E2),
        ),
      ],
    );
  }
}
