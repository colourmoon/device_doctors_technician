import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/payout_history/widget/payout_details_widget.dart';
import 'package:device_doctors_technician/widget/CustomWidget/Demo.dart';

import '../../../../services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import '../../../new_orders/widget/new_order_widget.dart';
import '../../../service_details/widget/service_details_widget.dart';
import '../cubit/cubit/payout_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayoutDetailsScreen extends StatefulWidget {
  final String orderId;
  const PayoutDetailsScreen({super.key, required this.orderId});

  @override
  State<PayoutDetailsScreen> createState() => _PayoutDetailsScreenState();
}

class _PayoutDetailsScreenState extends State<PayoutDetailsScreen> {
  @override
  void initState() {
    context.read<PayoutDetailsCubit>().fetchDetails(orderId: widget.orderId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayoutDetailsCubit, PayoutDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PayoutDetailsLoading) {
          return Scaffold(
              appBar: commonAppBarWidget(
                  leadingArrowOnTap: () {
                    Navigator.pop(context);
                  },
                  title: "Order Review"),
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => OrdersLoadingWidget()),
              ));
        }
        if (state is PayoutDetailsFetched) {
          return Scaffold(
            backgroundColor: Color(0xffF1F0F5),
            resizeToAvoidBottomInset: true,
            appBar: commonAppBarWidget(
                leadingArrowOnTap: () {
                  Navigator.pop(context);
                },
                title: "Service Details"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: PayoutsDetailsWidget(
                          image: state.payoutDetails.settlementAttachment,
                          refId: state.payoutDetails.settlementRefId,
                          amount: state.payoutDetails.settledAmount,
                          remarks: state.payoutDetails.settlementRemarks,
                          accno: state.payoutDetails.accountNumber,
                          bankName: state.payoutDetails.bankName,
                          branch: state.payoutDetails.bankName,
                          ifscCode: state.payoutDetails.ifscCode,
                          accountName: state.payoutDetails.accountName)),
                  5.ph,
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar:
              commonAppBarWidget(leadingArrowOnTap: () {}, title: "Order view"),
        );
      },
    );
  }
}
