import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class CustomRowTextField extends StatelessWidget {
  final String labelText;
  final String fieldName;
  final bool isRequired;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Icon? prefixIcon;
  final String? hintText;

  const CustomRowTextField({
    Key? key,
    required this.labelText,
    required this.fieldName,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.maxLines = 1,
    this.validator,
    this.isPassword = false,
    this.hintText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            labelText,
            style: CustomTextStyles.normalText(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColor.darkDatalab,
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Flexible(
            flex: 5,
            // Add Flexible widget to allow the field to expand
            child: FormBuilderTextField(
              name: fieldName,
              controller: controller,
              validator: validator,
              style: CustomTextStyles.formText1,
              maxLines: maxLines,
              keyboardType: keyboardType,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                prefixIcon: prefixIcon,
                fillColor: Colors.white,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.backgroundGrey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.darkDatalab, width: 1.2),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.deadlineRed),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.deadlineRed, width: 1.2),
                ),
              ),
            )),
      ],
    );
  }
}
