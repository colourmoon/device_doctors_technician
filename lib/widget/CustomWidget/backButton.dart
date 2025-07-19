
import 'package:flutter/material.dart';

mixin BackBtn {
  static Widget backButton(context){
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(6)),
        height: 30,
        width: 30,
        child: const Icon(
          Icons.chevron_left,
          color: Colors.black,
        ),
      ),
    );
  }
}