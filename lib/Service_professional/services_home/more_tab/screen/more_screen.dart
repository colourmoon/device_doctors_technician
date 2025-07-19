import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/registration/registrationflow/profile_verification/cubit/profile_verfication_cubit.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/profile/logic/cubit/profile_cubit.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';

import '../../../registration/onboarding/sceeen/onboarding_screen.dart';
import '../../../registration/registrationflow/bank_details/screen/bank_details_screen.dart';
import '../../../registration/registrationflow/kyc_details/screens/kyc_screen.dart';
import '../../more_options/all_orders/screen/all_orders_screen.dart';
import '../../more_options/cod_cash/screen/cod_cash_screen.dart';
import '../../more_options/customer_tips/screen/customer_tips_screen.dart';
import '../../more_options/help_and_support/help_n_support/screen/help_and_support_screen.dart';
import '../../more_options/payout_history/screen/payout_history_screen.dart';
import '../../more_options/profile/screen/profile_screen.dart';
import '../../more_options/ratings/screen/ratings_screen.dart';
import '../../more_options/referals/refer_a_friend/screen/refer_a_friend_screen.dart';
import '../../more_options/referals/referal_earnings/screen/referal_earnings_screen.dart';
import '../../more_options/terms_and_conditions/screen/terms_and_conditions_screen.dart';
import '../logic/cubit/logout_cubit.dart';
import '../widget/more_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileVerficationCubit>().profileVerificationCheck();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileVerficationCubit, ProfileVerficationState>(
        builder: (context, state) {
          String Status = state.verificationModel?.vendorStatus ??'';
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  50.ph,
                  MoreProfileWidget(profilecubit: context.read<ProfileCubit>()),
                  15.ph,
                  if (Status == "1")
                    MoreRatingWidget(onTapFun: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const RatingScreen(),
                          ));
                    }),
                  if (Status == "1") 18.ph,
                  if (Status == "1")
                    Moreoptionswidget(
                        title: "All Orders",
                        subTitle: "Types of Orders",
                        onTapFun: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const AllOrdersScreen(),
                              ));
                        }),
                  Moreoptionswidget(
                      title: "My Profile",
                      subTitle: "Profile",
                      onTapFun: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ));
                      }),
                  if (Status == "1")
                    Moreoptionswidget(
                        title: "Customer Tips",
                        subTitle: "Tips",
                        onTapFun: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const CustomerTipsScreen(),
                              ));
                        }),
                  Moreoptionswidget(
                      title: "Kyc Details",
                      subTitle: "Details",
                      onTapFun: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const KycDetails(canSkip: false),
                            ));
                      }),

                  Moreoptionswidget(
                      title: "Bank Details",
                      subTitle: "Details",
                      onTapFun: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const BankDetailsScreen(canSkip: false),
                            ));
                      }),
                  if (Status == "1")
                    Moreoptionswidget(
                        title: "COD Cash",
                        subTitle: "Charges",
                        onTapFun: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const CodCashScreen(),
                              ));
                        }),
                  if (Status == "1")
                    Moreoptionswidget(
                        title: "Payout History",
                        subTitle: "Payments",
                        onTapFun: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const PayoutHistoryScreen(),
                              ));
                        }),
                  Moreoptionswidget(
                      title: "Refer a Friend",
                      subTitle: "Refering",
                      onTapFun: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const ReferalEarningsScreen(),
                            ));
                      }),
                  Moreoptionswidget(
                      title: "Help and Support",
                      subTitle: "Help",
                      onTapFun: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const HelpAndSupportScreen(),
                            ));
                      }),
                  Moreoptionswidget(
                      title: "Terms and Conditions",
                      subTitle: "All Terms and Regulations",
                      onTapFun: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => TermsAndConditionsScreen(
                                  title: "Terms And Conditions"),
                            ));
                      }),
                  Moreoptionswidget(
                      title: "Privacy Policy",
                      subTitle: "All Policies",
                      onTapFun: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => TermsAndConditionsScreen(
                                  title: 'Privacy Policy'),
                            ));
                      }),
                  Moreoptionswidget(
                      title: "Logout",
                      subTitle: "",
                      onTapFun: () {
                        _showAlertDialog(context);
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showAlertDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
              child: ListBody(
                children: <Widget>[
                  const SizedBox(
                    width: 264,
                    child: CommonProximaNovaTextWidget(
                      text: 'Are you sure you want to Logout from this Account',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  14.ph,
                  BlocConsumer<LogoutCubit, LogoutState>(
                    listener: (context, state) {
                      if (state is LogoutSuccess) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ServicesOnboardingScreen(),
                            ),
                            (route) => false);
                      }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is LogoutLoading) {
                        return Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppthemeColor().appMainColor,
                            ),
                          ),
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                width: 133,
                                height: 37,
                                decoration: ShapeDecoration(
                                  color: AppthemeColor().appMainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                ),
                                child: const CommonProximaNovaTextWidget(
                                  text: 'No, Continue',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          9.pw,
                          Expanded(
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                width: 123,
                                height: 37,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50,
                                        color: AppthemeColor().appMainColor),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: CommonProximaNovaTextWidget(
                                  text: 'Yes',
                                  color: AppthemeColor().appMainColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                context.read<LogoutCubit>().logoutapi();
                              },
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          actions: const <Widget>[],
        );
      },
    );
  }
}
