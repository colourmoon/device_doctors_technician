// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';

import '../logic/cubit/notifications_data_cubit.dart';
import 'notifications_list_screen.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int index = 0;

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffECECEC),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          actions: [
            BlocConsumer<NotificationsDataCubit, NotificationsDataState>(
              listener: (context, state) {


              },
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: PopupMenuButton<String>(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          onTap: () {
                            context
                                .read<NotificationsDataCubit>()
                                .markAsReadNotificationRead(index == 2
                                    ? "unread"
                                    : index == 1
                                        ? "read"
                                        : 'all')
                                .then((dynamic value) {
                            });
                          },
                          height: 24,
                          value: 'option1',
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.black,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5.6,
                              ),
                              Text(
                                'Mark all as Read',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // PopupMenuItem<String>(
                        //   height: 0.5,
                        //   value: 'option3',
                        //   child: Container(
                        //     height: 0.5,
                        //     color: const Color(0xff888899),
                        //   ),
                        // ),
                        // const PopupMenuItem<String>(
                        //   height: 24,
                        //   value: 'option2',
                        //   child: Row(
                        //     children: [
                        //       // ImageIcon(
                        //       //   AssetImage('assets/assets/images/Profile.png'),
                        //       //   color: Colors.black,
                        //       //   size: 14,
                        //       // ),
                        //       Icon(
                        //         Icons.settings,
                        //         color: Colors.grey,
                        //         size: 16,
                        //       ),
                        //       SizedBox(
                        //         width: 4,
                        //       ),
                        //       Text(
                        //         'Notification Settings',
                        //         style: TextStyle(
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ];
                    },
                    shadowColor: Colors.black.withOpacity(0.5),
                    elevation: 8,
                    constraints:
                        const BoxConstraints(maxHeight: 65, maxWidth: 145),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none,
                    ),
                    position: PopupMenuPosition.under,
                    onSelected: (String value) {
                      switch (value) {
                        case 'option1':
                          break;
                        case 'option2':
                          break;
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffECECEC),
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
          title: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: AppthemeColor().themeFont,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  onTap: (int itemIndex) {
                    setState(() {
                      index = itemIndex;
                    });
                  },
                  automaticIndicatorColorAdjustment: false,
                  indicatorWeight: 0.2,
                  indicatorColor: Colors.transparent,
                  labelStyle: const TextStyle(),
                  unselectedLabelStyle: const TextStyle(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  indicatorPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  tabs: [
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        // width: 60,
                        height: 28,
                        decoration: ShapeDecoration(
                          color: index == 0
                              ? const Color(0xff223DFE)
                              : const Color(0xFFd2d2d2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: index == 0
                                  ? Colors.white
                                  : const Color(0xff9c9c9c),
                              fontSize: 12,
                              fontFamily: AppthemeColor().themeFont,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 28,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: index == 1
                              ? const Color(0xff223DFE)
                              : const Color(0xFFd2d2d2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'Read',
                            style: TextStyle(
                              color: index == 1
                                  ? Colors.white
                                  : const Color(0xff9c9c9c),
                              fontSize: 12,
                              fontFamily: AppthemeColor().themeFont,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        // width: 60,
                        height: 28,
                        decoration: ShapeDecoration(
                          color: index == 2
                              ? const Color(0xff223DFE)
                              : const Color(0xFFd2d2d2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'Unread',
                            style: TextStyle(
                              color: index == 2
                                  ? Colors.white
                                  : const Color(0xff9c9c9c),
                              fontSize: 12,
                              fontFamily: AppthemeColor().themeFont,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // ListView.separated(
                  //   shrinkWrap: true,
                  //   physics: const BouncingScrollPhysics(),
                  //   itemCount: Mydata.length,
                  //   itemBuilder: (context, index) {
                  //     return Row(
                  //       children: [
                  //         15.pw,
                  //         Container(
                  //           width: 45,
                  //           height: 45,
                  //           decoration: const ShapeDecoration(
                  //             shape: OvalBorder(side: BorderSide(width: 1)),
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(10.0),
                  //             child: Image.asset(
                  //                 Mydata['item${index + 1}']['image']),
                  //           ),
                  //         ),
                  //         8.pw,
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             SizedBox(
                  //               width: 19,
                  //               child: Text(
                  //                 Mydata['item${index + 1}']['name'],
                  //                 style: const TextStyle(
                  //                   color: AppthemeColor().themecolor,
                  //                   fontSize: 8,
                  //                   fontFamily:
                  //                       ApplicationColours.manropeFontFamily,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //             ),
                  //             Text(
                  //               Mydata['item${index + 1}']['title'],
                  //               style: const TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 12,
                  //                 fontFamily: ApplicationColours.manropeFontFamily,
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //             3.ph,
                  //             SizedBox(
                  //               width: 196,
                  //               child: Text(
                  //                 Mydata['item${index + 1}']['subtitle'],
                  //                 style: const TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 10,
                  //                   fontFamily:
                  //                       ApplicationColours.manropeFontFamily,
                  //                   fontWeight: FontWeight.w400,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         const Spacer(),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             const Text(
                  //               'yesterday',
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 8,
                  //                 fontFamily: ApplicationColours.manropeFontFamily,
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ),
                  //             20.ph,
                  //             !Mydata['item${index + 1}']['seen']
                  //                 ? Container(
                  //                     width: 10,
                  //                     height: 10,
                  //                     decoration: const ShapeDecoration(
                  //                       color: AppthemeColor().themecolor,
                  //                       shape: OvalBorder(),
                  //                     ),
                  //                   )
                  //                 : Container()
                  //           ],
                  //         ),
                  //         11.pw
                  //       ],
                  //     );
                  //   },
                  //   separatorBuilder: (context, index) => Padding(
                  //     padding: const EdgeInsets.only(
                  //         top: 12, bottom: 10, left: 15, right: 15),
                  //     child: Container(
                  //       width: double.infinity,
                  //       decoration: const ShapeDecoration(
                  //         shape: RoundedRectangleBorder(
                  //           side: BorderSide(
                  //             width: 0.25,
                  //             strokeAlign: BorderSide.strokeAlignCenter,
                  //             color: Color(0xFF969696),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  NotificationsListScreen(status: 'all'),
                  NotificationsListScreen(status: 'read'),
                  NotificationsListScreen(status: 'unread'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
