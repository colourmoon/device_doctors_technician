import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/services_bottombar/widgets/bottom_bar_appbar_widget.dart';

import '../../notifications/logic/cubit/notifications_data_cubit.dart';
import '../../notifications/screens/norifications_screen.dart';
import '../../registration/registrationflow/profile_verification/cubit/profile_verfication_cubit.dart';
import '../../services_home/completed_orders/screen/completed_orders_screen.dart';
import '../../services_home/more_options/profile/logic/cubit/profile_cubit.dart';
import '../../services_home/more_tab/screen/more_screen.dart';
import '../../services_home/new_orders/screen/new_orders_screen.dart';
import '../../services_home/ongoing_order/screen/ongoing_orders_screen.dart';
import '../../services_home/services_tab/screen/services_screen.dart';
import '../../update_push_token_cubit/cubit/update_push_token_cubit.dart';
import '../logic/cubit/services_bottom_bar_cubit.dart';
import '../logic/orderscountcubit/orders_count_cubit.dart';

class ServicesBottomBarScreen extends StatefulWidget {
  final int? initialIndex;
  const ServicesBottomBarScreen({super.key, required this.initialIndex});

  @override
  State<ServicesBottomBarScreen> createState() =>
      _ServicesBottomBarScreenState();

  static final List<Widget> _widgetOptions = <Widget>[
    const NewOrdersScreen(),
    OngoingOrdersScreen(),
    const CompletedOrdersScreen(),
    const ServicesScreen(),
    const MoreScreen(),
  ];
}

class _ServicesBottomBarScreenState extends State<ServicesBottomBarScreen> {
  @override
  void initState() {
    context
        .read<UpdatePushTokenCubit>()
        .updatePushNotificationToken();
    context.read<ProfileCubit>().fetchProfileData(false);
    context.read<ProfileVerficationCubit>().profileVerificationCheck();
    if (widget.initialIndex == null) {
      context.read<ServicesBottomBarCubit>().navigateToIndex(0);
    } else {
      context
          .read<ServicesBottomBarCubit>()
          .navigateToIndex(widget.initialIndex!);
      context
          .read<NotificationsDataCubit>()
          .featchNotifications(loadMoreData: true, seenStatus: "all");
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ServicesBottomBarCubit _servicesBottomBarCubit =
    //     BlocProvider.of<ServicesBottomBarCubit>(context);

    // final ProfileCubit _profileCubit = BlocProvider.of<ProfileCubit>(context);
    // context.read<ProfileCubit>().fetchProfileData();

    return BlocBuilder<ServicesBottomBarCubit, int>(
      builder: (context, currentIndex) {
        // _profileCubit.fetchProfileData();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: currentIndex == 4
              ? null
              : bottombarAppbarWidget(
                  // verficationCubit: ,
                  notificationOnTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const Notifications(),
                        ));
                  },
                  servicesBottomBarCubit:
                      context.read<ServicesBottomBarCubit>()),
          body: Center(
            child:
                ServicesBottomBarScreen._widgetOptions.elementAt(currentIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
                fontFamily: AppthemeColor().themeFont,
                color: AppthemeColor().appMainColor,
                fontWeight: FontWeight.w600,
                fontSize: 12),
            unselectedLabelStyle: TextStyle(
                fontFamily: AppthemeColor().themeFont,
                color: AppthemeColor().bottombatTitleColor,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: BlocBuilder<OrdersCountCubit, OrdersCountState>(
                    builder: (context, state) {
                      if (state.orderscount != null) {
                        if (state.orderscount!.newOrders != "0" &&
                            state.orderscount!.newOrders != 0) {
                          return Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 3, top: 3),
                                child: Image.asset(
                                  "assets/services_new/newtab.png",
                                  height: 22,
                                  width: 22,
                                  color: currentIndex == 0
                                      ? AppthemeColor().appMainColor
                                      : null,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor:
                                        AppthemeColor().greenButtonColor,
                                    child: CommonProximaNovaTextWidget(
                                      textAlign: TextAlign.center,
                                      text: state.orderscount!.newOrders
                                          .toString(),
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ))
                            ],
                          );
                        } else {
                          return Image.asset(
                            "assets/services_new/newtab.png",
                            height: 22,
                            width: 22,
                            color: currentIndex == 0
                                ? AppthemeColor().appMainColor
                                : null,
                          );
                        }
                      }

                      return Image.asset(
                        "assets/services_new/newtab.png",
                        height: 22,
                        width: 22,
                        color: currentIndex == 0
                            ? AppthemeColor().appMainColor
                            : null,
                      );
                    },
                  ),
                ),
                label: 'New',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(
                    "assets/services_new/ongoingtab.png",
                    height: 22,
                    width: 22,
                    color:
                        currentIndex == 1 ? AppthemeColor().appMainColor : null,
                  ),
                ),
                label: 'Ongoing',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(
                    "assets/services_new/completedtab.png",
                    height: 22,
                    width: 22,
                    color:
                        currentIndex == 2 ? AppthemeColor().appMainColor : null,
                  ),
                ),
                label: 'Completed',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(
                    "assets/services_new/servicestab.png",
                    height: 22,
                    width: 22,
                    color:
                        currentIndex == 3 ? AppthemeColor().appMainColor : null,
                  ),
                ),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(
                    "assets/services_new/moretab.png",
                    height: 22,
                    width: 22,
                    color:
                        currentIndex == 4 ? AppthemeColor().appMainColor : null,
                  ),
                ),
                label: 'More',
              ),
            ],
            currentIndex: currentIndex,
            selectedItemColor: AppthemeColor().appMainColor,
            unselectedItemColor: AppthemeColor().bottombatTitleColor,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: (index) {
              context.read<ServicesBottomBarCubit>().navigateToIndex(index);
            },
          ),
        );
      },
    );
  }
}
