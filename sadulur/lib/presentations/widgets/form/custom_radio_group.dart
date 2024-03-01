import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class CustomRadioGroup extends StatelessWidget {
  final String labelText;
  final String name;
  final String? initialValue;
  final Function(String?) onSelectionChanged;

  const CustomRadioGroup(
      {super.key,
      this.initialValue,
      required this.labelText,
      required this.name,
      required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          maxLines: 3,
          style: CustomTextStyles.normalText(
              color: AppColor.darkDatalab, fontSize: 14),
        ),
        FormBuilderRadioGroup(
          name: name,
          activeColor: AppColor.darkDatalab,
          focusColor: AppColor.secondaryTextDatalab,
          validator: FormBuilderValidators.required(),
          onChanged: onSelectionChanged,
          initialValue: initialValue ?? '1',
          options: [
            '1',
            '2',
            '3',
            '4',
            '5',
          ]
              .map((lang) => FormBuilderFieldOption(value: lang))
              .toList(growable: false),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
