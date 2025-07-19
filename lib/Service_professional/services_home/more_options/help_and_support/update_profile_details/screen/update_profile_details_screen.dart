import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:device_doctors_technician/widget/CustomWidget/Demo.dart';

import '../../../../../commons/common_button_widget.dart';
import '../../../../../commons/common_textformfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../../../../../registration/registrationflow/upload_photo/logic/cubit/upload_profile_photo_cubit.dart';
import '../../../profile/logic/cubit/profile_cubit.dart';
import '../../logic/cubit/image_upload_cubit.dart';
import '../../logic/cubit/image_upload_state.dart';
import '../logic/cubit/updat_profile_cubit.dart';

class UpdateProfileDetailsScreen extends StatefulWidget {
  const UpdateProfileDetailsScreen({super.key});

  @override
  State<UpdateProfileDetailsScreen> createState() =>
      _UpdateProfileDetailsScreenState();
}

class _UpdateProfileDetailsScreenState
    extends State<UpdateProfileDetailsScreen> {
  late ImageUploadCubit imagecubit;
  TextEditingController nameController = TextEditingController();
  dynamic selectedOption = "Telugu";
  final List languagesList = const [
    'Telugu',
    'Hindi',
    'English',
  ];
  String oldImage = "";
  List selectedLanguagesList = [];
  void updateSelectedLanguages(List<dynamic> newList) {
    setState(() {
      selectedLanguagesList = [];
      selectedLanguagesList = newList;
      if (selectedLanguagesList[0] == "") {
        selectedLanguagesList.removeAt(0);
      }
    });

    print("selected lang: ${selectedLanguagesList[0]}");
  }

  bool isImageUploaded = false;
  @override
  void initState() {
    context.read<ProfileCubit>().fetchProfileData(false);
    imagecubit = ImageUploadCubit();
    // nameController.text = "yashwanth";
    // context.read<ImageUploadCubit>().initState();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => imagecubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppBarWidget(
            leadingArrowOnTap: () {
              Navigator.pop(context);
            },
            title: "Update Personal Details"),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, pstate) {
            // TODO: implement listener
            if (pstate.profileDetils != null) {
              nameController.text = pstate.profileDetils!.ownerName;
              oldImage = pstate.profileDetils!.displayImage;
              final names = pstate.profileDetils!.languageKnown;
              final splitNames = names.split(',');
              selectedLanguagesList = [];
              for (int i = 0; i < splitNames.length; i++) {
                selectedLanguagesList.add(splitNames[i]);
              }
            }
            print("languages selected : $selectedLanguagesList");
          },
          builder: (context, state) {
            if (state.fetchLoading == true) {
              return const Center(child: ThemeSpinner());
            }
            return SingleChildScrollView(
              child: BlocConsumer<UploadProfilePhotoCubit,
                  UploadProfilePhotoState>(
                listener: (context, ustate) {
                  if (ustate is UploadProfilePhotoSuccess) {
                    // nameController.text = this.nameController.text;

                    context.read<ProfileCubit>().fetchProfileData(true);
                  }
                  // TODO: implement listener
                },
                builder: (context, ustate) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocConsumer<ImageUploadCubit, ImageUploadStateBase>(
                      listener: (context, state) {
                        print("image uplod success");
                        if (state is ImageUploadSuccess) {
                          context
                              .read<UploadProfilePhotoCubit>()
                              .uploadProfilePic(state.image);
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            ustate is UploadProfilePhotoLoading
                                ? const Center(
                                    child: ThemeSpinner(
                                    size: 20,
                                  ))
                                : Center(
                                    child: Stack(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            child: state is ImageUploadSuccess
                                                ? CircleAvatar(
                                                    radius: 60,
                                                    child: ClipOval(
                                                      child: Image.file(
                                                        state.image,
                                                        height: 120,
                                                        width: 120,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ))
                                                : oldImage != ""
                                                    ? CircleAvatar(
                                                        radius: 60,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                oldImage),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 60,
                                                        backgroundColor: Colors
                                                            .grey.shade200,
                                                        child: const Icon(
                                                          Icons.person,
                                                          color: Colors.black54,
                                                          size: 45,
                                                        ),
                                                      )),
                                        Positioned(
                                          bottom: 30,
                                          right: 15,
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BlocBuilder<
                                                      ImageUploadCubit,
                                                      ImageUploadStateBase>(
                                                    bloc: imagecubit,
                                                    builder: (context, state) {
                                                      // isImageUploaded = false;
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Choose an option'),
                                                        content: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  imagecubit
                                                                      .pickImageFromCamera()
                                                                      .then(
                                                                          (value) async {
                                                                    // context
                                                                    //     .read<
                                                                    //        ProfileCubit>()
                                                                    //     .fetchProfileData(
                                                                    //         true);
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'Camera'),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await imagecubit
                                                                      .pickImageFromGallery()
                                                                      .then(
                                                                          (value) {
                                                                    print(
                                                                        "galarryyyyy ${state}");
                                                                    // context
                                                                    //     .read<
                                                                    //         ProfileCubit>()
                                                                    //     .fetchProfileData(
                                                                    //         true);
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'Gallery'),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppthemeColor().appMainColor,
                                              radius: 15,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Image.asset(
                                                  "assets/services_new/editicon.png",
                                                  height: 15,
                                                  width: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            CommonTextformfieldWidget(
                              fieldOntap: () {},
                              hintText: 'Name',
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              formatters: [
                                LengthLimitingTextInputFormatter(20),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name is Empty';
                                }
                                return null;
                              },
                              suffixiconWidget: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 13,
                              ),
                            ),
                            15.ph,
                            MultiSelectDropdown.simpleList(
                              // splashColor: Colors.black,
                              // checkboxFillColor: Colors.black,
                              listTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: AppthemeColor().themeFont,
                                fontWeight: FontWeight.w500,
                              ),

                              textStyle: TextStyle(
                                color: const Color(0xFF222534),
                                fontSize: 12,
                                fontFamily: AppthemeColor().themeFont,
                                fontWeight: FontWeight.w500,
                              ),
                              whenEmpty: "Languages Known",
                              list: languagesList,

                              initiallySelected: selectedLanguagesList,
                              onChange: updateSelectedLanguages,
                              boxDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xFFC1C1C1),
                                  )),
                              // includeSelectAll: true,
                            ),
                            15.ph,
                            BlocConsumer<UpdatProfileCubit, UpdatProfileState>(
                              listener: (context, pstate) {
                                if (pstate is UpdatProfileSuccess) {
                                  context
                                      .read<ProfileCubit>()
                                      .fetchProfileData(true);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, pstate) {
                                if (pstate is UpdatProfileLoading) {
                                  return ThemeSpinner();
                                }
                                return CommonButtonWidget(
                                  buttontitle: "UPDATE",
                                  titlecolor: AppthemeColor().whiteColor,
                                  buttonColor: AppthemeColor().appMainColor,
                                  boardercolor: AppthemeColor().appMainColor,
                                  buttonOnTap: () {
                                    context
                                        .read<UpdatProfileCubit>()
                                        .updateProfile(
                                            name: nameController.text,
                                            languages: selectedLanguagesList
                                                .join(','));
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
