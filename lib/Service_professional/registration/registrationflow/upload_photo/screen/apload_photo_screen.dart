// import 'dart:io';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/registration/registrationflow/kyc_details/screens/kyc_screen.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';

import '../../../../commons/common_text_widget.dart';
import '../../../../services_bottombar/screen/services_bottombar_screen.dart';
import '../../../../services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import '../../../../services_home/more_options/help_and_support/logic/cubit/image_upload_cubit.dart';
import '../../../../services_home/more_options/help_and_support/logic/cubit/image_upload_state.dart';
import '../../bank_details/screen/bank_details_screen.dart';
import '../logic/cubit/upload_profile_photo_cubit.dart';

class ProfileImageScreen extends StatefulWidget {
  const ProfileImageScreen({
    super.key,
  });

  @override
  State<ProfileImageScreen> createState() => _ProfileImageScreenState();
}

class _ProfileImageScreenState extends State<ProfileImageScreen> {
  late ImageUploadCubit imagecubit;
  late UploadProfilePhotoCubit uploadimagecubit;

  @override
  void initState() {
    imagecubit = ImageUploadCubit();
    uploadimagecubit = UploadProfilePhotoCubit();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => imagecubit,
        ),
        BlocProvider(
          create: (context) => uploadimagecubit,
        ),
      ],
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: commonAppBarWidget(
            leadingArrowOnTap: () {
              Navigator.pop(context);
            },
            title: "Upload Photo",
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ServicesBottomBarScreen(
                        initialIndex: 0,
                      ),
                    ),
                        (route) => false,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 15),
                  child: CommonProximaNovaTextWidget(
                    text: "Skip",
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          body: BlocBuilder<ImageUploadCubit, ImageUploadStateBase>(
            builder: (context, state) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  state is ImageUploadSuccess
                      ? Column(
                          children: [
                            state is ImageUploadSuccess
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        FileImage(state.image, scale: 0.2),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Color(0xffF1F0F5),
                                    radius: 60,
                                    child: Icon(
                                      Icons.person,
                                      size: 70,
                                      color: Color(0xff958E8E),
                                    )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Your Photo has been uploaded \n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: AppthemeColor().themeFont,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Successfully!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: AppthemeColor().themeFont,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocListener<UploadProfilePhotoCubit,
                                UploadProfilePhotoState>(
                              listener: (context, uploadstate) {
                                if (uploadstate is UploadProfilePhotoSuccess) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const KycDetails(canSkip: true),
                                    ),
                                    (route) => false,
                                  );
                                }
                              },
                              child: BlocBuilder<UploadProfilePhotoCubit,
                                  UploadProfilePhotoState>(
                                builder: (context, uploadstate) {
                                  if (uploadstate
                                      is UploadProfilePhotoLoading) {
                                    return const Center(
                                      child: ThemeSpinner(),
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF958d8c),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 0),
                                        onPressed: () {
                                          imagecubit.pickImageFromCamera();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 15),
                                          child: Text(
                                            "RETAKE",
                                            style: TextStyle(
                                              fontFamily:
                                                  AppthemeColor().themeFont,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppthemeColor().appMainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 0),
                                        onPressed: () {
                                          if (state is ImageUploadSuccess) {
                                            uploadimagecubit
                                                .uploadProfilePic(state.image);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 15),
                                          child: Text(
                                            "UPLOAD",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily:
                                                  AppthemeColor().themeFont,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const CircleAvatar(
                                backgroundColor: Color(0xffF1F0F5),
                                radius: 60,
                                child: Icon(
                                  Icons.person,
                                  size: 70,
                                  color: Color(0xff958E8E),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            CommonProximaNovaTextWidget(
                              textAlign: TextAlign.center,
                              text: 'Add your Photo\nto Complete your Profile!',

                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppthemeColor().themecolor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppthemeColor().appMainColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    imagecubit.pickImageFromCamera();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15),
                                    child: Text(
                                      "CAMERA",
                                      style: TextStyle(
                                        fontFamily: AppthemeColor().themeFont,
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                ],
              ));
            },
          )),
    );
  }
}
