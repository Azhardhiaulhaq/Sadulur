import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/business_communication_assessment.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/models/decision_making_assessment.dart';
import 'package:sadulur/presentations/widgets/form/custom_checkbox_group.dart';
import 'package:sadulur/presentations/widgets/form/custom_drop_down.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';

class BusinessCommunication extends StatefulWidget {
  BusinessCommunicationAssessment assessment;
  BusinessCommunication({super.key, required this.assessment});

  @override
  BusinessCommunicationState createState() => BusinessCommunicationState();
}

class BusinessCommunicationState extends State<BusinessCommunication> {
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
                'Business Communication',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText: "Platform penjualan",
                labelText: '',
                fieldName: 'platform',
                initialValue: widget.assessment.platform,
                items: const ["Offline", "Offline atau Online", "Keduanya"],
              ),
              const SizedBox(height: 16),
              CustomCheckboxGroup(
                labelText: "Social Media",
                name: "socmed",
                initialValue: widget.assessment.socialMedia,
                options: const [
                  "Instagram",
                  "Facebook",
                  "Whatsapp",
                  "E-Commerce",
                  "Lainnya"
                ],
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText:
                    "Apakah penah membuat kegiatan khusus untuk menarik pembeli?",
                labelText: '',
                fieldName: 'is_hosted_event',
                initialValue: widget.assessment.isHostedEvent ? "Ya" : "Tidak",
                items: const ["Ya", "Tidak"],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.text,
                initialValue: widget.assessment.listBuyers,
                maxLines: 2,
                titleText: 'Siapa saja pembelinya?',
                labelText: '',
                hintText: 'List Pembeli',
                fieldName: 'list_buyers',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.numBuyer.toString(),
                prefixIcon: const Icon(
                  Icons.sell_rounded,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Jumlah pembeli per minggu',
                labelText: '',
                hintText: 'Jumlah Pembeli',
                fieldName: 'num_buyer',
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText: "Pernah mendapatkan komplain ?",
                labelText: '',
                fieldName: 'is_complained',
                initialValue: widget.assessment.isComplained ? "Ya" : "Tidak",
                items: const ["Ya", "Tidak"],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.text,
                initialValue: widget.assessment.complaint,
                maxLines: 3,
                titleText: 'Komplain yang pernah didapatkan',
                labelText: '',
                hintText: 'komplain yang pernah didapatkan',
                fieldName: 'complaint',
              ),
              const SizedBox(height: 16),
              CustomGroupDropdown(
                titleText: "Apakah punya pembeli loyal?",
                labelText: '',
                fieldName: 'has_loyal_buyer',
                initialValue: widget.assessment.hasLoyalBuyer ? "Ya" : "Tidak",
                items: const ["Ya", "Tidak"],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.numLoyalBuyer.toString(),
                prefixIcon: const Icon(
                  Icons.sell_rounded,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Jumlah pembeli loyal',
                labelText: '',
                hintText: 'Jumlah Pembeli loyal',
                fieldName: 'num_loyal_buyer',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                keyboardType: TextInputType.number,
                initialValue: widget.assessment.transactionFrequency.toString(),
                prefixIcon: const Icon(
                  Icons.sell_rounded,
                  color: AppColor.darkDatalab,
                ),
                titleText: 'Seberapa sering pembeli membeli dalam 1 Minggu',
                labelText: '',
                hintText: 'frekuensi transaksi',
                fieldName: 'transaction_frequency',
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
    BusinessCommunicationAssessment assessment =
        BusinessCommunicationAssessment(
            platform: fields?["platform"]?.value ?? "Offline",
            socialMedia: List<String>.from(fields?['socmed']?.value ?? []),
            isHostedEvent: fields?['is_hosted_event']?.value == "Ya",
            listBuyers: fields?['list_buyers']?.value ?? "",
            numBuyer: int.parse(fields?['num_buyer']?.value ?? "0"),
            isComplained: fields?['is_complained']?.value == "Ya",
            complaint: fields?['complaint']?.value ?? "",
            hasLoyalBuyer: fields?['has_loyal_buyer']?.value == "Ya",
            numLoyalBuyer: int.parse(fields?['num_loyal_buyer']?.value ?? "0"),
            transactionFrequency:
                int.parse(fields?['transaction_frequency']?.value ?? "0"));

    return {'value': assessment, 'score': assessment.getScore()};
  }
}
