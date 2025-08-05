import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
import '../../../services_home/more_options/terms_and_conditions/screen/terms_and_conditions_screen.dart';
import '../../registrationflow/registrationScreen/screen/register_screen.dart';
import '../../verification/screen/otp_verification_screen.dart';
import '../logic/cubit/login_cubit.dart';

class ServicesLoginScreen extends StatefulWidget {
  const ServicesLoginScreen({super.key});

  @override
  State<ServicesLoginScreen> createState() => _ServicesLoginScreenState();
}

class _ServicesLoginScreenState extends State<ServicesLoginScreen> {
  bool _acceptTerms = false;

  final formkey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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

              Row(
                children: [
                  Checkbox(
                    fillColor: WidgetStateProperty.all(
                      const Color(0xFFD3DBE8),
                    ), // checkbox fill color
                    checkColor: Colors.white, // tick/check color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(6), // border radius
                    ),
                    value:
                    _acceptTerms, // _acceptTerms is a boolean variable to track the state of the checkbox
                    onChanged: (bool? value) {
                      if (mounted) {
                        setState(() {
                          _acceptTerms = value ??
                              false; // Update the state when the checkbox value changes
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40, top: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'While Login I accept all ',
                              style: TextStyle(
                                color: const Color(0xFF222534),
                                fontSize: 12,
                                fontFamily: 'ProximaNova',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: const TextStyle(
                                color: Color(0xFF222534),
                                fontSize: 12,
                                fontFamily: 'ProximaNova',
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => TermsAndConditionsScreen(
                                            title: "Terms And Conditions"),
                                      ));
                                },
                            ),
                            const TextSpan(
                              text: ' ',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                          if (_acceptTerms == true) {
                            Map<String, dynamic> bodyData = {
                              "mobile": phoneNumberController.text
                            };
                            context.read<LoginCubit>().login(bodyData);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Accept Terms & Conditions",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }

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
