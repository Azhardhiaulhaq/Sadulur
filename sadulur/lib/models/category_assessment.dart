import 'dart:core';

import 'package:sadulur/models/business_communication_assessment.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/models/collaboration_assessment.dart';
import 'package:sadulur/models/decision_making_assessment.dart';

class CategoryAssessment {
  String id;
  BusinessCommunicationAssessment businessComm;
  BusinessFeasabilityAssessment businessFeas;
  CollaborationAssessment collaboration;
  DecisionMakingAssessment decisionMaking;
  DateTime createdAt;

  CategoryAssessment(
      {required this.id,
      required this.businessComm,
      required this.businessFeas,
      required this.collaboration,
      required this.decisionMaking,
      required this.createdAt});

  // factory CategoryAssessment.fromMap(Map<String, dynamic> data, String id) {
  //   return CategoryAssessment(
  //     formality: data["formality"] ?? "",
  //     organisation: data["organisation"] ?? "",
  //     usedWorkers: data["usedWorkers"] ?? "",
  //     genderOwner: data["genderOwner"] ?? "",
  //     marketOrientation: data["marketOrientation"] ?? "",
  //     motivation: data["motivation"] ?? "",
  //     productionProcess: data["productionProcess"] ?? "",
  //     profileOwner: data["profileOwner"] ?? "",
  //     spirit: data["spirit"] ?? "",
  //     techUsed: data["techUsed"] ?? "",
  //     createdAt: DateTime.parse(data['createdAt'] ?? ''),
  //     id: id,
  //   );
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is CategoryAssessment &&
  //       other.id == id &&
  //       other.formality == formality &&
  //       other.organisation == organisation &&
  //       other.usedWorkers == usedWorkers &&
  //       other.productionProcess == productionProcess &&
  //       other.marketOrientation == marketOrientation &&
  //       other.profileOwner == profileOwner &&
  //       other.techUsed == techUsed &&
  //       other.genderOwner == genderOwner &&
  //       other.motivation == motivation &&
  //       other.spirit == spirit;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //       formality.hashCode ^
  //       organisation.hashCode ^
  //       usedWorkers.hashCode ^
  //       productionProcess.hashCode ^
  //       marketOrientation.hashCode ^
  //       profileOwner.hashCode ^
  //       techUsed.hashCode ^
  //       genderOwner.hashCode ^
  //       motivation.hashCode ^
  //       spirit.hashCode;
  // }

  factory CategoryAssessment.empty() {
    return CategoryAssessment(
      businessComm: BusinessCommunicationAssessment.empty(),
      businessFeas: BusinessFeasabilityAssessment.empty(),
      collaboration: CollaborationAssessment.empty(),
      decisionMaking: DecisionMakingAssessment.empty(),
      createdAt: DateTime.now(),
      id: '',
    );
  }

  CategoryAssessment copyWith({
    BusinessCommunicationAssessment? businessComm,
    BusinessFeasabilityAssessment? businessFeas,
    CollaborationAssessment? collaboration,
    DecisionMakingAssessment? decisionMaking,
    String? id,
    DateTime? createdAt,
  }) =>
      CategoryAssessment(
          id: id ?? this.id,
          businessComm: businessComm ?? this.businessComm,
          businessFeas: businessFeas ?? this.businessFeas,
          collaboration: collaboration ?? this.collaboration,
          decisionMaking: decisionMaking ?? this.decisionMaking,
          createdAt: createdAt ?? this.createdAt);
}
