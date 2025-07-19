import 'package:flutter/material.dart';

import '../../../comman/common_text.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.network_check_rounded, color: Colors.black, size: 200),
          CommonProximaNovaTextWidget(
            text: 'YOUR INTERNET IS A LITTLE WONKY',
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 5),
          CommonProximaNovaTextWidget(
            text:
                'Try switching to a differnt connection or reset your internet!',
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ],
      )),
    );
  }
}
