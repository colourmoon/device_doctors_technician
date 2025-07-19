import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

class ServiceReviewsWidget extends StatelessWidget {
  final bool hasdivider;
  final String name, image, rating, review, reviewCount, date;
  const ServiceReviewsWidget(
      {super.key,
      this.hasdivider = true,
      required this.name,
      required this.image,
      required this.rating,
      required this.review,
      required this.reviewCount,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: NetworkImage(image),
              ),
              5.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonProximaNovaTextWidget(
                      text: name,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonProximaNovaTextWidget(
                          text: "${reviewCount} reviews written",
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff353535),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: CircleAvatar(
                            radius: 2,
                            backgroundColor: Color(0xff353535),
                          ),
                        ),
                        CommonProximaNovaTextWidget(
                          text: date,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff353535),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CommonProximaNovaTextWidget(
                text: "Rated: $rating/5",
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppthemeColor().ratingColor,
              ),
            ],
          ),
          2.ph,
          CommonProximaNovaTextWidget(
            text: review,
            // "a way to look at service quality or economics of the service from inside or outside IT",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff353535),
          ),
          10.ph,
          if (hasdivider)
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffE2E2E2),
            )
        ],
      ),
    );
  }
}
