import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/presentations/widgets/custom_clipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: -pi / 4.5,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColor.darkDatalab, AppColor.darkDatalab])),
        ),
      ),
    ));
  }
}
