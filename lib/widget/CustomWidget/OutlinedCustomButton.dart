import 'package:flutter/material.dart';

class OutlinedCustomButton extends StatelessWidget {
  OutlinedCustomButton(
      {super.key,
      required this.child,
      this.icon,
      required this.onPressed,
      this.color,
      this.size});
  String? child;
  ImageProvider? icon;
  VoidCallback onPressed;
  Color? color;
  double? size;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
          width: 71,
          height: 26.06,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.25, color: Color(0xFFAEAEAE)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                child!,
                style: TextStyle(
                    color: color ?? Color(0xffaeaeae),
                    fontWeight: FontWeight.w400,
                    fontSize: 10),
              ),
              icon != null
                  ? SizedBox(
                      width: 8,
                    )
                  : Container(),
              icon != null
                  ? ImageIcon(
                      icon,
                      color: Color(0xffaeaeae),
                      size: size,
                    )
                  : Container(),
            ],
          )),
    );
  }
}
