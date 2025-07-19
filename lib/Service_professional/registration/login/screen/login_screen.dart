import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_textformfield.dart';
import 'package:device_doctors_technician/comman/color_codes.dart';
import 'package:device_doctors_technician/comman/common_text.dart' as prefix;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../commons/common_button_widget.dart';
import '../../../commons/common_toast.dart';
import '../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../../registrationflow/registrationScreen/screen/register_screen.dart';
import '../../verification/screen/otp_verification_screen.dart';
import '../logic/cubit/login_cubit.dart';

class ServicesLoginScreen extends StatelessWidget {
  const ServicesLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 144,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/device_doctor.png",),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 18,)
,              CommonProximaNovaTextWidget(
                textAlign: TextAlign.center,
                text: "Login!",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppthemeColor().themecolor,
              ),
              5.ph,
              CommonProximaNovaTextWidget(
                textAlign: TextAlign.center,
                text: "Hi, Welcome Back to the Device Doctors",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppthemeColor().themecolor,
              ),
              15.ph,
              Form(
                key: formkey,
                child: CommonTextformfieldWidget(
                  fieldOntap: () {},
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.number,
                  controller: phoneNumberController,
                  formatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^0+'), //users can't type 0 at 1st position
                    ),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile Number is Empty';
                    } else if (value!.isNotEmpty && value!.length != 10) {
                      return 'Enter 10 digit valid mobile number';
                    }
                    return null;
                  },
                ),
              ),
              12.ph,
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => OtpVerificationScreen(
                              type: "login",
                              phnNumber: phoneNumberController.text),
                        ));
                  }
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return ClipRRect(

                        borderRadius: BorderRadius.circular(12),
                        child: const ThemeLoadingButton(height: 46,));
                  } else {
                    return CommonButtonWidget(
                      buttontitle: "Login",
                      titlecolor: AppthemeColor().whiteColor,
                      buttonColor: AppthemeColor().appMainColor,
                      boardercolor: AppthemeColor().appMainColor,
                      buttonOnTap: () {
                        if (formkey.currentState!.validate()) {
                          Map<String, dynamic> bodyData = {
                            "mobile": phoneNumberController.text
                          };
                          context.read<LoginCubit>().login(bodyData);
                        } else {
                          CommonToastwidget(
                            toastmessage: "Unable to login please try again",
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
