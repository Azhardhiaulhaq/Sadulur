import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class CircularProgressCard extends StatelessWidget {
  const CircularProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 150),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 50.0),
            color: AppColor.backgroundWhite,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: AppColor.darkDatalab)),
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColor.secondaryTextDatalab,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Loading...',
                      style: CustomTextStyles.appBarTitle2,
                    )
                  ],
                )),
          ),
        ));
  }
}
