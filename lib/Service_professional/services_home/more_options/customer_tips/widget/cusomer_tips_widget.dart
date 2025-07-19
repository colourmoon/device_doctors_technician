import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

import '../../../../../widget/CustomWidget/DottedLinePainter.dart';

class TipsDetailsWidget extends StatelessWidget {
  final String totalTipsAmount, limitPrice;
  final bool isCodcash;
  const TipsDetailsWidget(
      {super.key,
      required this.totalTipsAmount,
      this.isCodcash = false,
      this.limitPrice = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        15.ph,
        Center(
          child: Image.asset(
            isCodcash
                ? "assets/services_new/codcash.png"
                : "assets/services_new/CustomerTips.png",
            height: 90,
            width: 90,
          ),
        ),
        10.ph,
        CommonProximaNovaTextWidget(
          text: "₹$totalTipsAmount",
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        0.ph,
        CommonProximaNovaTextWidget(
          text: isCodcash ? "Current Balance" : "Total Tip Recieved",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        if (isCodcash) 5.ph,
        if (isCodcash)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Limit:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: 'ProximaNova',
                  ),
                ),
                TextSpan(
                  text: '₹$limitPrice',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'ProximaNova',
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: CustomPaint(
            painter: DottedLinePainter(),
            child: const SizedBox(
              width: double.infinity,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}

class TipsListWidget extends StatelessWidget {
  final bool hideDivider;
  final String name, orderId, date, amount;
  const TipsListWidget(
      {super.key,
      required this.hideDivider,
      required this.name,
      required this.orderId,
      required this.date,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    child: CommonProximaNovaTextWidget(
                        text: "ID:#$orderId,$name",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        maxLines: 2),
                  ),
                  CommonProximaNovaTextWidget(
                    text: "${date}",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ],
              ),
              CommonProximaNovaTextWidget(
                text: "+ ₹${amount}",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ],
          ),
          10.ph,
          Container(
            height: 1,
            color: Color(0xffE2E2E2),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
