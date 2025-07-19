import 'package:device_doctors_technician/widget/CustomWidget/Demo.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_textformfield.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/shimmer_data.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:device_doctors_technician/comman/common_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../../../commons/color_codes.dart';
import '../../../../commons/common_button_widget.dart';
import '../../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../logic/cubit/service_categories_cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widget/service_category_widget.dart';

class ServiceCategoriesScreen extends StatefulWidget {
  const ServiceCategoriesScreen({super.key});

  @override
  State<ServiceCategoriesScreen> createState() =>
      _ServiceCategoriesScreenState();
}

class _ServiceCategoriesScreenState extends State<ServiceCategoriesScreen> {
  TextEditingController searchController = TextEditingController();
  late ServiceCategoriesCubit categoriesCubit;
  @override
  void initState() {
    categoriesCubit = ServiceCategoriesCubit();
    categoriesCubit.fetchServiceCategories(searchKey: "");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoriesCubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppBarWidget(
            leadingArrowOnTap: () {
              Navigator.pop(context);
            },
            title: " What work do you do?"),
        bottomNavigationBar:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomPaint(
                  painter: DottedLinePainter(),
                  child: const SizedBox(
                    width: double.infinity,
                    height: 1.0,
                  ),
                ),
                10.ph,
                BlocBuilder<ServiceCategoriesCubit, ServiceCategoriesState>(
                          builder: (context, state) {
                if (state.isLoading == true) {
                  return const SizedBox.shrink();
                } else if (state.selectedCategoriesList.isNotEmpty) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: CommonButtonWidget(
                      buttontitle: "Submit",
                      titlecolor: AppthemeColor().whiteColor,
                      buttonColor: AppthemeColor().appMainColor,
                      boardercolor: AppthemeColor().appMainColor,
                      buttonOnTap: () {
                        print("services list: ${state.selectedCategoriesList}");
                        List<String> firstList = [];
                        List<String> secondList = [];
                        state.selectedCategoriesList.forEach((element) {
                          firstList.add(element.id);
                        });
                        state.selectedCategoriesList.forEach((element) {
                          secondList.add(element.title);
                        });
                        List lists = [firstList, secondList];

                        Navigator.pop(context, lists);
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
                          },
                        ),
              ],
            ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              BlocBuilder<ServiceCategoriesCubit, ServiceCategoriesState>(
                builder: (context, state) {
                  return TextFormField(
                    textAlign: TextAlign.start,
                    // readOnly: readonly,
                    // onTap: fieldOntap,
                    cursorColor: AppthemeColor().themecolor,
                    // inputFormatters: formatters,
                    //  [
                    //   LengthLimitingTextInputFormatter(10),
                    //   FilteringTextInputFormatter.allow(
                    //     RegExp(r'[0-9]'),
                    //   ),
                    //   FilteringTextInputFormatter.deny(
                    //     RegExp(r'^0+'), //users can't type 0 at 1st position
                    //   ),
                    // ],
                    // readOnly: state.loginLoading ? true : false,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: searchController,
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 12,
                      fontFamily: 'ProximaNova',
                      fontWeight: FontWeight.w500,
                    ),
                    // maxLength: 10,
                    // keyboardType: keyboardType,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: state.searchLoading == true
                          ? const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: ThemeSpinner(),
                              ),
                            )
                          : null,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 15,
                            )),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      hintText: "Search Available Services",
                      hintStyle: const TextStyle(
                        color: Color(0xFF222534),
                        fontSize: 12,
                        fontFamily: 'ProximaNova',
                        fontWeight: FontWeight.w500,
                      ),

                      // prefixIcon: const Padding(
                      //   padding: EdgeInsets.all(16),
                      //   child: ImageIcon(
                      //     AssetImage('assets/FoodRestaurant/user2342.png'),
                      //     size: 10,
                      //   ),
                      // ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                    ),
                    onChanged: (val) {
                      categoriesCubit.fetchServiceCategories(searchKey: val);
                    },
                    validator: (val) {},
                  );
                },
              ),
              BlocBuilder<ServiceCategoriesCubit, ServiceCategoriesState>(
                builder: (context, state) {
                  if (state.isLoading == true) {
                    return const Expanded(child: CategoriesLoadingWidget());
                  }
                  if (state.serviceCategoriesList.isNotEmpty) {
                    return Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    categoriesCubit.selectService(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: CommonProximaNovaTextWidget(
                                          text: state
                                              .serviceCategoriesList[index]
                                              .title,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        )),
                                        if (state.serviceCategoriesList[index]
                                            .isSelected)
                                          CircleAvatar(
                                            radius: 9,
                                            backgroundColor: AppthemeColor()
                                                .appMainColor,
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 13,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => CustomPaint(
                                  painter: DottedLinePainter(),
                                  child: const SizedBox(
                                    width: double.infinity,
                                    height: 1.0,
                                  ),
                                ),
                            itemCount: state.serviceCategoriesList.length));
                  }
                  return const CommonProximaNovaTextWidget(
                    text: "No Services Available",
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
