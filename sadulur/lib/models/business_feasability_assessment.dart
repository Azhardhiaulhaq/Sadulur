import 'dart:core';

import 'package:sadulur/main.dart';

class BusinessFeasabilityAssessment {
  bool businessAsset;
  int totalAsset;
  int liquidAsset;
  String nonLiquidAsset;
  bool isPeriodicAccounting;
  String periodAccounting;
  int totalRevenue;
  bool isOwnerGetSalary;
  int ownerSalary;
  bool isEmployeeGetSalary;
  int employeeSalary;
  bool isMixed;

  BusinessFeasabilityAssessment(
      {required this.businessAsset,
      required this.totalAsset,
      required this.liquidAsset,
      required this.nonLiquidAsset,
      required this.isPeriodicAccounting,
      required this.periodAccounting,
      required this.totalRevenue,
      required this.isOwnerGetSalary,
      required this.ownerSalary,
      required this.isEmployeeGetSalary,
      required this.employeeSalary,
      required this.isMixed});

  factory BusinessFeasabilityAssessment.fromMap(Map<String, dynamic> data) {
    return BusinessFeasabilityAssessment(
      businessAsset: data['business_asset'] == "Ya",
      totalAsset: data['total_asset'] ?? 0,
      liquidAsset: data['liquid_asset'] ?? 0,
      nonLiquidAsset: data['non_liquid_asset'] ?? "",
      isPeriodicAccounting: data['is_periodic_accounting'] == "Ya",
      periodAccounting: data['period_accounting'] ?? "Harian",
      totalRevenue: data['total_revenue'] ?? 0,
      isOwnerGetSalary: data['is_owner_get_salary'] == "Ya",
      isEmployeeGetSalary: data['is_employee_get_salary'] == "Ya",
      isMixed: data['is_mixed'] == "Ya",
      ownerSalary: data['owner_salary'] ?? 0,
      employeeSalary: data['employee_salary'] ?? 0,
    );
  }
  Map<String, dynamic> toDictionary() {
    return {
      'business_asset': businessAsset ? "Ya" : "Tidak",
      'total_asset': totalAsset,
      'liquid_asset': liquidAsset,
      'non_liquid_asset': nonLiquidAsset,
      'is_periodic_accounting': isPeriodicAccounting ? "Ya" : "Tidak",
      'period_accounting': periodAccounting,
      'total_revenue': totalRevenue,
      'is_owner_get_salary': isOwnerGetSalary ? "Ya" : "Tidak",
      'is_employee_get_salary': isEmployeeGetSalary ? "Ya" : "Tidak",
      'is_mixed': isMixed ? "Ya" : "Tidak",
      'owner_salary': ownerSalary,
      'employee_salary': employeeSalary
    };
  }

  int getScore() {
    int score = 0;
    if (businessAsset == false) {
      score = score + 1;
    }
    if (liquidAsset >= 50000000 && liquidAsset <= 500000000) {
      score = score + 1;
    } else if (liquidAsset > 500000000) {
      score = score + 2;
    }

    if (isPeriodicAccounting == true) {
      score = score + 1;
    }
    if (totalRevenue >= 300000000 && liquidAsset <= 2500000000) {
      score = score + 1;
    } else if (liquidAsset > 2500000000) {
      score = score + 2;
    }

    if (isOwnerGetSalary == true) {
      score = score + 1;
    }

    if (isEmployeeGetSalary == true) {
      score = score + 1;
    }

    if (isMixed == false) {
      score = score + 1;
    }

    return score;
  }

  // Empty constructor
  BusinessFeasabilityAssessment.empty()
      : businessAsset = false,
        totalAsset = 0,
        liquidAsset = 0,
        nonLiquidAsset = '',
        isPeriodicAccounting = false,
        periodAccounting = '',
        isOwnerGetSalary = false,
        ownerSalary = 0,
        isEmployeeGetSalary = false,
        employeeSalary = 0,
        isMixed = false,
        totalRevenue = 0;

  // CopyWith method
  BusinessFeasabilityAssessment copyWith(
      {bool? businessAsset,
      int? totalAsset,
      int? liquidAsset,
      String? nonLiquidAsset,
      bool? isPeriodicAccounting,
      String? periodAccounting,
      int? totalRevenue,
      bool? isOwnerGetSalary,
      int? ownerSalary,
      bool? isEmployeeGetSalary,
      int? employeeSalary,
      bool? isMixed}) {
    return BusinessFeasabilityAssessment(
        businessAsset: businessAsset ?? this.businessAsset,
        totalAsset: totalAsset ?? this.totalAsset,
        liquidAsset: liquidAsset ?? this.liquidAsset,
        nonLiquidAsset: nonLiquidAsset ?? this.nonLiquidAsset,
        isPeriodicAccounting: isPeriodicAccounting ?? this.isPeriodicAccounting,
        periodAccounting: periodAccounting ?? this.periodAccounting,
        totalRevenue: totalRevenue ?? this.totalRevenue,
        isOwnerGetSalary: isOwnerGetSalary ?? this.isOwnerGetSalary,
        ownerSalary: ownerSalary ?? this.ownerSalary,
        isEmployeeGetSalary: isEmployeeGetSalary ?? this.isEmployeeGetSalary,
        employeeSalary: employeeSalary ?? this.employeeSalary,
        isMixed: isMixed ?? this.isMixed);
  }
}
