import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class ForumTagCard extends StatelessWidget {
  final String tag;

  ForumTagCard({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.darkDatalab,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          tag,
          style: CustomTextStyles.tagText1,
        ),
      ),
    );
  }
}
