import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

import '../../../../comman/color_codes.dart';
import '../../../commons/common_button_widget.dart';
import '../../login/screen/login_screen.dart';
import '../../registrationflow/registrationScreen/screen/register_screen.dart';

class ServicesOnboardingScreen extends StatelessWidget {
  const ServicesOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppthemeColor().appMainColor,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration:   BoxDecoration(
          color:  AppthemeColor().appMainColor,
          image: const DecorationImage(
              image: AssetImage(
                "assets/services_new/onboarding.png",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 52),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CommonProximaNovaTextWidget(
                    text: "Best Deals Near You!",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  5.ph,
                  const CommonProximaNovaTextWidget(
                      text:
                          "Seamless Bookings at your Fingertips\nYour Journey, Your Way",
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  10.ph,
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonButtonWidget(
                          buttonOnTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const ServicesRegistrationScreen(),
                                ));
                          },
                          buttontitle: " I’M NEW, REGISTER NOW",
                          titlecolor: AppthemeColor().appMainColor,
                          buttonColor: AppthemeColor().whiteColor,
                          boardercolor: AppthemeColor().whiteColor),
                      10.ph,
                      CommonButtonWidget(
                          buttonOnTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const ServicesLoginScreen(),
                                ));
                          },
                          buttontitle: "LOGIN NOW",
                          titlecolor: AppthemeColor().whiteColor,
                          buttonColor:AppthemeColor().appMainColor,
                          boardercolor: AppthemeColor().whiteColor),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
