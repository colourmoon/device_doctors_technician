import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

import '../../../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../../../../commons/common_textformfield.dart';

class HelpNSupportOptionsWidget extends StatelessWidget {
  final String title;
  final bool hideDivider;
  final VoidCallback onTapfun;
  const HelpNSupportOptionsWidget(
      {super.key,
      required this.title,
      this.hideDivider = false,
      required this.onTapfun});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: InkWell(
        onTap: onTapfun,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CommonProximaNovaTextWidget(
                    text: title,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xff3A3A3A),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xff3A3A3A),
                )
              ],
            ),
            if (hideDivider == false)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CustomPaint(
                  painter: DottedLinePainter(),
                  child: const SizedBox(
                    width: double.infinity,
                    height: 1.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class IssuesWidget extends StatelessWidget {
  final TextEditingController descriptionController, orderIdController;
  final String type;
  const IssuesWidget(
      {super.key,
      required this.descriptionController,
      required this.orderIdController,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextformfieldWidget(
          fieldOntap: () {},
          hintText: 'Describe the Issue',
          keyboardType: TextInputType.text,
          controller: descriptionController,
          formatters: [],
          validator: (value) {
            if (value!.isEmpty) {
              return 'Issue is Empty';
            }
            return null;
          },
        ),
        if (type != "orher_issue") 15.ph,
        if (type != "orher_issue")
          CommonTextformfieldWidget(
            fieldOntap: () {},
            hintText: type == "order_issue" ? 'Order ID' : "Transaction ID",
            keyboardType: TextInputType.phone,
            controller: orderIdController,
            formatters: [],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Order ID is Empty';
              }
              return null;
            },
          ),
      ],
    );
  }
}
