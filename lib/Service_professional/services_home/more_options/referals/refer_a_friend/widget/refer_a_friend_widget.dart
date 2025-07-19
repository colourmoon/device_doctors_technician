import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/comman/common_text.dart';

import '../../../../../commons/common_button_widget.dart';
import '../../../help_and_support/raised_issues/screen/raised_issues_screen.dart';

class ReferAFriendWidget extends StatelessWidget {
  final String type;
  final String amount;
  const ReferAFriendWidget(
      {super.key, required this.type, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        height: type == "referal" ? 84 : 105,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppthemeColor().appMainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 16, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonProximaNovaTextWidget(
                    text: type == "referal"
                        ? "Earn up to ₹$amount for\nevery Referral"
                        : "All of your tickets are closed!",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  type == "referal"
                      ? const CommonProximaNovaTextWidget(
                          text: "T & C Apply",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.white,
                        )
                      : CommonButtonWidget(
                          buttonHeight: 27,
                          buttonwidth: 120,
                          fontsize: 12,
                          circular: 6,
                          buttontitle: "See your tickets",
                          titlecolor: AppthemeColor().appMainColor,
                          buttonColor: AppthemeColor().whiteColor,
                          boardercolor: AppthemeColor().whiteColor,
                          buttonOnTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const RaisedIssuesScreen(),
                                ));
                          },
                        ),
                ],
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 5, left: 8),
              child: Image.asset(type == "referal"
                  ? "assets/services_new/refer_and_earn.png"
                  : "assets/services_new/help.png"),
            ))
          ],
        ),
      ),
    );
  }
}
