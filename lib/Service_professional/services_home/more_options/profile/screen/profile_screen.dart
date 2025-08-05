import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../registration/onboarding/sceeen/onboarding_screen.dart';
import '../logic/cubit/profile_cubit.dart';
import '../widget/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {


    context.read<ProfileCubit>().fetchProfileData(false);
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: commonAppBarWidget(
          leadingArrowOnTap: () {
            Navigator.pop(context);
          },
          title: "Profile", ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.fetchLoading == true) {
            return const Center(child: ThemeSpinner());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.profileDetils!.displayImage != "")
                  Container(
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              state.profileDetils!.displayImage,
                            ),
                            fit: BoxFit.cover)),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonProximaNovaTextWidget(
                        text: "Rider Details",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      10.ph,
                      Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFEDF0FF),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RiderDetailWidget(
                                title:
                                    "${state.profileDetils!.ownerName.toUpperCase()}-",
                                description:
                                    "${state.profileDetils!.accessToken}"),
                            RiderDetailWidget(
                                title: "Zone:",
                                description:
                                    "${state.profileDetils!.countryName}"),
                            RiderDetailWidget(
                                title: "City:",
                                description:
                                    "${state.profileDetils!.cityName}"),
                            RiderDetailWidget(
                                title: "Service Type:",
                                description: "${state.profileDetils!.services}",
                                hideDivider: false),
                          ],
                        ),
                      ),
                      10.ph,
                      const CommonProximaNovaTextWidget(
                        text: "Personal Details",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      10.ph,         Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFEDF0FF),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProfileDetailWidget(
                                title: "Full Name",
                                description:
                                    "${state.profileDetils!.ownerName}"),
                            ProfileDetailWidget(
                                title: "Gender",
                                description: "${state.profileDetils!.gender}"),
                            ProfileDetailWidget(
                                title: "Phone Number",
                                description: "${state.profileDetils!.mobile}"),
                            ProfileDetailWidget(
                              title: "Mail ID",
                              description:
                                  "${state.profileDetils!.contactEmail}",
                            ),
                            ProfileDetailWidget(
                                title: "Languages Known",
                                description:
                                    "${state.profileDetils!.languageKnown}",
                                hideDivider: false),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
