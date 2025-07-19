import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

import '../../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../../service_details/widget/service_details_widget.dart';

class PayoutsDetailsWidget extends StatelessWidget {
  final String image,
      refId,
      amount,
      remarks,
      accno,
      bankName,
      branch,
      ifscCode,
      accountName;
  const PayoutsDetailsWidget(
      {super.key,
      required this.image,
      required this.refId,
      required this.amount,
      required this.remarks,
      required this.accno,
      required this.bankName,
      required this.branch,
      required this.ifscCode,
      required this.accountName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.ph,
        Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.payment,
                      size: 20,
                      color: Colors.black,
                    ),
                    3.pw,
                    const CommonProximaNovaTextWidget(
                      text: "Bill Details",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff494949),
                    )
                  ],
                ),
              ),
              5.ph,
              const BillDetailswidget(
                title: "Settlement Status",
                price: "Completed",
                isBold: true,
              ),
              5.ph,
              BillDetailswidget(
                title: "Settlement Ref Id",
                price: refId,
                isBold: true,
              ),
              5.ph,
              BillDetailswidget(
                title: "Settlement Remarks",
                price: "$remarks",
                isBold: true,
              ),
              5.ph,
              BillDetailswidget(
                title: "Settlement Amount",
                price: "$amount",
                isBold: true,
              ),
              5.ph,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CustomPaint(
                  painter: DottedLinePainter(),
                  child: const SizedBox(
                    width: double.infinity,
                    height: 1.0,
                  ),
                ),
              ),
              if (image != "")
                BillDetailswidget(
                  title: "Settlement Attachment",
                  price: "",
                  isBold: true,
                ),
              if (image != "")
                Container(
                  margin: EdgeInsets.all(8),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(image: NetworkImage(image))),
                ),
              10.ph
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_box_outlined,
                      size: 20,
                      color: Colors.black,
                    ),
                    3.pw,
                    const CommonProximaNovaTextWidget(
                      text: "Account Details",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff494949),
                    )
                  ],
                ),
              ),
              5.ph,
              BillDetailswidget(
                title: "Account Holder Name",
                price: "$accountName",
                isBold: true,
              ),
              5.ph,
              BillDetailswidget(
                title: "Account Number",
                price: "$accno",
                isBold: true,
              ),
              5.ph,
              BillDetailswidget(
                title: "Bank Name",
                price: "$bankName",
                isBold: true,
              ),
              5.ph,
              BillDetailswidget(
                title: "Branch",
                price: "$branch",
                isBold: true,
              ),
              5.ph,
              BillDetailswidget(
                title: "Ifsc Code",
                price: "$ifscCode",
                isBold: true,
              ),
              5.ph,
            ],
          ),
        ),
      ],
    );
  }
}
