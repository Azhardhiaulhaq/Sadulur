import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String fieldName;
  final bool isRequired;
  final TextInputType keyboardType;
  final TextEditingController? controller; // Add controller parameter
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Icon? prefixIcon;
  final String? hintText;
  final String? initialValue;
  final void Function(String?)? onSubmitted;
  final String? titleText;

  const CustomTextField(
      {super.key,
      required this.labelText,
      required this.fieldName,
      this.isRequired = false,
      this.keyboardType = TextInputType.text,
      this.controller, // Initialize the controller parameter
      this.maxLines = 1,
      this.validator,
      this.isPassword = false,
      this.hintText,
      this.prefixIcon,
      this.initialValue,
      this.onSubmitted,
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
        FormBuilderTextField(
          name: fieldName,
          controller: controller, // Pass the controller to FormBuilderTextField
          validator: validator,
          style: CustomTextStyles.formText1,
          maxLines: maxLines,
          keyboardType: keyboardType,
          obscureText: isPassword,
          onSubmitted: onSubmitted,
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            filled: true,
            prefixIcon: prefixIcon,
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
          ),
        )
      ],
    );
  }
}
