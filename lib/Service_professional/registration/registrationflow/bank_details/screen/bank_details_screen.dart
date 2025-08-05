import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_toast.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/shimmer_data.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';

import '../../../../commons/color_codes.dart';
import '../../../../commons/common_button_widget.dart';
import '../../../../commons/common_textformfield.dart';
import '../../../../services_bottombar/screen/services_bottombar_screen.dart';
import '../../profile_verification/cubit/profile_verfication_cubit.dart';
import '../logic/cubit/bank_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankDetailsScreen extends StatefulWidget {
  final bool canSkip;
  const BankDetailsScreen({super.key, required this.canSkip});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final formkey = GlobalKey<FormState>();
  late BankDetailsCubit detailsCubit;
  late ProfileVerficationCubit verificationCubit;
  String id = "";
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  @override
  void initState() {
    detailsCubit = BankDetailsCubit();
    verificationCubit = ProfileVerficationCubit();
    if (widget.canSkip == false) {
      verificationCubit.profileVerificationCheck();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => detailsCubit,
        ),
        BlocProvider(
          create: (context) => verificationCubit,
        ),
      ],
      child: BlocConsumer<ProfileVerficationCubit, ProfileVerficationState>(
        listener: (context, verificationstate) {
          if (verificationstate.verificationModel!.bankDetails == true) {
            detailsCubit.getBankDetails();
          }
          // TODO: implement listener
        },
        builder: (context, verificationstate) {
          return BlocConsumer<BankDetailsCubit, BankDetailsState>(
            bloc: detailsCubit,
            listener: (context, state) {
              if (state.fetchedDetails != null) {
                accountNameController.text = state.fetchedDetails!.accountName;
                accountNumberController.text =
                    state.fetchedDetails!.accountNumber;
                branchNameController.text = state.fetchedDetails!.branch;
                bankNameController.text = state.fetchedDetails!.bankName;
                ifscCodeController.text = state.fetchedDetails!.ifscCode;
                id = state.fetchedDetails!.id;
              } else if (state.Success == "valid") {
                if (widget.canSkip) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ServicesBottomBarScreen(initialIndex: 0),
                    ),
                    (route) => false,
                  );
                } else {
                  Navigator.pop(context);
                }
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state.detailsLoading == true ||
                  verificationstate.isLoading == true) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: commonAppBarWidget(
                      isBack: !widget.canSkip,
                      leadingArrowOnTap: () {
                        Navigator.pop(context);
                      },
                      title: "Bank Details"),
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(child: ThemeSpinner()),
                  ),
                );
              }
              return Scaffold(
                backgroundColor: Colors.white,

                appBar: commonAppBarWidget(
                  isBack: !widget.canSkip,
                  leadingArrowOnTap: () {
                    Navigator.pop(context);
                  },
                  title: widget.canSkip? "" :"Bank Details",
                  actions: [
                    if(widget.canSkip)
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                            const ServicesBottomBarScreen(
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
                  child: Form(
                      key: formkey,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: widget.canSkip ? 15 : 0),
                        child: Column(
                          children: [
                            if (widget.canSkip)
                              CommonProximaNovaTextWidget(
                                textAlign: TextAlign.center,
                                text: "Please Upload Bank\nDetails",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppthemeColor().themecolor,
                              ),
                            15.ph,
                            CommonTextformfieldWidget(
                              fieldOntap: () {},
                              hintText: 'Account Holder Name',
                              keyboardType: TextInputType.name,
                              controller: accountNameController,
                              formatters: [
                                LengthLimitingTextInputFormatter(20),
                                // FilteringTextInputFormatter.allow(
                                //   RegExp(r'[A-Z][a-z]'),
                                // ),
                                // FilteringTextInputFormatter.deny(
                                //   RegExp(r'^0+'), //users can't type 0 at 1st position
                                // ),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Account Enter Holder Name';
                                }
                                return null;
                              },
                            ),
                            15.ph,
                            CommonTextformfieldWidget(
                              fieldOntap: () {},
                              hintText: 'Account Number',
                              keyboardType: TextInputType.number,
                              controller: accountNumberController,
                              formatters: [
                                LengthLimitingTextInputFormatter(20),
                                // FilteringTextInputFormatter.allow(
                                //   RegExp(r'[0-9]'),
                                // ),
                                // FilteringTextInputFormatter.deny(
                                //   RegExp(r'^0+'), //users can't type 0 at 1st position
                                // ),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Account Number';
                                }
                                return null;
                              },
                            ),
                            15.ph,
                            CommonTextformfieldWidget(
                              fieldOntap: () {},
                              hintText: 'Bank Name',
                              keyboardType: TextInputType.name,
                              controller: bankNameController,
                              formatters: [
                                // LengthLimitingTextInputFormatter(20),
                                // FilteringTextInputFormatter.allow(
                                //   RegExp(r'[A-Z][a-z]'),
                                // ),
                                // FilteringTextInputFormatter.deny(
                                //   RegExp(r'^0+'), //users can't type 0 at 1st position
                                // ),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Bank Name';
                                }
                                return null;
                              },
                            ),
                            15.ph,
                            CommonTextformfieldWidget(
                              fieldOntap: () {},
                              hintText: 'Branch Name',
                              keyboardType: TextInputType.name,
                              controller: branchNameController,
                              formatters: [
                                // LengthLimitingTextInputFormatter(20),
                                // FilteringTextInputFormatter.allow(
                                //   RegExp(r'[A-Z][a-z]'),
                                // ),
                                // FilteringTextInputFormatter.deny(
                                //   RegExp(r'^0+'), //users can't type 0 at 1st position
                                // ),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Branch Name';
                                }
                                return null;
                              },
                            ),
                            15.ph,
                            CommonTextformfieldWidget(
                              fieldOntap: () {},
                              hintText: 'IFSC Code',
                              keyboardType: TextInputType.name,
                              controller: ifscCodeController,
                              formatters: [
                                LengthLimitingTextInputFormatter(20),
                                // FilteringTextInputFormatter.allow(
                                //   RegExp(r'[A-Z][a-z][0-9]'),
                                // ),
                                // FilteringTextInputFormatter.deny(
                                //   RegExp(r'^0+'), //users can't type 0 at 1st position
                                // ),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter IFSC Code';
                                }
                                return null;
                              },
                            ),
                            15.ph,
                            state.isLoading == true
                                ? Center(
                                    child: ThemeSpinner(),
                                  )
                                : CommonButtonWidget(
                                    buttontitle: widget.canSkip == false
                                        //  verificationstate
                                        //             .verificationModel!
                                        //             .bankDetails ==
                                        //         true
                                        ? "UPDATE DETAILS"
                                        : "ADD DETAILS",
                                    titlecolor: AppthemeColor().whiteColor,
                                    buttonColor: AppthemeColor().appMainColor,
                                    boardercolor: AppthemeColor().appMainColor,
                                    buttonOnTap: () {
                                      if (formkey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        Map<String, dynamic> bodyData = {
                                          "access_token": Constants.prefs
                                              ?.getString(
                                                  "provider_access_token"),
                                          // "id":1
                                          "account_name":
                                              accountNameController.text,
                                          "bank_name": bankNameController.text,
                                          "branch": branchNameController.text,
                                          "ifsc_code": ifscCodeController.text,
                                          "account_number":
                                              accountNumberController.text
                                        };
                                        if (id != "") {
                                          bodyData["id"] = id;
                                        }
                                        detailsCubit.updateBankDetails(
                                            bodyData: bodyData);
                                      } else {
                                        CommonToastwidget(
                                            toastmessage:
                                                "Unable to Update Details Please Try Again");
                                      }
                                    },
                                  ),
                          ],
                        ),
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
