import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';

class CommonTextformfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String hintText;
  Widget? suffixiconWidget;
  final VoidCallback fieldOntap;
  final bool readonly;
  final int? maxLines,maxLength;
  final TextCapitalization textcap;
  final List<TextInputFormatter> formatters;

  CommonTextformfieldWidget(
      {super.key,
      required this.controller,
      required this.fieldOntap,
      this.readonly = false,
      this.textcap = TextCapitalization.none,
      required this.validator,
      required this.formatters,
      this.keyboardType,
      this.maxLines,
      this.maxLength,
      this.suffixiconWidget,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textcap,
      textAlign: TextAlign.start,
      readOnly: readonly,
      onTap: fieldOntap,
      cursorColor: AppthemeColor().themecolor,
      inputFormatters: formatters,
      //  [
      //   LengthLimitingTextInputFormatter(10),
      //   FilteringTextInputFormatter.allow(
      //     RegExp(r'[0-9]'),
      //   ),
      //   FilteringTextInputFormatter.deny(
      //     RegExp(r'^0+'), //users can't type 0 at 1st position
      //   ),
      // ],
      // readOnly: state.loginLoading ? true : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: const TextStyle(
        color: Color(0xFF000000),
        fontSize: 12,
        fontFamily: 'ProximaNova',
        fontWeight: FontWeight.w500,
      ),
      // maxLength: 10,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        suffixIcon: suffixiconWidget,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF222534),
          fontSize: 12,
          fontFamily: 'ProximaNova',
          fontWeight: FontWeight.w500,
        ),
        // prefixIcon: const Padding(
        //   padding: EdgeInsets.all(16),
        //   child: ImageIcon(
        //     AssetImage('assets/FoodRestaurant/user2342.png'),
        //     size: 10,
        //   ),
        // ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFFC1C1C1),
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFFC1C1C1),
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFFC1C1C1),
            )),
      ),
      validator: validator,
    );
  }
}


// CommonTextformfieldWidget(
//                 hintText: 'Phone Number',
//                 keyboardType: TextInputType.number,
//                 controller: phoneNumberController,
//                 formatters: [
//                   LengthLimitingTextInputFormatter(10),
//                   FilteringTextInputFormatter.allow(
//                     RegExp(r'[0-9]'),
//                   ),
//                   FilteringTextInputFormatter.deny(
//                     RegExp(r'^0+'), //users can't type 0 at 1st position
//                   ),
//                 ],
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Mobile Number is Empty';
//                   } else if (value!.isNotEmpty && value!.length != 10) {
//                     return 'Enter 10 digit valid mobile number';
//                   }
//                   return null;
//                 },
//               )