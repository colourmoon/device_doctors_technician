import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_textformfield.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/help_and_support/logic/cubit/help_and_support_cubit.dart';

import '../../../../../commons/color_codes.dart';
import '../../../../../commons/common_button_widget.dart';
import '../../../../../commons/common_toast.dart';
import '../../help_n_support/widget/help_and_support_widget.dart';
import '../../logic/cubit/image_upload_cubit.dart';
import '../../logic/cubit/image_upload_state.dart';

class OrderearningsIssueScreen extends StatefulWidget {
  final String type, title;
  const OrderearningsIssueScreen(
      {super.key, required this.type, required this.title});

  @override
  State<OrderearningsIssueScreen> createState() =>
      _OrderearningsIssueScreenState();
}

class _OrderearningsIssueScreenState extends State<OrderearningsIssueScreen> {
  late ImageUploadCubit imagecubit;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController orderIdController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    imagecubit = ImageUploadCubit();
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
            title: widget.title),
        body: Form(
          key: formkey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: BlocBuilder<ImageUploadCubit, ImageUploadStateBase>(
                  builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IssuesWidget(
                        type: widget.type,
                        descriptionController: descriptionController,
                        orderIdController: orderIdController),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      child: CommonProximaNovaTextWidget(
                        text: "Attachments",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff222534),
                      ),
                    ),
                    state is ImageUploadSuccess
                        ? Container(
                            width: double.infinity,
                            height: 81,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: FileImage(state.image),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0xFFD3DBE8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BlocBuilder<ImageUploadCubit,
                                      ImageUploadStateBase>(
                                    bloc: imagecubit,
                                    builder: (context, state) {
                                      return AlertDialog(
                                        title: const Text('Choose an option'),
                                        content: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  imagecubit
                                                      .pickImageFromCamera();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Camera'),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  imagecubit
                                                      .pickImageFromGallery();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Gallery'),
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
                            child: Container(
                              width: double.infinity,
                              height: 81,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFD3DBE8),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                child: SizedBox(
                                    width: double.infinity,
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/services_new/galary.svg',
                                          height: 20,
                                          width: 20,
                                        ),
                                        4.pw,
                                        const CommonProximaNovaTextWidget(
                                          text: "Upload Photo",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                    15.ph,
                    BlocBuilder<HelpAndSupportCubit, HelpAndSupportState>(
                        builder: (context, helpState) {
                      if (helpState.submitSupportSuccess == false) {
                        return CommonButtonWidget(
                          buttontitle: "UPLOAD",
                          titlecolor: AppthemeColor().whiteColor,
                          buttonColor: AppthemeColor().appMainColor,
                          boardercolor: AppthemeColor().appMainColor,
                          buttonOnTap: () {
                            if (formkey.currentState!.validate()) {
                              if (state is ImageUploadSuccess) {
                                context
                                    .read<HelpAndSupportCubit>()
                                    .submitFile(
                                        state.image,
                                        widget.type,
                                        descriptionController.text,
                                        orderIdController.text)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Select Image',
                                    backgroundColor: Colors.red);
                              }
                            }
                          },
                        );
                      } else {
                        return const ThemeLoadingButton();
                      }
                    }),
                  ],
                );
              })),
        ),
      ),
    );
  }
}
