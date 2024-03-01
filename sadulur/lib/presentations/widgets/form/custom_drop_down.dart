import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class CustomGroupDropdown<T> extends StatelessWidget {
  final Function(T?)? onChanged;
  final List<T> items;
  final String labelText;
  final String fieldName;
  final Icon? suffixIcon;
  final T? initialValue;
  final String? titleText;

  const CustomGroupDropdown(
      {super.key,
      required this.labelText,
      required this.fieldName,
      this.onChanged,
      required this.items,
      this.initialValue,
      this.suffixIcon,
      this.titleText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText != null
            ? Text(
                titleText!,
                maxLines: 2,
                style: CustomTextStyles.normalText(
                    fontSize: 14, fontWeight: FontWeight.bold),
              )
            : Container(),
        const SizedBox(
          height: 6,
        ),
        FormBuilderDropdown<T>(
          name: fieldName,
          initialValue: initialValue,
          decoration: InputDecoration(
              labelText: labelText,
              filled: true,
              fillColor: Colors.white, // Set your desired background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColor.backgroundGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: AppColor.darkDatalab, width: 1.2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColor.deadlineRed),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: AppColor.deadlineRed, width: 1.2),
              ),
              suffixIcon: suffixIcon ?? suffixIcon),
          items: items
              .map((group) => DropdownMenuItem(
                    value: group,
                    child: Text(group.toString()),
                  ))
              .toList(),
          onChanged: onChanged,
        )
      ],
    );
  }
}
