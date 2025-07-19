import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';

class MaintainanceModeScreen extends StatelessWidget {
  final String message, image;
  const MaintainanceModeScreen(
      {super.key, required this.message, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(image))),
          ),
          15.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
