import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_doctors_technician/comman/common_text.dart';
import 'package:device_doctors_technician/widget/CustomWidget/Demo.dart';
import 'package:image_picker/image_picker.dart' as imageSource;
import 'package:dio/dio.dart' as dio;

import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../comman/color_codes.dart';
import '../../../../../utility/network_image_widget.dart';
import '../../../../commons/color_codes.dart';
import '../../../../commons/common_button_widget.dart';
import '../../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../../../../services_bottombar/screen/services_bottombar_screen.dart';
import '../../../../services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import '../../../../services_home/more_options/profile/logic/cubit/profile_cubit.dart';
import '../../bank_details/screen/bank_details_screen.dart';
import '../../profile_verification/cubit/profile_verfication_cubit.dart';
import '../cubit/kyc_cubit.dart';

class KycDetails extends StatefulWidget {
  final bool canSkip;
  const KycDetails({super.key, required this.canSkip});

  @override
  State<KycDetails> createState() => _KycDetailsState();
}

class _KycDetailsState extends State<KycDetails> {
  String? uploadpanImagepic;
  String? uploadAdharImagepic;
  String? uploadAdharBackImagepic;
  File? panImage;
  File? adharImage;
  File? adharBackImage;

  imageSource.ImagePicker picker = imageSource.ImagePicker();

  Future<File?> pickDocument(
      imageSource.ImageSource source, String imageType) async {
    // try {
    // if (await Permission.storage.isGranted) {
    final pickedRawDoc = await picker.pickImage(
      source: source,
      imageQuality: 30,
      maxHeight: 1200,
      maxWidth: 1200,
    );

    if (pickedRawDoc == null) {
      return null;
    } else {
      //Handle the file
      return File(pickedRawDoc.path);
    }
  }

  Future<void> getImage(
      imageSource.ImageSource source, String imageType) async {
    final pickedDocument = await pickDocument(source, imageType);
    if (pickedDocument == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No file selected")));
    } else {
      final fileName = pickedDocument.path.split('/').last;
      final data = dio.FormData.fromMap({
        "image": await dio.MultipartFile.fromFile(
          pickedDocument.path,
          filename: fileName,
        )
      });
      log(ApiEndPoints.servergUrl + ApiEndPoints.imageUploadService);
      var request = await BaseApi().dioClient().post(
            ApiEndPoints.servergUrl + ApiEndPoints.imageUploadService,
            data: data,
          );
      if (request.data['err_code'] == "invalid") {
        Fluttertoast.showToast(msg: request.data['message']);
      }

      if (request.data['err_code'] == "valid") {
        if (mounted) {
          setState(() {
            if (imageType == "pan") {
              setState(() {
                panImage = pickedDocument;
                uploadpanImagepic = request.data['data'];
              });
            } else if (imageType == "adhar") {
              setState(() {
                adharImage = pickedDocument;
                uploadAdharImagepic = request.data['data'];
              });
            } else if (imageType == "adhar_back") {
              setState(() {
                adharBackImage = pickedDocument;
                uploadAdharBackImagepic = request.data['data'];
              });
            }
          });
        }
        // _textController.text = '';
        // await _taskChatController.postChatData(
        //     widget.taskId, texte!, attachpic!);
        // texte = "";
        // attachpic = '';
      }
    }
  }

  late ProfileVerficationCubit verificationCubit;

