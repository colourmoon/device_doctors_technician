import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/help_and_support/logic/cubit/help_and_support_cubit.dart';

import '../../../../../commons/common_images.dart';
import '../../../../../commons/common_text_widget.dart';
import '../widget/order_earnings_issues_list_widget.dart';

class OrderEarningsIssuesListScreen extends StatefulWidget {
  final String title, type;
  const OrderEarningsIssuesListScreen(
      {super.key, required this.title, required this.type});

  @override
  State<OrderEarningsIssuesListScreen> createState() =>
      _OrderEarningsIssuesListScreenState();
}

class _OrderEarningsIssuesListScreenState
    extends State<OrderEarningsIssuesListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<HelpAndSupportCubit>().fetchRaisedIssue(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: widget.title),
      body: BlocBuilder<HelpAndSupportCubit, HelpAndSupportState>(
        builder: (context, helpState) {
          if (helpState.dataLoaded == true) {
            return const ThemeSpinner();
          } else if (helpState.helpSupportError.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: CommonImages().noIssuesImage),
                15.ph,
                const CommonProximaNovaTextWidget(
                  text: "No Issues Yet!",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: helpState.helpSupportList!.data.length,
              itemBuilder: (context, index) => OrderEarningsIssuewidget(
                  helpData: helpState.helpSupportList!.data[index]),
            );
          }
        },
      ),
    );
  }
}
