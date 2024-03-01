import 'dart:core';

import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/entrepreneurial_assessment.dart';

class UserAssessment {
  // List<String> entrepreneuralAssessment;
  // List<String> basicAssessment;
  CategoryAssessment basicAssessment;
  EntrepreneurialAssessment entrepreneurialAssessment;
  UserAssessment(
      {
      // required this.entrepreneuralAssessment,
      required this.basicAssessment,
      required this.entrepreneurialAssessment});

  factory UserAssessment.empty() {
    return UserAssessment(
        // entrepreneuralAssessment: [],
        basicAssessment: CategoryAssessment.empty(),
        entrepreneurialAssessment: EntrepreneurialAssessment.empty());
  }
}
