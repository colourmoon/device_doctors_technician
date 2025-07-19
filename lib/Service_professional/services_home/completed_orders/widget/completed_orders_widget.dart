import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_textformfield.dart';

class CompletedServiceWidget extends StatelessWidget {
  final String name, date, rating, review, image;
  const CompletedServiceWidget(
      {super.key,
      required this.name,
      required this.date,
      required this.rating,
      required this.review,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(image),
                backgroundColor: Colors.grey.shade200,
              ),
              5.pw,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonProximaNovaTextWidget(
                    text: name,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff3A3A3A),
                  ),
                  CommonProximaNovaTextWidget(
                    text: "Service completed on $date",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff3A3A3A),
                  )
                ],
              ),
            ],
          ),
          5.ph,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.star_rounded,
                size: 15,
                color: Color(0xffF29D00),
              ),
              2.pw,
              CommonProximaNovaTextWidget(
                text: rating,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff3A3A3A),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 13,
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: CommonProximaNovaTextWidget(
                  text: review,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff3A3A3A),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DateFiltersWidget extends StatelessWidget {
  final TextEditingController fromcontroller;
  final TextEditingController tocontroller;
  final VoidCallback fromDateOnTap, toDateOnTap;

  const DateFiltersWidget(
      {super.key,
      required this.fromcontroller,
      required this.tocontroller,
      required this.fromDateOnTap,
      required this.toDateOnTap});

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
                  text: "From Date",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                3.ph,
                SizedBox(
                  height: 43,
                  child: CommonTextformfieldWidget(
                      readonly: true,
                      suffixiconWidget: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/services_new/calenderpicker.svg",
                          height: 10,
                          width: 10,
                        ),
                      ),
                      validator: (val) {},
                      controller: fromcontroller,
                      fieldOntap: fromDateOnTap,
                      formatters: [],
                      hintText: ""),
                ),
              ],
            ),
          ),
          10.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonProximaNovaTextWidget(
                  text: "To Date",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                3.ph,
                SizedBox(
                  height: 43,
                  child: CommonTextformfieldWidget(
                      validator: (val) {},
                      readonly: true,
                      suffixiconWidget: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/services_new/calenderpicker.svg",
                          height: 10,
                          width: 10,
                        ),
                      ),
                      controller: tocontroller,
                      fieldOntap: toDateOnTap,
                      formatters: [],
                      hintText: ""),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
