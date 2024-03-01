import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/entrepreneurial_assessment.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';

class AssessmentAction {
  @override
  String toString() {
    return 'AssessmentAction { }';
  }
}

class AssessmentSuccessAction {
  final int isSuccess;

  AssessmentSuccessAction({required this.isSuccess});
  @override
  String toString() {
    return 'AssessmentSuccessAction { isSuccess: $isSuccess }';
  }
}

class AssessmentFailedAction {
  final String error;
  final type = "ASSESSMENT_FAILED_ACTION";
  AssessmentFailedAction({required this.error});

  @override
  String toString() {
    return 'AssessmentFailedAction { error: $error }';
  }
}

class GetEntreprenurialAssessmentAction {
  final type = 'GET_ENTREPRENURIAL_ASSESSMENT_ACTION';
  final UMKMUser user;

  GetEntreprenurialAssessmentAction({required this.user});
}

class GetEntreprenurialAssessmentSuccessAction {
  final type = 'GET_ENTREPRENURIAL_ASSESSMENT_SUCCESS_ACTION';
  final List<String> questions;
  final EntrepreneurialAssessment entAssessment;
  GetEntreprenurialAssessmentSuccessAction(
      {required this.questions, required this.entAssessment});
}

class GetCategoryAssessmentAction {
  final type = 'GET_CATEGORY_ASSESSMENT_ACTION';
  final UMKMUser user;

  GetCategoryAssessmentAction({required this.user});
}

class GetCategoryAssessmentSuccessAction {
  final type = 'GET_CATEGORY_ASSESSMENT_SUCCESS_ACTION';
  final dynamic categoryAssessment;

  GetCategoryAssessmentSuccessAction({required this.categoryAssessment});
}

class AddEntreprenurialAssessmentAction {
  final type = 'ADD_ENTREPRENURIAL_ASSESSMENT_ACTION';
  final List<String> assessment;
  final List<String> characteristic;
  final int score;
  final UMKMUser user;

  AddEntreprenurialAssessmentAction(
      {required this.assessment,
      required this.characteristic,
      required this.score,
      required this.user});
}

class AddEntreprenurialAssessmentSuccessAction {
  final type = 'ADD_ENTREPRENURIAL_ASSESSMENT_SUCCESS_ACTION';
  final dynamic payload;
  AddEntreprenurialAssessmentSuccessAction({required this.payload});
}

class AddBasicAssessmentAction {
  final type = 'ADD_BASIC_ASSESSMENT_ACTION';
  final int asset;
  final int revenue;
  final int production;
  final int permanentWorkers;
  final int nonPermanentWorkers;
  final UMKMStore store;

  AddBasicAssessmentAction(
      {required this.asset,
      required this.revenue,
      required this.production,
      required this.permanentWorkers,
      required this.nonPermanentWorkers,
      required this.store});
}

class AddBasicAssessmentSuccessAction {
  final type = 'ADD_BASIC_ASSESSMENT_SUCCESS_ACTION';
  final dynamic payload;
  AddBasicAssessmentSuccessAction({required this.payload});
}

class UpdateCategoryAssessmentAction {
  final type = 'UPDATE_CATEGORY_ASSESSMENT_ACTION';
  final UMKMUser user;
  final Map<String, dynamic> assessment;

  UpdateCategoryAssessmentAction(
      {required this.user, required this.assessment});
}

class UpdateCategoryAssessmentSuccessAction {
  final type = 'UPDATE_CATEGORY_ASSESSMENT_SUCCESS_ACTION';
  final dynamic payload;
  UpdateCategoryAssessmentSuccessAction({required this.payload});
}
