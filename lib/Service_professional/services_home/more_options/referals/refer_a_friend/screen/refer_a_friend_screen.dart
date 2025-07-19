import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/referals/cubit/referral_list_cubit.dart';
import 'package:device_doctors_technician/widget/CustomWidget/Demo.dart';

import '../../../../../commons/color_codes.dart';
import '../../../../../commons/common_button_widget.dart';
import '../../../../../commons/common_textformfield.dart';
import '../../../../../registration/registrationflow/service_categories/logic/cubit/service_categories_cubit.dart';
import '../widget/refer_a_friend_widget.dart';

class ReferAFriendScreen extends StatefulWidget {
  final String amount;
  const ReferAFriendScreen({super.key, required this.amount});

  @override
  State<ReferAFriendScreen> createState() => _ReferAFriendScreenState();
}

class _ReferAFriendScreenState extends State<ReferAFriendScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? selectedType;
  String? selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    context
        .read<ServiceCategoriesCubit>()
        .fetchServiceCategories(searchKey: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "Refer a Friend"),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
                ReferAFriendWidget(type: "referal", amount: widget.amount,),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    CommonTextformfieldWidget(
                      fieldOntap: () {},
                      hintText: 'Mobile Number',
                      keyboardType: TextInputType.phone,
                      controller: mobileNumberController,
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
                          return 'Please Enter Mobile Number';
                        }
                        if (value!.length < 10) {
                          return 'Please Enter Valid Mobile Number';
                        }
                        return null;
                      },
                    ),
                    15.ph,
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
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                    15.ph,
                    CommonTextformfieldWidget(
                      fieldOntap: () {},
                      hintText: 'Age',
                      keyboardType: TextInputType.phone,
                      controller: ageController,
                      formatters: [
                        LengthLimitingTextInputFormatter(3),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]'),
                        ),
                        FilteringTextInputFormatter.deny(
                          RegExp(r'^0+'), //users can't type 0 at 1st position
                        ),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Age';
                        } else if (int.parse(value) < 18) {
                          return 'Not Eligble';
                        }
                        return null;
                      },
                    ),
                    15.ph,
                    BlocBuilder<ServiceCategoriesCubit, ServiceCategoriesState>(
                      builder: (context, catState) {
                        if (catState.serviceCategoriesList.isNotEmpty) {
                          return DropdownButtonFormField<String>(
                              value: selectedType,
                              validator: (value) => value == null
                                  ? "Please Select Service Type"
                                  : null,
                              isExpanded: true,
                              menuMaxHeight: 400,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: AppthemeColor().themeFont,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Color(0xFF222534),
                                  fontSize: 12,
                                  fontFamily: AppthemeColor().themeFont,
                                  fontWeight: FontWeight.w500,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0.50, color: Color(0xFFC1C1C1)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0.50, color: Color(0xFFC1C1C1)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.50,
                                      color: AppthemeColor().themecolor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hint: Text(
                                "Service Type",
                                style: TextStyle(
                                  color: Color(0xFF222534),
                                  fontSize: 12,
                                  fontFamily: AppthemeColor().themeFont,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                size: 20,
                                color: selectedType == ""
                                    ? Colors.grey
                                    : AppthemeColor().themecolor,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              items: catState.serviceCategoriesList.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type.title.trim() ?? "",
                                  child: Text(type.title),
                                );
                              }).toList(),
                              onChanged: ((String? value) {
                                setState(() {
                                  selectedType = value;
                                });
                              }));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    15.ph,
                    CommonTextformfieldWidget(
                      fieldOntap: () {},
                      hintText: 'City',
                      keyboardType: TextInputType.streetAddress,
                      controller: addressController,
                      formatters: [
                        // LengthLimitingTextInputFormatter(20),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter City';
                        }
                        return null;
                      },
                    ),
                    15.ph,
                    BlocBuilder<ReferralListCubit, ReferralListState>(
                      builder: (context, referState) {
                        if (referState.referalSubmitSuccess == false) {
                          return CommonButtonWidget(
                            buttontitle: "REFER NOW",
                            titlecolor: AppthemeColor().whiteColor,
                            buttonColor: AppthemeColor().appMainColor,
                            boardercolor: AppthemeColor().appMainColor,
                            buttonOnTap: () {
                              if (formkey.currentState!.validate()) {
                                context
                                    .read<ReferralListCubit>()
                                    .submitReferral(
                                        nameController.text,
                                        mobileNumberController.text,
                                        ageController.text,
                                        selectedType,
                                        addressController.text)
                                    .then((value) {
                                  context
                                      .read<ReferralListCubit>()
                                      .fetchReferralList();
                                  Navigator.pop(context);
                                });
                              }
                            },
                          );
                        } else {
                          return ThemeLoadingButton();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
