import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/presentations/widgets/form/custom_drop_down.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';

class BusinessFeasability extends StatefulWidget {
  BusinessFeasabilityAssessment assessment;
  BusinessFeasability({super.key, required this.assessment});

  @override
  BusinessFeasabilityState createState() => BusinessFeasabilityState();
}

class BusinessFeasabilityState extends State<BusinessFeasability> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        color: Colors.white,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Business Feasibility Analysis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText: "Aset bisnis = Aset pribadi pemilik bisnis",
                labelText: '',
                fieldName: 'business_asset',
                initialValue: widget.assessment.businessAsset ? "Ya" : "Tidak",
                items: const ["Ya", "Tidak"],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                titleText: "Total Aset (Rp)",
                initialValue: widget.assessment.totalAsset.toString(),
                labelText: '',
                prefixIcon: Icon(
                  MdiIcons.cash,
                  color: AppColor.darkDatalab,
                ),
                hintText: 'Total owned assets in Rupiah',
                fieldName: 'total_asset',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.liquidAsset.toString(),
                prefixIcon: Icon(
                  MdiIcons.cash,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Total Aset Likuid (Rp)',
                labelText: '',
                hintText: 'Total owned liquid assets in Rupiah',
                fieldName: 'liquid_asset',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.text,
                initialValue: widget.assessment.nonLiquidAsset,
                maxLines: 3,
                titleText: 'Aset Tidak Likuid',
                labelText: '',
                hintText: 'Tuliskan semua aset tidak likuid yang dimiliki',
                fieldName: 'non_liquid_asset',
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                  titleText: 'Pembukuan secara Berkala',
                  labelText: '',
                  fieldName: 'is_periodic_accounting',
                  initialValue:
                      widget.assessment.isPeriodicAccounting ? "Ya" : "Tidak",
                  items: const ["Ya", "Tidak"]),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                  titleText: 'Periode Pembukuan',
                  labelText: '',
                  fieldName: 'period_accounting',
                  initialValue: widget.assessment.periodAccounting,
                  items: const ["Harian", "Bulanan", "Tahunan"]),
              const SizedBox(height: 16),
              CustomTextField(
                  titleText: 'Total Omset setiap tahun (Rp)',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(
                    MdiIcons.cash,
                    color: AppColor.darkDatalab,
                  ),
                  initialValue: widget.assessment.totalRevenue.toString(),
                  labelText: '',
                  hintText: 'Total omset setiap tahun dalam rupiah',
                  fieldName: 'total_revenue'),
              const SizedBox(
                height: 16,
              ),
              CustomGroupDropdown(
                  titleText: 'Owner mendapatkan gaji bulanan',
                  labelText: '',
                  fieldName: 'is_owner_get_salary',
                  initialValue:
                      widget.assessment.isOwnerGetSalary ? "Ya" : "Tidak",
                  items: const ["Ya", "Tidak"]),
              const SizedBox(height: 16),
              CustomTextField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.assessment.ownerSalary.toString(),
                  titleText: 'Gaji Owner per Bulan (Rp)',
                  labelText: '',
                  hintText: 'Gaji Owner setiap bulan',
                  fieldName: 'owner_salary'),
              const SizedBox(
                height: 16,
              ),
              const CustomGroupDropdown(
                  titleText: 'Karyawan mendapatkan gaji bulanan',
                  labelText: '',
                  fieldName: 'is_employee_get_salary',
                  initialValue: "Tidak",
                  items: ["Ya", "Tidak"]),
              const SizedBox(height: 16),
              CustomTextField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.assessment.employeeSalary.toString(),
                  titleText: 'Gaji Karyawan per Bulan (Rp)',
                  labelText: '',
                  hintText: 'Gaji Karyawan setiap bulan',
                  fieldName: 'employee_salary'),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                  titleText: 'Mencampurkan hasil bisnis dengan rumah tangga',
                  labelText: '',
                  fieldName: 'is_mixed',
                  initialValue: widget.assessment.isMixed ? "Ya" : "Tidak",
                  items: const ["Ya", "Tidak"]),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> getFormValues() {
    formKey.currentState?.save();
    var fields = formKey.currentState?.fields;

    BusinessFeasabilityAssessment assessment = BusinessFeasabilityAssessment(
      businessAsset: fields?['business_asset']?.value == "Ya",
      totalAsset: int.parse(fields?['total_asset']?.value ?? "0"),
      liquidAsset: int.parse(fields?['liquid_asset']?.value ?? "0"),
      nonLiquidAsset: fields?['non_liquid_asset']?.value ?? "",
      isPeriodicAccounting: fields?['is_periodic_accounting']?.value == "Ya",
      periodAccounting: fields?['period_accounting']?.value ?? "Harian",
      totalRevenue: int.parse(
        fields?['total_revenue']?.value ?? "0",
      ),
      isOwnerGetSalary: fields?['is_owner_get_salary']?.value == "Ya",
      ownerSalary: int.parse(fields?['owner_salary']?.value ?? "0"),
      isEmployeeGetSalary: fields?['is_employee_get_salary']?.value == "Ya",
      employeeSalary: int.parse(fields?['employee_salary']?.value ?? "0"),
      isMixed: fields?['is_mixed']?.value == "Ya",
    );
    return {'value': assessment, 'score': assessment.getScore()};
  }
}
