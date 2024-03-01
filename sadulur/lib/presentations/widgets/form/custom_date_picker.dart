import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class CustomDatePicker extends StatelessWidget {
  final String labelText;
  final String fieldName;
  final bool isRequired;
  final TextInputType keyboardType;
  final TextEditingController? controller; // Add controller parameter
  final Icon? suffixIcon;

  const CustomDatePicker({
    super.key,
    required this.labelText,
    required this.fieldName,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.controller, // Initialize the controller parameter
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: fieldName,
      controller: controller, // Pass the controller to FormBuilderTextField
      validator: isRequired
          ? FormBuilderValidators.required()
          : FormBuilderValidators.required(),
      style: CustomTextStyles.formText1,
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
    );
  }
}
