// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utility/auth_shared_pref.dart';
import '../commons/color_codes.dart';
import '../internet_handler/logic/internet/internet_cubit.dart';
import '../internet_handler/screen/no_internet_screen.dart';
import '../registration/onboarding/sceeen/onboarding_screen.dart';
import '../registration/splash/maintainenceMode/logic/bloc/maintainence_mode_bloc.dart';
import '../registration/splash/maintainenceMode/repository/maintainance_repo.dart';
import '../services_bottombar/screen/services_bottombar_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    Key? key,
  }) : super(key: key);

  // static const routeName = '/base_screen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetState>(
      listener: (context, internetState) {
        if (internetState is InternetConnected ||
            Constants.prefs?.getBool("Verificationloading") == true ||Constants.prefs?.getBool("Verificationloading") == null) {
          Constants.prefs?.setBool("Verificationloading", false);
          context.read<MaintainenceModeBloc>().add(const VersionCheckEvent());
        }
        // TODO: implement listener
      },
      builder: (context, internetState) {
        print("checking intenet state in base screen :${internetState}");

        if (internetState is InternetConnected) {
          print("000000000000000000000000000000");
          return BlocConsumer<MaintainenceModeBloc, MaintainenceModeState>(
            listener: (context, state) {
              // if (state is VersionCheckSkipState) {

              // }
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is VersionCheckState) {
                print("1111111111111111111111111111111111");
                if (state.versionCheckRes.errCode == "invalid") {

                  print("222222222222222222222222222222222");
                  Future.delayed(Duration.zero, () {
                    versionControl(
                      context,
                      state.versionCheckRes.message,
                      state.versionCheckRes.userAndroidAppLink,
                      state.versionCheckRes.forceUpdate != "no" ? false : true,
                    );
                  });
                } else {

                  print("33333333333333333333333333333333333");
                  if (Constants.prefs?.getString("provider_access_token") !=
                      null) {

                    print("44444444444444444444444444444");
                    return const ServicesBottomBarScreen(initialIndex: 0);
                  } else {

                    print("555555555555555555555555555555555555");
                    return const ServicesOnboardingScreen();
                  }
                }
              } else if (state is VersionCheckSkipState) {
                if (Constants.prefs?.getString("provider_access_token") !=
                    null) {

                  print("66666666666666666666666666666666");
                  return const ServicesBottomBarScreen(initialIndex: 0);
                } else {
                  print("77777777777777777777777777777777");
                  return const ServicesOnboardingScreen();
                }
              }
              print("88888888888888888888888888888888888");
              return Scaffold(
                backgroundColor: AppthemeColor().appMainColor,
                body:   Center(
                  child: CircularProgressIndicator(color:
                   AppthemeColor().whiteColor,),
                ),
              );
            },
          );
        } else if (internetState is InternetDisconnected) {
          print("disconnected");
          return const NoInternetScreen();
        } else {
          return const CircularProgressIndicator();
        }
        // return Scaffold(body: Container());
      },
    );
  }

  CheckLogin(context) {
    if (Constants.prefs?.getString("provider_access_token") != null) {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => const ServicesBottomBarScreen(initialIndex: 0),
        ),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (context) => const ServicesOnboardingScreen()),
        (route) => false,
      );
    }
  }

  versionControl(context, titel, url, bool canSkip) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "User app version is outdated. please update",
                    "New Version Available!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: AppthemeColor().themeFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     'assets/FoodRestaurant/logo.png',
                  //     height: 120,
                  //     width: 120,
                  //   ),
                  // ),
                  10.ph,
                  Text(
                    // "User app version is outdated. please update",
                    titel,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppthemeColor().themeFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      canSkip == true
                          ? Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.grey,
                                    minimumSize: const Size(90, 35),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                    context
                                        .read<MaintainenceModeBloc>()
                                        .add(const VersionSkipEvent());

                                    // CheckLogin(context);
                                    // print(url);
                                    // _launched = _launchInBrowser(Uri.parse(url));
                                  },
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: AppthemeColor().themeFont,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            )
                          : const SizedBox.shrink(),
                      TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor: AppthemeColor().themecolor,
                            minimumSize: const Size(90, 35),
                          ),
                          onPressed: () async {
                            print('launched url:${url}');
                            _launched = _launchInBrowser(Uri.parse(url));
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: AppthemeColor().themeFont,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

Future<void>? _launched;
Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

@override
List<Object?> get props => [_launched];
