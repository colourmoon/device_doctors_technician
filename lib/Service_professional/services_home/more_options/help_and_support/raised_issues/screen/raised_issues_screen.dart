import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';

import '../../help_n_support/widget/help_and_support_widget.dart';
import '../../order_earnings_issues_list/screen/order_earnings_issues_list_screen.dart';

class RaisedIssuesScreen extends StatelessWidget {
  const RaisedIssuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "Raised Issues"),
      body: Column(
        children: [
          15.ph,
          HelpNSupportOptionsWidget(
              title: "Order Earning issue",
              onTapfun: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const OrderEarningsIssuesListScreen(
                        title: "Order Earning Issue",
                        type: 'order_issue',
                      ),
                    ));
              }),
          HelpNSupportOptionsWidget(
              title: "Incentives and Payout Issues",
              onTapfun: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const OrderEarningsIssuesListScreen(
                        title: "Incentives and Payout Issues",
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
                      builder: (BuildContext context) => OrderEarningsIssuesListScreen(
                        title: "COD Cash Issues",
                        type: 'cod_cash_issue',
                      ),
                    ));
              }),
          HelpNSupportOptionsWidget(
              title: "Any Other issues",
              onTapfun: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const OrderEarningsIssuesListScreen(
                        title: "Any Other issues",
                        type: 'orher_issue',
                      ),
                    ));
              }),
        ],
      ),
    );
  }
}
