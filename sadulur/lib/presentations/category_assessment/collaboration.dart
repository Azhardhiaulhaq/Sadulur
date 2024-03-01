import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/models/collaboration_assessment.dart';
import 'package:sadulur/models/decision_making_assessment.dart';
import 'package:sadulur/presentations/widgets/form/custom_checkbox_group.dart';
import 'package:sadulur/presentations/widgets/form/custom_drop_down.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';

class Collaboration extends StatefulWidget {
  CollaborationAssessment assessment;
  Collaboration({super.key, required this.assessment});

  @override
  CollaborationState createState() => CollaborationState();
}

class CollaborationState extends State<Collaboration> {
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
                'Collaboration & Co-Value Creation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.numWorker.toString(),
                prefixIcon: const Icon(
                  Icons.work,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Jumlah Pekerta Tetap dan Tidak Tetap',
                labelText: '',
                hintText: 'Jumlah Pekerja',
                fieldName: 'num_worker',
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText: "Apakah pekerja merupakan keluarga?",
                labelText: widget.assessment.isWorkerFamily ? "Ya" : "Tidak",
                fieldName: 'is_worker_family',
                initialValue: "Tidak",
                items: ["Ya", "Tidak"],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.workingHour.toString(),
                prefixIcon: const Icon(
                  Icons.work,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Jumlah jam kerja dalam seminggu',
                labelText: '',
                hintText: 'working hour',
                fieldName: 'working_hour',
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
    logger.d(fields?["socmed"]?.value);
    CollaborationAssessment assessment = CollaborationAssessment(
        numWorker: int.parse(fields?['num_worker']?.value ?? "0"),
        isWorkerFamily: fields?['is_worker_family']?.value == "Ya",
        workingHour: int.parse(fields?["working_hour"]?.value ?? "0"));
    return {'value': assessment, 'score': assessment.getScore()};
  }
}
