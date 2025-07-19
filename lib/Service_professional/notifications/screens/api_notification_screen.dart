// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:loadmore/loadmore.dart';
// import 'package:device_doctors_technician/utility/constant/application_colours.dart';
// import 'package:device_doctors_technician/utility/constant/assets_images.dart';
// import 'package:device_doctors_technician/widgets/custom_sized_box.dart';
// import 'package:device_doctors_technician/widgets/theme_spinner.dart';

// import '../logic/bloc/notifications_bloc.dart';

// class NotificatinsScreenData extends StatefulWidget {
//   final String status;
//   const NotificatinsScreenData({super.key, required this.status});

//   @override
//   State<NotificatinsScreenData> createState() => _NotificatinsScreenDataState();
// }

// class _NotificatinsScreenDataState extends State<NotificatinsScreenData> {
//   int start = 1;

//   Future<int> loadMoreData() async {
//     if (mounted) {
//       setState(() {
//         start = start + 1;
//       });
//     }
//     return start;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     context.read<NotificationsBloc>().add(NotificationsFetchingEvent(
//         start: '1',
//         seenstatus: widget.status,
//         existingNotificationsList: const [],
//         from: 'init'));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ApplicationColours.whiteColor,
//       body: BlocConsumer<NotificationsBloc, NotificationsState>(
//         listener: (context, state) {
//           // TODO: implement listener
//           if (state is NotificationsSeenSuccesState) {
//             context.read<NotificationsBloc>().add(NotificationsFetchingEvent(
//                 start: '1',
//                 seenstatus: widget.status,
//                 existingNotificationsList: const [],
//                 from: 'init'));
//           }
//         },
//         builder: (context, state) {
//           if (state is NotificationsSuccessState) {
//             return LoadMore(
//               textBuilder: (status) {
//                 return '';
//               },
//               isFinish: (int.parse(state.startPage) + 1) >=
//                   int.parse(state.totalCount),
//               onLoadMore: () async {
//                 // int start1 = await loadMoreData();
//                 context.read<NotificationsBloc>().add(
//                     NotificationsFetchingEvent(
//                         start: (int.parse(state.startPage) + 1).toString(),
//                         seenstatus: widget.status,
//                         existingNotificationsList: state.notificationsList,
//                         from: ''));

//                 // context.read<NotificationsBloc>()
//                 //   ..add(JobsFetchingEvent(
//                 //       from: "",
//                 //       page: start1.toString(),
//                 //       existingJobsList: state.jobsList)
//                 //       );
//                 return true;
//               },
//               child: state.notificationsList.isEmpty
//                   ? Center(
//                       child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(SVGAssetsImages.noOrders),
//                         Text("No Notification Yet",
//                             style: GoogleFonts.poppins(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500)),
//                       ],
//                     ))
//                   : ListView.separated(
//                       shrinkWrap: true,
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: state.notificationsList.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () {
//                             if (state.notificationsList[index].seenStatus ==
//                                 'SEEN') {
//                               return;
//                             } else {
//                               context.read<NotificationsBloc>().add(
//                                   NotificationSeenEvent(
//                                       id: state.notificationsList[index].id));
//                               print(
//                                   "id is -- ${state.notificationsList[index].id}");
//                             }
//                           },
//                           child: Row(
//                             children: [
//                               8.pw,
//                               15.ph,
//                               state.notificationsList[index].type == "Completed"
//                                   ? Container(
//                                       height: 40,
//                                       width: 40,
//                                       decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: ApplicationColours.blackColor),
//                                       child: const Icon(Icons.notifications,
//                                           color: Colors.white),
//                                     )
//                                   : Container(
//                                       height: 40,
//                                       width: 40,
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: ApplicationColours.greenColor),
//                                       child: const Icon(Icons.notifications,
//                                           color: Colors.white),
//                                     ),
//                               8.pw,
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.5,
//                                     child: Text(
//                                       state.notificationsList[index].comment,
//                                       style: GoogleFonts.manrope(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Spacer(),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     state.notificationsList[index].displayTime,
//                                     style: GoogleFonts.manrope(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   10.ph,
//                                   // !Mydata['item${index + 1}']['seen']
//                                   //     ?
//                                   state.notificationsList[index].seenStatus ==
//                                           "NOT_SEEN"
//                                       ? Container(
//                                           width: 10,
//                                           height: 10,
//                                           decoration: const ShapeDecoration(
//                                             color: ApplicationColours.mainColor,
//                                             shape: OvalBorder(),
//                                           ),
//                                         )
//                                       : const SizedBox.shrink()
//                                 ],
//                               ),
//                               11.pw
//                             ],
//                           ),
//                         );
//                       },
//                       separatorBuilder: (context, index) => Padding(
//                         padding: const EdgeInsets.only(
//                             top: 12, bottom: 10, left: 15, right: 15),
//                         child: Container(
//                           width: double.infinity,
//                           decoration: const ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(
//                                 width: 0.25,
//                                 strokeAlign: BorderSide.strokeAlignCenter,
//                                 color: Color(0xFF969696),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//             );
//           }
//           return const Center(
//             child: ThemeSpinner(
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
