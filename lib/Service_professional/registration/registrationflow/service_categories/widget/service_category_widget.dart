import 'package:flutter/material.dart';

import '../../../../../widget/CustomWidget/DottedLinePainter.dart';
import '../../../../commons/shimmer_widgets/shimmer_data.dart';

class CategoriesLoadingWidget extends StatelessWidget {
  const CategoriesLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                      child: buildSimmer1(height: 25, width: double.infinity)),
                ],
              ),
            ),
        separatorBuilder: (context, index) => CustomPaint(
              painter: DottedLinePainter(),
              child: const SizedBox(
                width: double.infinity,
                height: 1.0,
              ),
            ),
        itemCount: 10);
  }
}