  @override
  void initState() {
    verificationCubit = ProfileVerficationCubit();
    if (widget.canSkip == false) {
      context.read<ProfileCubit>().fetchProfileData(false);
      verificationCubit.profileVerificationCheck();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBarWidget(
        isBack: !widget.canSkip,
        leadingArrowOnTap: () {
          Navigator.maybePop(context);
        },
        title: (widget.canSkip) ? "" : 'KYC Details',
        actions: [
          if (widget.canSkip)
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
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<KycCubit, KycState>(
          listener: (context, state) {
            if (state.Success == "valid") {
              context
                  .read<ProfileVerficationCubit>()
                  .profileVerificationCheck();
              print("updated successfully");

              if (widget.canSkip) {
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        const BankDetailsScreen(canSkip: true),
                  ),
                  (route) => false,
                );
              } else {
                Navigator.maybePop(context);
              }
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: widget.canSkip ? 8 : 0, horizontal: 14),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, profileState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.canSkip)
                        Center(
                          child: Text(
                            'Please Upload KYC Details',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: AppthemeColor().themeFont,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      if (widget.canSkip) 15.ph,
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: CommonProximaNovaTextWidget(
                          text: "Adhaar Card Front",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            _pickingImage(context, "adhar");
                          },
                          child: adharImage == null
                              ? widget.canSkip == true
                                  ? DottedBorder(
                                      dashPattern: const [7, 3],
                                      color: Colors.grey,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 70,
                                          // width: 150,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.photo,
                                                color: Colors.grey,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CommonProximaNovaTextWidget(
                                                  text: "Upload Photo")
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : profileState.fetchLoading == true
                                      ? const ThemeSpinner()
                                      : profileState.profileDetils!
                                                  .adhaarCardFront !=
                                              ''
                                          ? Container(
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFD3DBE8),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(12),
                                                child: NetworkImageWidget(
                                                  image: profileState
                                                      .profileDetils!
                                                      .adhaarCardFront,
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : DottedBorder(
                                              dashPattern: const [7, 3],
                                              color: Colors.grey,
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(12),
                                              padding: const EdgeInsets.all(6),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 150,
                                                  // width: 150,
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.photo,
                                                        color: Colors.grey,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      CommonProximaNovaTextWidget(
                                                          text: "Upload Photo")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                              : DottedBorder(
                                  dashPattern: const [7, 3],
                                  color: Colors.grey,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  padding: const EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Image.file(
                                      adharImage!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                          child: CommonProximaNovaTextWidget(
                            text: "Adhaar Card Back",
                            fontWeight: FontWeight.w600,
                          )),
                      GestureDetector(
                          onTap: () {
                            _pickingImage(context, "adhar_back");
                          },
                          child: adharBackImage == null
                              ? widget.canSkip == true
                                  ? DottedBorder(
                                      dashPattern: const [7, 3],
                                      color: Colors.grey,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 150,
                                          // width: 150,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.photo,
                                                color: Colors.grey,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CommonProximaNovaTextWidget(
                                                  text: 'Upload Photo')
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : profileState.fetchLoading == true
                                      ? const ThemeSpinner()
                                      : profileState.profileDetils!
                                                  .adhaarCardBack !=
                                              ''
                                          ? Container(
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFD3DBE8),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(12),
                                                child: NetworkImageWidget(
                                                  image: profileState
                                                      .profileDetils!
                                                      .adhaarCardBack,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                  height: 150,
                                                ),
                                              ),
                                            )
                                          : DottedBorder(
                                              dashPattern: const [7, 3],
                                              color: Colors.grey,
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(12),
                                              padding: const EdgeInsets.all(6),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 150,
                                                  // width: 150,
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.photo,
                                                        color: Colors.grey,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      CommonProximaNovaTextWidget(
                                                          text: "Upload Photo")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                              : DottedBorder(
                                  dashPattern: const [7, 3],
                                  color: Colors.grey,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  padding: const EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Image.file(
                                      adharBackImage!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                          child: CommonProximaNovaTextWidget(
                            text: "Pan Card ",
                            fontWeight: FontWeight.w600,
                          )),
                      GestureDetector(
                          onTap: () {
                            _pickingImage(context, "pan");
                          },
                          child: panImage == null
                              ? widget.canSkip == true
                                  ? DottedBorder(
                                      dashPattern: const [7, 3],
                                      color: Colors.grey,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 150,
                                          // width: 150,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.photo,
                                                color: Colors.grey,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CommonProximaNovaTextWidget(
                                                  text: 'Upload Photo')
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : profileState.fetchLoading == true
                                      ? const ThemeSpinner()
                                      : profileState.profileDetils!.panCard !=
                                              ''
                                          ? Container(
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFD3DBE8),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(12),
                                                child: NetworkImageWidget(
                                                  image: profileState
                                                      .profileDetils!.panCard,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                  height: 150,
                                                ),
                                              ),
                                            )
                                          : DottedBorder(
                                              dashPattern: const [7, 3],
                                              color: Colors.grey,
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(12),
                                              padding: const EdgeInsets.all(6),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 150,
                                                  // width: 150,
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.photo,
                                                        color: Colors.grey,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      CommonProximaNovaTextWidget(
                                                          text: "Upload Photo")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                              : DottedBorder(
                                  dashPattern: const [7, 3],
                                  color: Colors.grey,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  padding: const EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Image.file(
                                      panImage!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ))),
                      20.ph,
                      state.isLoading == true
                          ? const Center(
                              child: ThemeSpinner(),
                            )
                          : CommonButtonWidget(
                              buttontitle: widget.canSkip == false
                                  //  verificationstate
                                  //             .verificationModel!
                                  //             .bankDetails ==
                                  //         true
                                  ? "UPDATE DETAILS"
                                  : "Add Details",
                              titlecolor: AppthemeColor().whiteColor,
                              buttonColor: AppthemeColor().appMainColor,
                              boardercolor: AppthemeColor().appMainColor,
                              buttonOnTap: () {
                                if (profileState.profileDetils?.panCard == '' ||
                                    profileState
                                            .profileDetils?.adhaarCardFront ==
                                        '' ||
                                    profileState
                                            .profileDetils?.adhaarCardBack ==
                                        '') {
                                  if (panImage == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Please Upload Pan Card');
                                  } else if (adharImage == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Please Upload Adhar Front');
                                  } else if (adharBackImage == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Please Upload Adhar Back');
                                  } else {
                                    context.read<KycCubit>().kycSubmit(
                                        uploadAdharImagepic.toString(),
                                        uploadAdharBackImagepic.toString(),
                                        uploadpanImagepic.toString());
                                  }
                                } else {
                                  if (uploadAdharImagepic != null &&
                                      uploadAdharBackImagepic != null &&
                                      uploadpanImagepic != null) {
                                    context.read<KycCubit>().kycSubmit(
                                      uploadAdharImagepic.toString(),
                                      uploadAdharBackImagepic.toString(),
                                      uploadpanImagepic.toString(),
                                    );
                                  } else if (uploadpanImagepic != null && uploadAdharImagepic != null) {
                                    context.read<KycCubit>().kycSubmit(
                                      uploadAdharImagepic.toString(),
                                      profileState.profileDetils?.adhaarCardBack.split('uploads/')[1],
                                      uploadpanImagepic.toString(),
                                    );
                                  } else if (uploadAdharImagepic != null && uploadAdharBackImagepic != null) {
                                    context.read<KycCubit>().kycSubmit(
                                      uploadAdharImagepic.toString(),
                                      uploadAdharBackImagepic.toString(),
                                      profileState.profileDetils?.panCard.split('uploads/')[1],
                                    );
                                  } else if (uploadpanImagepic != null && uploadAdharBackImagepic != null) {
                                    context.read<KycCubit>().kycSubmit(
                                      profileState.profileDetils?.adhaarCardFront.split('uploads/')[1],
                                      uploadAdharBackImagepic.toString(),
                                      uploadpanImagepic.toString(),
                                    );
                                  }
                                  else if (panImage != null) {
                                    context.read<KycCubit>().kycSubmit(
                                        profileState
                                            .profileDetils?.adhaarCardFront
                                            .split('uploads/')[1],
                                        profileState
                                            .profileDetils?.adhaarCardBack
                                            .split('uploads/')[1],
                                        uploadpanImagepic.toString());
                                  } else if (adharImage != null) {
                                    context.read<KycCubit>().kycSubmit(
                                        uploadAdharImagepic.toString(),
                                        profileState
                                            .profileDetils?.adhaarCardBack
                                            .split('uploads/')[1],
                                        profileState.profileDetils?.panCard
                                            .split('uploads/')[1]);
                                  } else if (adharBackImage != null) {
                                    context.read<KycCubit>().kycSubmit(
                                        profileState
                                            .profileDetils?.adhaarCardFront
                                            .split('uploads/')[1],
                                        uploadAdharBackImagepic.toString(),
                                        profileState.profileDetils?.panCard
                                            .split('uploads/')[1]);
                                  } else {
                                    context.read<KycCubit>().kycSubmit(
                                        uploadAdharImagepic.toString(),
                                        uploadAdharBackImagepic.toString(),
                                        uploadpanImagepic.toString());
                                  }
                                }
                              },
                            )
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickingImage(BuildContext context, String picktype) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const CommonProximaNovaTextWidget(text: "Choose Pic From"),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.maybePop(context);

                  await getImage(imageSource.ImageSource.camera, picktype);
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 25,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: appMainColor,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    CommonProximaNovaTextWidget(text: "Camera"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.maybePop(context);

                  await getImage(imageSource.ImageSource.gallery, picktype);
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 25,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: appMainColor,
                        child: Icon(
                          Icons.photo_library_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CommonProximaNovaTextWidget(text: "Gallery")
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
