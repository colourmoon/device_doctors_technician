import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/help_support_model.dart';
import 'package:device_doctors_technician/utility/network_image_widget.dart';

class OrderEarningsIssuewidget extends StatelessWidget {
  final HelpSupportList helpData;
  const OrderEarningsIssuewidget({super.key, required this.helpData});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 15),
    width: double.infinity,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: const BorderSide(
    width: 1,
    color: Color(0xFFD3DBE8),
    ),
    borderRadius: BorderRadius.circular(12),
    ),
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonProximaNovaTextWidget(
            text: "Order Id: ${helpData.orderId}",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
          5.ph,
          const CommonProximaNovaTextWidget(
            text: "Description:",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xff3A3A3A),
          ),
          5.ph,
          CommonProximaNovaTextWidget(
            text: helpData.issue,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.black,
          ),
          5.ph,
          const CommonProximaNovaTextWidget(
            text: "Attachments:",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xff3A3A3A),
          ),
          5.ph,
          Container(
            // padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 4,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: NetworkImageWidget(
                image: helpData.image,
                width: 150,
                height: 75,
                fit: BoxFit.fill,
              ),
            ),
          ),
          18.ph,
        ],
      ),
    );
  }
}
