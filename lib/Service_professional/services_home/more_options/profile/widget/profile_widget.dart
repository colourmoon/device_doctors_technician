import 'package:dotted_line_flutter/dotted_line_flutter.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

class RiderDetailWidget extends StatelessWidget {
  final String title, description;
  final bool hideDivider;
  const RiderDetailWidget(
      {super.key,
      required this.title,
      required this.description,
      this.hideDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CommonProximaNovaTextWidget(
              //   text: title,
              //   fontSize: 12,
              //   fontWeight: FontWeight.w600,
              //   color: Color(0xff565656),
              // ),
              Expanded(
                child: CommonProximaNovaTextWidget(
                  text: "$title $description",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff565656),
                ),
              ),
            ],
          ),
        ),
        hideDivider
            ? dottedLine
            : const SizedBox.shrink(),
      ],
    );
  }
}

class ProfileDetailWidget extends StatelessWidget {
  final String title, description;
  final bool hideDivider;
  const ProfileDetailWidget(
      {super.key,
      required this.title,
      required this.description,
      this.hideDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonProximaNovaTextWidget(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff565656),
              ),
              CommonProximaNovaTextWidget(
                text: description,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xff565656),
              ),
            ],
          ),
        ),
        hideDivider ? dottedLine : const SizedBox.shrink(),
      ],
    );
  }
}

const dottedLine = DottedLine(
  axis: Axis.horizontal,
  lineThickness: 1,
  dashGap: 2,
  dashWidth: 2,
  shadowColor: Colors.transparent,
  colors: [Color(0xffC3CFDA)], // Gradient Support
);
