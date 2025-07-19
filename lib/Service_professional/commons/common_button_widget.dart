import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:device_doctors_technician/comman/common_text.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonButtonWidget extends StatelessWidget {
  final String buttontitle;
  final Color titlecolor, buttonColor, boardercolor;
  final double buttonwidth, buttonHeight, fontsize;
  final VoidCallback buttonOnTap;
  final double circular;
  const CommonButtonWidget(
      {super.key,
      required this.buttontitle,
      required this.titlecolor,
      required this.buttonColor,
      required this.boardercolor,
        this.circular = 12,
      this.buttonwidth = double.infinity,
      required this.buttonOnTap,
      this.buttonHeight = 46,
      this.fontsize = 14});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonwidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: titlecolor,
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circular),
                side: BorderSide(color: boardercolor, width: 0.3))),
        onPressed: buttonOnTap,
        child: CommonProximaNovaTextWidget(
          text: buttontitle,
          fontSize: fontsize,
          fontWeight: FontWeight.w600,
          color: titlecolor,
        ),
      ),
    );
  }
}

//  CommonButtonWidget(
//                       buttontitle: "I’m New, Register Now",
//                       titlecolor: AppthemeColor().whiteColor,
//                       buttonColor: AppthemeColor().themecolor,
//                       boardercolor: AppthemeColor().themecolor
// buttonOnTap: () {  },
// ),

class callORNavigationButtons {
  Future<void> makePhoneCall(String phoneNumber) async {
    print("phoneNumber $phoneNumber");
    phoneNumber = phoneNumber.replaceAll(" ", "");

    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    await launchUrl(launchUri);
  }

  Future<void> openMap(String latitude, String longitude) async {
    // String iosUrl = 'https://maps.apple.com/?q=$latitude,$longitude';
// if (GetPlatform.isAndroid) {

// }else{
//   if (await canLaunch(iosUrl)) {
//     await launch(iosUrl);
//   } else {
//     throw 'Could not open the map.';
//   }
// }

    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    print("google map launcher url: ${googleUrl}");
    await launch(googleUrl);
  }
}
