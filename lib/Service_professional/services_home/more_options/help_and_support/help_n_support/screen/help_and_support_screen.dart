import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';

import '../../../referals/refer_a_friend/widget/refer_a_friend_widget.dart';
import '../../order_earnings_issue/screen/order_earnings_issue_screen.dart';
import '../../update_profile_details/screen/update_profile_details_screen.dart';
import '../widget/help_and_support_widget.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "Help and Support"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReferAFriendWidget(
            type: "nonsupport", amount: '',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: CommonProximaNovaTextWidget(
              text: "Raise a New Issue",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          15.ph,
          HelpNSupportOptionsWidget(
              title: "Order Earning issue",
              onTapfun: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const OrderearningsIssueScreen(
                        title: "Order Earning Issue",
                        type: 'order_issue',
                      ),
                    ));
              }),
          HelpNSupportOptionsWidget(
              title: "Payout Issues",
              onTapfun: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const OrderearningsIssueScreen(
                        title: "Incentives and Payout Issue",
                        type: 'payout_issue',
                      ),
                    ));
              }),
          HelpNSupportOptionsWidget(
              title: "COD Cash Issues",
              onTapfun: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const OrderearningsIssueScreen(
                        title: "COD Cash Issue",
                        type: 'cod_cash_issue',
                      ),
                    ));
              }),
          HelpNSupportOptionsWidget(
              title: "Update Personal Details",
              onTapfun: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => UpdateProfileDetailsScreen(),
                    ));
              }),
          HelpNSupportOptionsWidget(
              title: "Any Other issues",
              hideDivider: true,
              onTapfun: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => OrderearningsIssueScreen(
                        type: 'orher_issue',
                        title: "Other Issues",
                      ),
                    ));
              }),
        ],
      ),
    );
  }
}
