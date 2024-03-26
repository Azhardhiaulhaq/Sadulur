class CollaborationAssessment {
  int numWorker;
  bool isWorkerFamily;
  int workingHour;
  int score;

  CollaborationAssessment({
    required this.numWorker,
    required this.isWorkerFamily,
    required this.workingHour,
    this.score = 0,
  });

  factory CollaborationAssessment.fromMap(Map<String, dynamic> data) {
    return CollaborationAssessment(
        numWorker: data['num_worker'] ?? 0,
        isWorkerFamily: data['is_worker_family'] == "Ya",
        workingHour: data['working_hour'] ?? 0,
        score: data['collaboration_score'] ?? 0);
  }

  Map<String, dynamic> toDictionary() {
    return {
      'num_worker': numWorker,
      'is_worker_family': isWorkerFamily ? "Ya" : "Tidak",
      'working_hour': workingHour,
      'collaboration_score': score
    };
  }

  // Empty constructor
  CollaborationAssessment.empty()
      : numWorker = 0,
        isWorkerFamily = false,
        score = 0,
        workingHour = 0;

  // CopyWith method
  CollaborationAssessment copyWith({
    int? numWorker,
    bool? isWorkerFamily,
    int? workingHour,
    int? score,
  }) {
    return CollaborationAssessment(
      numWorker: numWorker ?? this.numWorker,
      isWorkerFamily: isWorkerFamily ?? this.isWorkerFamily,
      workingHour: workingHour ?? this.workingHour,
      score: score ?? this.score,
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
