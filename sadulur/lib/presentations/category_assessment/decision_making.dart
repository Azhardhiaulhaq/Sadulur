import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/models/decision_making_assessment.dart';
import 'package:sadulur/presentations/widgets/form/custom_drop_down.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';

class DecisionMaking extends StatefulWidget {
  DecisionMakingAssessment assessment;
  DecisionMaking({super.key, required this.assessment});

  @override
  DecisionMakingState createState() => DecisionMakingState();
}

class DecisionMakingState extends State<DecisionMaking> {
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
                'Decision Making Analysis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText: "Apakah menggunakan teknologi saat proses produksi",
                labelText: '',
                fieldName: 'is_used_tech',
                initialValue: widget.assessment.isUsedTech,
                items: const ["Manual", "Teknologi"],
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText: "Menggunakan vendor / Produksi sendiri?",
                labelText: '',
                fieldName: 'vendor',
                initialValue: widget.assessment.vendor,
                items: const ["Produksi Sendiri", "Vendor"],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.numProduction.toString(),
                prefixIcon: Icon(
                  MdiIcons.factoryIcon,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Jumlah produksi per Minggu',
                labelText: '',
                hintText: 'Jumlah Produksi',
                fieldName: 'num_production',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.numSupplier.toString(),
                prefixIcon: Icon(
                  MdiIcons.basketFill,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Jumlah Supplier',
                labelText: '',
                hintText: 'Jumlah Supplier',
                fieldName: 'num_supplier',
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText: "Apakah mengikuti komunitas penjual?",
                labelText: '',
                fieldName: 'is_join_community',
                initialValue:
                    widget.assessment.isJoinCommunity ? "Ya" : "Tidak",
                items: const ["Ya", "Tidak"],
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText:
                    "Apakah memiliki kenalan yang menjual barang serupa?",
                labelText: '',
                fieldName: 'is_has_competitor',
                initialValue:
                    widget.assessment.isHasCompetitor ? "Ya" : "Tidak",
                items: const ["Ya", "Tidak"],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.numCompetitor.toString(),
                prefixIcon: Icon(
                  MdiIcons.faceManOutline,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Jumlah kenalan yang menjual barang serupa',
                labelText: '',
                hintText: 'Jumlah kenalan yang menjual barang serupa',
                fieldName: 'num_competitor',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> getFormValues() {
    formKey.currentState?.save();
    var fields = formKey.currentState?.fields;
    DecisionMakingAssessment assessment = DecisionMakingAssessment(
        isUsedTech: fields?['is_used_tech']?.value ?? "Manual",
        vendor: fields?['vendor']?.value ?? "Vendor",
        numProduction: int.parse(fields?['num_production']?.value ?? "0"),
        numSupplier: int.parse(fields?['num_supplier']?.value ?? "0"),
        isJoinCommunity: fields?['is_join_community']?.value == "Ya",
        isHasCompetitor: fields?['is_has_competitor']?.value == "Ya",
        numCompetitor: int.parse(fields?['num_competitor']?.value ?? "0"));
    return {'value': assessment, 'score': assessment.getScore()};
  }
}
