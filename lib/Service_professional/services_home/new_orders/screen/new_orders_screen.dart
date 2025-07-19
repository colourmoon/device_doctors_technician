import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';
import 'package:device_doctors_technician/comman/common_text.dart';
import 'package:device_doctors_technician/widget/CustomWidget/Demo.dart';
import '../../../commons/common_button_widget.dart';
import '../../../notifications/logic/cubit/notifications_data_cubit.dart';
import '../../../registration/onboarding/sceeen/onboarding_screen.dart';
import '../../../registration/registrationflow/kyc_details/screens/kyc_screen.dart';
import '../../../registration/registrationflow/profile_verification/cubit/profile_verfication_cubit.dart';
import '../../../services_bottombar/logic/orderscountcubit/orders_count_cubit.dart';
import '../../more_tab/logic/cubit/logout_cubit.dart';
import '../../service_details/screen/service_details_screen.dart';
import '../logic/cubit/new_orders_cubit.dart';
import '../widget/new_order_widget.dart';

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({super.key});

  @override
  State<NewOrdersScreen> createState() => _NewOrdersScreenState();
}

class _NewOrdersScreenState extends State<NewOrdersScreen> {
  // late ProfileVerficationCubit verificationcubit;

  @override
  void initState() {
    // verificationcubit = ProfileVerficationCubit();
    // verificationcubit.profileVerificationCheck();
    context.read<ProfileVerficationCubit>().profileVerificationCheck();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileVerficationCubit, ProfileVerficationState>(
      listener: (context, verificationState) {
        if (verificationState.verificationModel != null) {
          if (verificationState.verificationModel!.vendorStatus.toString() !=
              "0") {
            context.read<OrdersCountCubit>().getOrdersCount();
            context.read<NewOrdersCubit>().fetchNewOrders(type: "new");
          }
        }

        if (verificationState.error == true) {
          context.read<LogoutCubit>().logoutapi();
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (context) => const ServicesOnboardingScreen(),
              ),
              (route) => false);
        }
        // TODO: implement listener
      },
      builder: (context, verificationState) {
        print(
            "verification model :${verificationState.verificationModel?.vendorStatus}");
        if (verificationState.verificationModel?.vendorStatus.toString() ==
            "0") {
          return Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<ProfileVerficationCubit>()
                    .profileVerificationCheck();
                context
                    .read<NotificationsDataCubit>()
                    .featchNotifications(loadMoreData: true, seenStatus: "all");
              },
              child: Center(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/services_new/verificationpending.png",
                          height: 170,
                          width: 170,
                        ),
                      ),
                      SizedBox(height: 15),
                      CommonProximaNovaTextWidget(
                        text: verificationState.verificationModel?.kycStatus
                                    .toString() ==
                                '0'
                            ? "Your Kyc is Pending"
                            : "Your Profile is\nUnder Verification!",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3),
                      CommonProximaNovaTextWidget(
                        text: "Please wait until our team\nverify your profile",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      if (verificationState.verificationModel?.kycStatus
                              .toString() ==
                          '0')
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CommonButtonWidget(
                            buttonwidth: 150,
                            buttontitle: "Update",
                            titlecolor: AppthemeColor().whiteColor,
                            buttonColor: AppthemeColor().appMainColor,
                            boardercolor: AppthemeColor().appMainColor,
                            buttonOnTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const KycDetails(canSkip: false),
                                  ));
                            },
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (verificationState.isLoading == true) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => OrdersLoadingWidget()),
          ));
        }
        return BlocConsumer<NewOrdersCubit, NewOrdersState>(
          listener: (context, state) {
            print("state emitted : ${state.newOrder},,,,${state.error}");
            if (state.acceptOrderSuccess != null) {
              print('success triggered');
              context.read<OrdersCountCubit>().getOrdersCount();
              context.read<NewOrdersCubit>().fetchNewOrders(type: "new");
            } else if (state.rejectOrderSuccess != null) {
              print('success triggered');
              context.read<OrdersCountCubit>().getOrdersCount();
              context.read<NewOrdersCubit>().fetchNewOrders(type: "new");
            } else if (state.acceptOrderFailed != null) {
              print('failed triggered');
              context.read<OrdersCountCubit>().getOrdersCount();
              context.read<NewOrdersCubit>().fetchNewOrders(type: "new");
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state.isLoading == true) {
              return Scaffold(
                  body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => OrdersLoadingWidget()),
              ));
            } else if (state.error != null &&
                state.error != "" &&
                state.error != "No Services") {
              print("eeeeeeeeeeeeeeeeeeeeeeeeeeee");
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProfileVerficationCubit>()
                      .profileVerificationCheck();
                  context.read<OrdersCountCubit>().getOrdersCount();
                  context.read<NewOrdersCubit>().fetchNewOrders(type: "new");
                  context.read<NotificationsDataCubit>().featchNotifications(
                      loadMoreData: true, seenStatus: "all");
                },
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: CommonProximaNovaTextWidget(
                        text: state.error ?? "",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    )),
              );
            } else if (state.error == "No Services") {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProfileVerficationCubit>()
                      .profileVerificationCheck();
                  context.read<OrdersCountCubit>().getOrdersCount();
                  context.read<NewOrdersCubit>().fetchNewOrders(type: "new");
                  context.read<NotificationsDataCubit>().featchNotifications(
                      loadMoreData: true, seenStatus: "all");
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/services_new/noorders.png",
                            height: 170,
                            width: 170,
                          ),
                        ),
                        15.ph,
                        CommonProximaNovaTextWidget(
                          text: "No Orders Yet!",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                        3.ph,
                        CommonProximaNovaTextWidget(
                          text:
                              "No Orders Yet Please wait\nfor some fantastic orders",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.newOrder == null) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProfileVerficationCubit>()
                      .profileVerificationCheck();
                  context.read<OrdersCountCubit>().getOrdersCount();
                  context.read<NewOrdersCubit>().fetchNewOrders(type: "new");
                  context.read<NotificationsDataCubit>().featchNotifications(
                      loadMoreData: true, seenStatus: "all");
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/services_new/noorders.png",
                            height: 170,
                            width: 170,
                          ),
                        ),
                        15.ph,
                        CommonProximaNovaTextWidget(
                          text: "No Orders Yet!",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                        3.ph,
                        CommonProximaNovaTextWidget(
                          text:
                              "No Orders Yet Please wait\nfor some fantastic orders",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
                backgroundColor: Colors.white,
                body: RefreshIndicator(
                  onRefresh: () async {
                    print("new orers refresh????");
                    context
                        .read<ProfileVerficationCubit>()
                        .profileVerificationCheck();
                    context.read<OrdersCountCubit>().getOrdersCount();
                    context.read<NewOrdersCubit>().fetchNewOrders(type: "new");
                    context.read<NotificationsDataCubit>().featchNotifications(
                        loadMoreData: true, seenStatus: "all");
                  },
                  color: AppthemeColor().themecolor,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.newOrder!.length,
                    itemBuilder: (context, index) => Builder(
                      builder: (context) {
                        print(state.newOrder?[index].device_details_updated);
                        return NewOrderWidget(
                          is_amc_subscription:state.newOrder?[index]. is_amc_subscription=='yes',
                          date: state.newOrder![index].serviceDate +
                              ", " +
                              state.newOrder![index].serviceTime,
                          itemsList: state.newOrder![index].serviceItems,
                          orderId: state.newOrder![index].sessionId,
                          price: state.newOrder![index].earnings.toString(),
                          buttonWidget: NewOrderButtonsWidget(
                              buttonHeight: 35,
                              acceptOnTap: () {
                                context.read<NewOrdersCubit>().acceptOrder(
                                    orderId: state.newOrder![index].orderId);
                              },
                              rejectOnTap: () {
                                context.read<NewOrdersCubit>().rejectOrder(
                                    orderId: state.newOrder![index].orderId);
                              }),
                          orderOnTapFun: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => OrderDetailsScreen(
                                      orderStatus: "new",
                                      orderId: state.newOrder![index].id),
                                )).then((value) {
                              print("poped from details screen");
                            });
                          },
                          device_details_updated:
                              state.newOrder?[index].device_details_updated == 'no' || state.newOrder?[index].device_details_updated  =='null', deviceBrand:
                        state.newOrder?[index].device_brand ??"", model_name:
                        state.newOrder?[index].model_name ??"", service_tag:
                        state.newOrder?[index].serial_number??'',
                        );
                      }
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
