import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_images.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../logic/cubit/cusomer_tips_cubit.dart';
import '../widget/cusomer_tips_widget.dart';

class CustomerTipsScreen extends StatelessWidget {
  const CustomerTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CusomerTipsCubit>().getTipsList();
    // final CusomerTipsCubit _tipsCubit =
    //     BlocProvider.of<CusomerTipsCubit>(context);
    // _tipsCubit.getTipsList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "Customer Tips"),
      body: BlocBuilder<CusomerTipsCubit, CusomerTipsState>(
        builder: (context, state) {
          if (state.dataLoaded == true) {
            return const ThemeSpinner();
          } else if (state.payoutError.isNotEmpty) {
            return Center(
              child: Text(state.payoutError.toString()),
            );
          }
          return SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TipsDetailsWidget(
                  totalTipsAmount: "${state.totalAmount}",

                ),
                state.tipsList!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonImages().noTipsImage,
                            CommonProximaNovaTextWidget(
                              text: "No Tips Yet!",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.tipsList!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => TipsListWidget(
                            hideDivider: index == state.tipsList!.length - 1
                                ? true
                                : false,
                            name: state.tipsList![index].customerName,
                            orderId: state.tipsList![index].sessionId,
                            date: state.tipsList![index].createdAt,
                            amount: state.tipsList![index].tip),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
