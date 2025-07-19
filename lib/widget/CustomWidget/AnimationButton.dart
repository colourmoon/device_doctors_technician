// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:device_doctors_technician/utility/sharedPref.dart';

// import '../../Food-Restuarnt/HomeScreen/logic/home_screen_bloc.dart';
// import '../../Food-Restuarnt/HomeScreen/repository/home_screen_repository.dart';

// class AnimationButton extends StatefulWidget {
//   AnimationButton(
//       {Key? key,
//       required this.isChecked,
//       this.firstText = '',
//       this.secondText = '',
//       this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//       this.offColor = appThemeColor,
//       this.onColor = const Color(0xffFF0000),
//       this.style = const TextStyle(
//         color: Colors.white,
//         fontSize: 14,
//         fontFamily: 'Poppins',
//         fontWeight: FontWeight.w500,
//       ),
//       this.textPadding = const EdgeInsets.only(left: 5, right: 5, top: 2)})
//       : super(key: key);
//   TextStyle style;
//   bool isChecked;
//   String firstText;
//   String secondText;
//   Color onColor;
//   Color offColor;
//   EdgeInsetsGeometry padding;
//   EdgeInsetsGeometry textPadding;

//   @override
//   _AnimationButtonState createState() => _AnimationButtonState();
// }

// class _AnimationButtonState extends State<AnimationButton>
//     with SingleTickerProviderStateMixin {
//   final Duration _duration = Duration(milliseconds: 370);
//   late Animation<Alignment> _animation;
//   late AnimationController _animationController;
//   String? accessToken;
//   @override
//   void initState() {
//     super.initState();
//     accessToken = SharedPref().getString("access_token").toString();
//     _animationController =
//         AnimationController(vsync: this, duration: _duration);
//     _animation =
//         AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
//             .animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.bounceOut,
//         reverseCurve: Curves.bounceIn,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return Center(
//           child: GestureDetector(
//             onTap: () {
//               HomeScreenBloc(homeScreenRepository: HomeScreenRepository())
//                 ..add(UserStatus(isOnline: widget.isChecked.toString()));
//               setState(() {
//                 if (_animationController.isCompleted) {
//                   _animationController.reverse();
//                 } else {
//                   _animationController.forward();
//                 }
//                 widget.isChecked = !widget.isChecked;
//               });
//             },
//             child: Container(
//               width: 80,
//               height: 30,
//               padding: widget.padding,
//               decoration: BoxDecoration(
//                 color: widget.isChecked ? widget.offColor : widget.onColor,
//                 borderRadius: BorderRadius.all(Radius.circular(40)),
//               ),
//               child: Stack(
//                 children: <Widget>[
//                   Align(
//                     alignment: _animation.value,
//                     child: Container(
//                       width: 20,
//                       height: 20,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: _animation.value == Alignment.centerLeft
//                         ? Alignment.centerRight
//                         : Alignment.centerLeft,
//                     child: Padding(
//                       padding: widget.textPadding,
//                       child: Text(
//                         widget.isChecked ? widget.secondText : widget.firstText,
//                         style: widget.style,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
