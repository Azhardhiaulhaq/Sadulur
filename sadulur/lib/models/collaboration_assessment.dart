class CollaborationAssessment {
  int numWorker;
  bool isWorkerFamily;
  int workingHour;

  CollaborationAssessment({
    required this.numWorker,
    required this.isWorkerFamily,
    required this.workingHour,
  });

  factory CollaborationAssessment.fromMap(Map<String, dynamic> data) {
    return CollaborationAssessment(
      numWorker: data['num_worker'] ?? 0,
      isWorkerFamily: data['is_worker_family'] == "Ya",
      workingHour: data['working_hour'] ?? 0,
    );
  }

  Map<String, dynamic> toDictionary() {
    return {
      'num_worker': numWorker,
      'is_worker_family': isWorkerFamily ? "Ya" : "Tidak",
      'working_hour': workingHour,
    };
  }

  // Empty constructor
  CollaborationAssessment.empty()
      : numWorker = 0,
        isWorkerFamily = false,
        workingHour = 0;

  // CopyWith method
  CollaborationAssessment copyWith({
    int? numWorker,
    bool? isWorkerFamily,
    int? workingHour,
  }) {
    return CollaborationAssessment(
      numWorker: numWorker ?? this.numWorker,
      isWorkerFamily: isWorkerFamily ?? this.isWorkerFamily,
      workingHour: workingHour ?? this.workingHour,
    );
  }

  int getScore() {
    int score = 0;
    if (numWorker > 10 && numWorker < 30) {
      score += 1;
    } else if (numWorker >= 30) {
      score += 2;
    }

    if (isWorkerFamily == false) {
      score += 1;
    }
    return score;
  }
}
