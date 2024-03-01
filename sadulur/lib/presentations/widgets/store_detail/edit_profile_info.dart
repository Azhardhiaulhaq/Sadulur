import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/form/custom_row_text_field.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/presentations/widgets/store_detail/description_store_card.dart';
import 'package:sadulur/presentations/widgets/store_detail/overview_store_card.dart';

class EditInfoProfile extends StatefulWidget {
  const EditInfoProfile({super.key, required this.store, this.user});

  final UMKMStore store;
  final UMKMUser? user;

  @override
  _EditInfoProfileState createState() => _EditInfoProfileState();
}

// ignore: must_be_immutable
class _EditInfoProfileState extends State<EditInfoProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
            minHeight: 100.0, // Set the minimum height as needed
            minWidth: double.infinity),
        child: InkWell(
            onTap: () {},
            child: Card(
                elevation: 8.0,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Info Profile",
                            style: CustomTextStyles.normalText(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkDatalab),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Nama",
                            fieldName: "name",
                            hintText: "Nama Owner",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Umur",
                            fieldName: "age",
                            keyboardType: TextInputType.number,
                            hintText: "Umur Tahun Ini",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Pendidikan",
                            fieldName: "education",
                            hintText: "Pendidikan Terakhir Owner",
                          )
                        ])))));
  }
}
