import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/profile/logic/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../more_options/help_and_support/update_profile_details/screen/update_profile_details_screen.dart';
import '../../more_options/ratings/logic/cubit/ratings_cubit.dart';

class MoreRatingWidget extends StatelessWidget {
  final VoidCallback onTapFun;
  const MoreRatingWidget({super.key, required this.onTapFun});

  @override
  Widget build(BuildContext context) {
    context.read<RatingsCubit>().getRatingsList();
    return InkWell(
      hoverColor: Colors.transparent,
      overlayColor: WidgetStateColor.resolveWith((states) => Colors.transparent,),
      onTap: onTapFun,
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              color: Color(0xFFEDF0FF),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const CommonProximaNovaTextWidget(
                text: "Your Ratings",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              BlocBuilder<RatingsCubit, RatingsState>(
                builder: (context, state) {
                  return RatingBarIndicator(
                    rating: double.parse(state.averageRating!) ?? 0.0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: AppthemeColor().ratingColor,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Moreoptionswidget extends StatelessWidget {
  final String title, subTitle;
  final VoidCallback onTapFun;
  const Moreoptionswidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onTapFun});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFun,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 13),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonProximaNovaTextWidget(
                      text: title,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    3.ph,
                    CommonProximaNovaTextWidget(
                      text: subTitle,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff3A3A3A),
                    )
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Color(0xff6C5353),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Container(
              width: double.infinity,
              height: 1.2,
              color: const Color(0xffE2E2E2),
            ),
          )
        ],
      ),
    );
  }
}

class MoreProfileWidget extends StatelessWidget {
  final ProfileCubit profilecubit;
  const MoreProfileWidget({super.key, required this.profilecubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: profilecubit,
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UpdateProfileDetailsScreen(),
                  ));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                state.profileDetils?.displayImage == ""
                    ? CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(
                          Icons.person,
                          color: Colors.black54,
                          size: 35,
                        ),
                      )
                    : CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: NetworkImage(
                          state.profileDetils?.displayImage ??'',
                        ),
                      ),
                10.pw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonProximaNovaTextWidget(
                      text: state.profileDetils?.ownerName.toUpperCase() ??'',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    3.ph,
                    CommonProximaNovaTextWidget(
                      text:
                          "Profissional ID: ${state.profileDetils?.accessToken ??''}",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF223DFE),
                    )
                  ],
                )
              ],
            ));
      },
    );
  }
}
