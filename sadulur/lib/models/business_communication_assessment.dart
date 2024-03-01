class BusinessCommunicationAssessment {
  String platform;
  List<String> socialMedia;
  bool isHostedEvent;
  String listBuyers;
  int numBuyer;
  bool isComplained;
  String complaint;
  bool hasLoyalBuyer;
  int numLoyalBuyer;
  int transactionFrequency;

  BusinessCommunicationAssessment({
    required this.platform,
    required this.socialMedia,
    required this.isHostedEvent,
    required this.listBuyers,
    required this.numBuyer,
    required this.isComplained,
    required this.complaint,
    required this.hasLoyalBuyer,
    required this.numLoyalBuyer,
    required this.transactionFrequency,
  });

  factory BusinessCommunicationAssessment.fromMap(Map<String, dynamic> data) {
    return BusinessCommunicationAssessment(
      platform: data['platform'] ?? "Offline",
      socialMedia: List<String>.from(data['socmed'] ?? []),
      isHostedEvent: data['is_hosted_event'] == "Ya",
      listBuyers: data['list_buyers'] ?? "",
      numBuyer: data['num_buyer'] ?? 0,
      isComplained: data['is_complained'] == "Ya",
      complaint: data['complaint'] ?? "",
      hasLoyalBuyer: data['has_loyal_buyer'] == "Ya",
      numLoyalBuyer: data['num_loyal_buyer'] ?? 0,
      transactionFrequency: data['transaction_frequency'] ?? 0,
    );
  }

  Map<String, dynamic> toDictionary() {
    return {
      'platform': platform,
      'socmed': socialMedia,
      'is_hosted_event': isHostedEvent ? "Ya" : "Tidak",
      'list_buyers': listBuyers,
      'num_buyer': numBuyer,
      'is_complained': isComplained ? "Ya" : "Tidak",
      'complaint': complaint,
      'has_loyal_buyer': hasLoyalBuyer ? "Ya" : "Tidak",
      'num_loyal_buyer': numLoyalBuyer,
      'transaction_frequency': transactionFrequency,
    };
  }

  // Empty constructor
  BusinessCommunicationAssessment.empty()
      : platform = "Offline",
        socialMedia = [],
        isHostedEvent = false,
        listBuyers = "",
        numBuyer = 0,
        isComplained = false,
        complaint = "",
        hasLoyalBuyer = false,
        numLoyalBuyer = 0,
        transactionFrequency = 0;

  // CopyWith method
  BusinessCommunicationAssessment copyWith({
    String? platform,
    List<String>? socialMedia,
    bool? isHostedEvent,
    String? listBuyers,
    int? numBuyer,
    bool? isComplained,
    String? complaint,
    bool? hasLoyalBuyer,
    int? numLoyalBuyer,
    int? transactionFrequency,
  }) {
    return BusinessCommunicationAssessment(
      platform: platform ?? this.platform,
      socialMedia: socialMedia ?? this.socialMedia,
      isHostedEvent: isHostedEvent ?? this.isHostedEvent,
      listBuyers: listBuyers ?? this.listBuyers,
      numBuyer: numBuyer ?? this.numBuyer,
      isComplained: isComplained ?? this.isComplained,
      complaint: complaint ?? this.complaint,
      hasLoyalBuyer: hasLoyalBuyer ?? this.hasLoyalBuyer,
      numLoyalBuyer: numLoyalBuyer ?? this.numLoyalBuyer,
      transactionFrequency: transactionFrequency ?? this.transactionFrequency,
    );
  }

  int getScore() {
    int score = 0;
    if (platform == "Offline atau Online") {
      score += 1;
    } else if (platform == "Keduanya") {
      score += 2;
    }

    if (isHostedEvent == true) {
      score += 1;
    }

    if (isComplained == true) {
      score += 1;
    }
    if (hasLoyalBuyer == true) {
      score += 1;
    }

    return score;
  }
}
