// // ignore_for_file: must_be_immutable
//
// import 'package:flutter/material.dart';
//
// class ImageSliders extends StatelessWidget {
//   Color dotIndicatorColor;
//   Color defaultDotIndicatorColor;
//   Color backgroundColor;
//   int imageLength;
//   List image;
//   double imageBottomLeft;
//   double imageBottomRight;
//   double imageTopRight;
//   double imageTopLeft;
//   double cardBottomLeft;
//   double cardBottomRight;
//   double cardTopRight;
//   double cardTopLeft;
//   double height;
//   double width;
//   double viewportFraction;
//   double imageHorizontalPadding;
//   double imageVerticalPadding;
//   double imageLeftPadding;
//
//   ImageSliders({
//     Key? key,
//     required this.imageLength,
//     required this.image,
//     required this.height,
//     required this.width,
//     this.dotIndicatorColor = Colors.black,
//     this.defaultDotIndicatorColor = Colors.green,
//     this.backgroundColor = Colors.white,
//     this.imageBottomLeft = 0.0,
//     this.imageBottomRight = 0.0,
//     this.imageTopRight = 0.0,
//     this.imageTopLeft = 0.0,
//     this.cardBottomLeft = 0.0,
//     this.cardBottomRight = 0.0,
//     this.cardTopRight = 0.0,
//     this.cardTopLeft = 0.0,
//     this.viewportFraction = 1.0,
//     this.imageHorizontalPadding = 0.0,
//     this.imageVerticalPadding = 0.0,
//     this.imageLeftPadding = 0.0,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final blocProvider = context.read<ImageSliderCubit>();
//     int changeValue = 0;
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(cardBottomLeft),
//           bottomRight: Radius.circular(cardBottomRight),
//         ),
//         color: backgroundColor,
//       ),
//       height: height,
//       width: width,
//       child: Column(
//         children: [
//           SizedBox(
//             height: height - 20,
//             child: PageView.builder(
//               controller: PageController(
//                 viewportFraction: viewportFraction,
//               ),
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               padEnds: false,
//               itemCount: imageLength,
//               onPageChanged: (value) {
//                 changeValue = value;
//                 blocProvider.addSlide(value);
//               },
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.only(
//                       left: index == 0 ? imageLeftPadding : 0, right: 0),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: imageHorizontalPadding,
//                         vertical: imageVerticalPadding),
//                     child: Container(
//                       height: 150,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(imageBottomLeft),
//                             bottomRight: Radius.circular(imageBottomRight),
//                             topRight: Radius.circular(imageTopRight),
//                             topLeft: Radius.circular(imageTopLeft),
//                           ),
//                           image: DecorationImage(
//                               image: AssetImage(image[index]),
//                               fit: BoxFit.cover)),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           BlocBuilder<ImageSliderCubit, int>(
//             builder: (context, state) {
//               return Center(
//                   child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   for (int i = 0; i < imageLength; i++) ...[
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 2),
//                       child: Container(
//                         height: changeValue == i ? 8 : 6,
//                         width: changeValue == i ? 8 : 6,
//                         decoration: BoxDecoration(
//                             color: changeValue == i
//                                 ? dotIndicatorColor
//                                 : defaultDotIndicatorColor,
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//                   ]
//                 ],
//               ));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
