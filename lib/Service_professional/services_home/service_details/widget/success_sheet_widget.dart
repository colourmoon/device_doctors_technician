import 'package:device_doctors_technician/Service_professional/services_home/service_details/widget/service_details_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../comman/common_text.dart';
import '../screen/service_details_screen.dart';

class SuccessSheetWidget extends StatelessWidget {
  final VoidCallback onSwipeComplete;

  const SuccessSheetWidget({
    Key? key,
    required this.onSwipeComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
        bottom: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.string(
            pinToStart,
            height: 107,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
            child: CommonProximaNovaTextWidget(
              text:
              "Tell the Customer to complete the payment so that the service can be marked as completed.",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          SwipeButtons(
            onButtonDragged: onSwipeComplete,
            buttontitle: "RECEIVED PAYMENT & MARK COMPLETE",
            fontSize: 10,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
