import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class CustomCheckboxGroup extends StatelessWidget {
  final String labelText;
  final String name;
  final List<String>? initialValue;
  final List<String>? options;
  final Function(String?)? onSelectionChanged;

  const CustomCheckboxGroup(
      {super.key,
      this.initialValue,
      required this.labelText,
      required this.name,
      this.options,
      this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          maxLines: 2,
          style: CustomTextStyles.normalText(
              fontSize: 14, fontWeight: FontWeight.bold),
        ),
        FormBuilderCheckboxGroup(
          name: name,
          activeColor: AppColor.darkDatalab,
          focusColor: AppColor.secondaryTextDatalab,
          // validator: FormBuilderValidators.required(),
          // onChanged: onSelectionChanged,
          initialValue: initialValue ?? [],

          options: options
                  ?.map((lang) => FormBuilderFieldOption(
                        value: lang,
                        child: Text(
                          lang,
                          style: CustomTextStyles.normalText(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ))
                  .toList(growable: false) ??
              [],
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
