import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';

class ServicesWidget extends StatelessWidget {
  final String title;
  final bool isSelected, isItemLoading;

  final VoidCallback onTapFun;
  const   ServicesWidget(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTapFun,
      required this.isItemLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,

        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: const Color(0xFFEDF0FF),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: CommonProximaNovaTextWidget(
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            isItemLoading == true
                ? const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Center(
                      child: ThemeSpinner(
                        size: 21,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: onTapFun,
                    child: Container(
                      height: 21,
                      width: 41,
                      decoration: BoxDecoration(
                          color: isSelected
                              ? AppthemeColor().greenButtonColor
                              : Color(0xffC9CAC8),
                          borderRadius: BorderRadius.circular(20)),
                      child: Align(
                        alignment: isSelected
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            radius: 9,
                            backgroundColor: Colors.white,
                          ),
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
