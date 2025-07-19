import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/payout_history/model/payouts_model.dart';

class PaymentHistoryWidget extends StatelessWidget {
  final OrderData payoutData;
  final VoidCallback onTapFun;
  const PaymentHistoryWidget(
      {super.key, required this.payoutData, required this.onTapFun});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFun,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFEDF0FF),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonProximaNovaTextWidget(
                  text: "Ref ID - #${payoutData.sessionId}",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                CommonProximaNovaTextWidget(
                  text: "${payoutData.status} - ${payoutData.createdAt}",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ],
            ),
            CommonProximaNovaTextWidget(
              text: "₹${payoutData.earnings}",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
