import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/widget/CustomWidget/CustomAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commons/common_images.dart';
import '../../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../logic/cubit/ratings_cubit.dart';
import '../widget/ratings_widget.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  void initState() {
    context.read<RatingsCubit>().getRatingsList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> fetchData() async {
      final data = await getDataFromAPI(); // wait here
      if (kDebugMode) {
        print(data);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: InkWell(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                color: const Color(0xFFECECEC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
        titleSpacing: -5,
        title: Row(
          children: [
            Text(
              "Ratings",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'ProximaNova',
                fontWeight: FontWeight.w600,
              ),
            ),
            10.pw,
            BlocBuilder<RatingsCubit, RatingsState>(
              builder: (context, state) {
                if (state.dataLoaded == true) {
                  return const SizedBox.shrink();
                }

                return state.averageRating != "0"
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppthemeColor().ratingColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.white,
                              ),
                              CommonProximaNovaTextWidget(
                                text: "${state.averageRating}",
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink();
              },
            )
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<RatingsCubit, RatingsState>(
        builder: (context, state) {
          if (state.dataLoaded == true) {
            return ThemeSpinner();
          } else if (state.payoutError.isNotEmpty) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonImages().noRatingsImage,
                    5.ph,
                    CommonProximaNovaTextWidget(
                      text: "No Ratings Yet!",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Click Me'),
                    )

                  ],
                ),
              ),
            );
          }
          // return SizedBox.shrink();
          return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: state.ratingsList!.length,
              itemBuilder: (context, index) => ServiceReviewsWidget(
                  name: state.ratingsList![index].customerName,
                  image: state.ratingsList![index].image,
                  rating: state.ratingsList![index].rating,
                  review: state.ratingsList![index].review,
                  reviewCount: state.ratingsList![index].reviewCount.toString(),
                  date: state.ratingsList![index].createdAt,
                  hasdivider: index == 10 - 1 ? false : true));
        },
      ),
    );
  }

  getDataFromAPI() {}
}
