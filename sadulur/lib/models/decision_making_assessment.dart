class DecisionMakingAssessment {
  String isUsedTech;
  String vendor;
  int numProduction;
  int numSupplier;
  bool isJoinCommunity;
  bool isHasCompetitor;
  int numCompetitor;
  int score;

  DecisionMakingAssessment(
      {required this.isUsedTech,
      required this.vendor,
      required this.numProduction,
      required this.numSupplier,
      required this.isJoinCommunity,
      required this.isHasCompetitor,
      required this.numCompetitor,
      this.score = 0});

  factory DecisionMakingAssessment.fromMap(Map<String, dynamic> data) {
    return DecisionMakingAssessment(
      isUsedTech: data['is_used_tech'] ?? "Manual",
      vendor: data['vendor'] ?? "Vendor",
      numProduction: data['num_production'] ?? 0,
      numSupplier: data['num_supplier'] ?? 0,
      isJoinCommunity: data['is_join_community'] == "Ya",
      isHasCompetitor: data['is_has_competitor'] == "Ya",
      numCompetitor: data['num_competitor'] ?? 0,
      score: data['decision_making_score'] ?? 0,
    );
  }

  Map<String, dynamic> toDictionary() {
    return {
      'is_used_tech': isUsedTech,
      'vendor': vendor,
      'num_production': numProduction,
      'num_supplier': numSupplier,
      'is_join_community': isJoinCommunity ? "Ya" : "Tidak",
      'is_has_competitor': isHasCompetitor ? "Ya" : "Tidak",
      'num_competitor': numCompetitor,
      'decision_making_score': score
    };
  }

  // Empty constructor
  DecisionMakingAssessment.empty()
      : isUsedTech = "Manual",
        vendor = "Vendor",
        numProduction = 0,
        numSupplier = 0,
        isJoinCommunity = false,
        isHasCompetitor = false,
        score = 0,
        numCompetitor = 0;

  // CopyWith method
  DecisionMakingAssessment copyWith(
      {String? isUsedTech,
      String? vendor,
      int? numProduction,
      int? numSupplier,
      bool? isJoinCommunity,
      bool? isHasCompetitor,
      int? numCompetitor,
      int? score}) {
    return DecisionMakingAssessment(
      isUsedTech: isUsedTech ?? this.isUsedTech,
      vendor: vendor ?? this.vendor,
      numProduction: numProduction ?? this.numProduction,
      numSupplier: numSupplier ?? this.numSupplier,
      isJoinCommunity: isJoinCommunity ?? this.isJoinCommunity,
      isHasCompetitor: isHasCompetitor ?? this.isHasCompetitor,
      numCompetitor: numCompetitor ?? this.numCompetitor,
      score: score ?? this.score,
    );
  }

  int getScore() {
    int score = 0;
    if (isUsedTech == "Teknologi") {
      score = score + 1;
    }
    if (vendor == "Vendor") {
      score = score + 1;
    }

    if (isJoinCommunity == true) {
      score = score + 1;
    }
    if (isHasCompetitor == true) {
      score = score + 1;
    }

    return score;
  }
}
