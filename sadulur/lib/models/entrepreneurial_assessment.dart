import 'dart:core';

class EntrepreneurialAssessment {
  String id;
  List<String> assessment;
  List<String> characteristics;
  int score;
  DateTime createdAt;

  EntrepreneurialAssessment(
      {required this.id,
      required this.assessment,
      required this.characteristics,
      required this.score,
      required this.createdAt});

  factory EntrepreneurialAssessment.fromMap(Map<String, dynamic> map) {
    return EntrepreneurialAssessment(
      id: map['id'] ?? '',
      assessment: List<String>.from(map['assessment'] ?? []),
      characteristics: List<String>.from(map['characteristics'] ?? []),
      score: map['score'] ?? 0,
      createdAt: map['createdAt'].toDate(),
    );
  }

  factory EntrepreneurialAssessment.empty() {
    return EntrepreneurialAssessment(
      id: '',
      assessment: [],
      characteristics: [],
      score: 0,
      createdAt: DateTime.now(),
    );
  }

  EntrepreneurialAssessment copyWith({
    String? id,
    List<String>? assessment,
    List<String>? characteristics,
    int? score,
    DateTime? createdAt,
  }) {
    return EntrepreneurialAssessment(
      id: id ?? this.id,
      assessment: assessment ?? this.assessment,
      characteristics: characteristics ?? this.characteristics,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
