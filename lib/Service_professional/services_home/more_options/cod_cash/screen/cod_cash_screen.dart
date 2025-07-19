import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';

import '../../../../../comman/common_text.dart';
import '../../../../commons/common_images.dart';
import '../../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../../customer_tips/widget/cusomer_tips_widget.dart';
import '../logic/cubit/cod_cash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodCashScreen extends StatelessWidget {
  const CodCashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CodCashCubit _codCashCubit = BlocProvider.of<CodCashCubit>(context);
    _codCashCubit.getCodCashList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "COD Cash"),
      body: BlocBuilder<CodCashCubit, CodCashState>(
        builder: (context, state) {
          if (state.dataLoaded == true) {
            return ThemeSpinner();
          } else if (state.payoutError.isNotEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CommonImages().noCODImage,
                  const CommonProximaNovaTextWidget(
                    text: "No Cod Orders yet!",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TipsDetailsWidget(
                  limitPrice: state.limit ?? "0",
                  totalTipsAmount: "${state.currentBalance}",
                  isCodcash: true,
                ),
                ListView.builder(
                  itemCount: state.codCashList!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => TipsListWidget(
                      hideDivider: index == 4 ? true : false,
                      amount: state.codCashList![index].price,
                      date: state.codCashList![index].createdAt,
                      name: "${state.codCashList![index].customerName}",
                      orderId: "${state.codCashList![index].id}"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
