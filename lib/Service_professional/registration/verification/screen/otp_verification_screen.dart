import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/registration/verification/logic/cubit/otp_verification_cubit.dart';
import 'package:device_doctors_technician/Service_professional/registration/verification/logic/cubit/otp_verification_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../commons/color_codes.dart';
import '../../../commons/common_button_widget.dart';
import '../../../services_bottombar/screen/services_bottombar_screen.dart';
import '../../../update_push_token_cubit/cubit/update_push_token_cubit.dart';
import '../../registrationflow/upload_photo/screen/apload_photo_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phnNumber, type;
  const OtpVerificationScreen(
      {super.key, required this.phnNumber, required this.type});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _key = GlobalKey<FormState>();
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
    super.initState();
  }

  @override
  void dispose() {
    _controllers.clear();
    // password.clear();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _submitOtp();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _controllers.length - 1) {
        _focusNodes[index].unfocus();
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _submitOtp();
      }
    } else {
      if (index > 0) {
        _focusNodes[index].unfocus();
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  String _submitOtp() {
    String otp =
        _controllers.fold('', (otp, controller) => otp + controller.text);
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BackButtonIcon(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 144,
                      height: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/device_doctor.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              CommonProximaNovaTextWidget(
                textAlign: TextAlign.center,
                text: "Verification!",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppthemeColor().themecolor,
              ),
              5.ph,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'We have sent you a OTP to your Registered\nMobile Number +91 ${widget.phnNumber}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF676767),
                        fontFamily: 'ProximaNova',
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              18.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      width: 48,
                      height: 74,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(
                              '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                        ],
                        controller: _controllers[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        obscureText: false,
                        onChanged: (value) => _onOtpChanged(value, index),
                        decoration: InputDecoration(
                          counterStyle: const TextStyle(color: Colors.red),
                          counterText: '',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 22),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        validator: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Please enter mobile number';
                          // } else if (value.length < 4) {
                          //   return 'Please enter valid mobile number';
                          // }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              10.ph,
              BlocListener<OtpVerificationCubit, OtpVerificationState>(
                listener: (context, state) {
                  if (state is OtpVerified) {
                    context
                        .read<UpdatePushTokenCubit>()
                        .updatePushNotificationToken();

                    if (widget.type == "login") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const ServicesBottomBarScreen(
                                  initialIndex: 0,
                                )),
                        (route) => false,
                      );
                    } else {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const ProfileImageScreen()));
                    }
                  }
                  // TODO: implement listener
                },
                child: BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
                  builder: (context, state) {
                    if (state is OtpLoading) {
                      return const Center(
                        child: ThemeSpinner(),
                      );
                    }
                    return CommonButtonWidget(
                      buttontitle: "CONTINUE",
                      titlecolor: AppthemeColor().whiteColor,
                      buttonColor: AppthemeColor().appMainColor,
                      boardercolor: AppthemeColor().appMainColor,
                      buttonOnTap: () {
                        String otp = _controllers.fold(
                            '', (otp, controller) => otp + controller.text);
                        if (otp.length == 4) {
                          Map<String, dynamic> bodyData = {
                            "mobile": widget.phnNumber,
                            "otp": otp
                          };
                          context
                              .read<OtpVerificationCubit>()
                              .verifyOtp(bodyData);
                        } else {
                          CommonToastwidget(
                              toastmessage: "Please Enter 4 digit otp");
                        }
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
                builder: (context, state) {
                  if (state is OtpResendTimer) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Resend OTP in ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1C1C1C),
                                fontFamily: 'ProximaNova',
                              ),
                            ),
                            TextSpan(
                              text: '00:${state.secondsRemaining}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1C1C1C),
                                fontFamily: 'ProximaNova',
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (state is OtpLoading) {
                    return const SizedBox.shrink();
                  } else if (state is OtpResend) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<OtpVerificationCubit>()
                              .resendOtp(widget.phnNumber);
                        },
                        child: CommonProximaNovaTextWidget(
                          textAlign: TextAlign.center,
                          text: "Resend OTP",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppthemeColor().themecolor,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
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

class BackButtonIcon extends StatelessWidget {
  const BackButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SvgPicture.asset('assets/images/back_button.svg'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
