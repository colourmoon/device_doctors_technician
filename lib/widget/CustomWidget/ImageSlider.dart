// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// class ImageSlider extends StatefulWidget {
//   ImageSlider({Key? key, required this.imgList,required this.enlargeFactor,this.height,required this.borderRadius}) : super(key: key);
//   List imgList;
//   double enlargeFactor;
//   double? height;
//   double borderRadius;
//
//   @override
//   State<ImageSlider> createState() => _ImageSliderState();
// }
//
// class _ImageSliderState extends State<ImageSlider> {
//   int changeValue= 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider(
//           items: widget.imgList
//               .map((item) => ClipRRect(
//                     borderRadius:   BorderRadius.all(
//                       Radius.circular(widget.borderRadius),
//                     ),
//                     child: Image.asset(
//                       item,
//                       fit: BoxFit.cover,
//                       width: 1000,
//                     ),
//                   ))
//               .toList(),
//           options: CarouselOptions(
//             onPageChanged: (index, reason) {
//               setState(() {
//                 changeValue = index;
//               });
//             },
//             viewportFraction: 1,
//               enlargeFactor: widget.enlargeFactor!,
//               height: widget.height
//           ),
//         ),
//
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Center(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   for (int i = 0; i < 5; i++) ...[
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 2),
//                       child: Container(
//                         height: changeValue == i ? 8 : 6,
//                         width: changeValue == i ? 8 : 6,
//                         decoration: BoxDecoration(
//                             color: changeValue == i
//                                 ? const Color(0xff52A628)
//                                 : const Color(0xffE0E0E0),
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//                   ]
//                 ],
//               )),
//         ),
//       ],
//     );
//   }
// }
