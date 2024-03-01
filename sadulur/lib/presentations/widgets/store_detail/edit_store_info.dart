import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/form/custom_row_text_field.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/presentations/widgets/store_detail/description_store_card.dart';
import 'package:sadulur/presentations/widgets/store_detail/overview_store_card.dart';

class EditInfoStore extends StatefulWidget {
  const EditInfoStore({super.key, required this.store, this.user});

  final UMKMStore store;
  final UMKMUser? user;

  @override
  _EditInfoStoreState createState() => _EditInfoStoreState();
}

// ignore: must_be_immutable
class _EditInfoStoreState extends State<EditInfoStore> {
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
                            "Info Store",
                            style: CustomTextStyles.normalText(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkDatalab),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Nama Toko",
                            fieldName: "umkmName",
                            hintText: "Nama Toko UMKM",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Nomor Telepon",
                            fieldName: "phoneNumber",
                            keyboardType: TextInputType.phone,
                            hintText: "Nomor Telepon yang dapat dihubungi",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Deskripsi",
                            fieldName: "description",
                            maxLines: 3,
                            hintText: "Deskripsi UMKM",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "UMKM Address",
                            style: CustomTextStyles.normalText(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkDatalab),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Alamat Toko",
                            fieldName: "address",
                            maxLines: 2,
                            hintText: "Alamat Fisik UMKM",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Kota",
                            fieldName: "city",
                            hintText: "Kota UMKM Berada",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Provinsi",
                            fieldName: "province",
                            hintText: "Provinsi Tempat UMKM Berada",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Marketplace",
                            style: CustomTextStyles.normalText(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkDatalab),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Tokopedia",
                            fieldName: "tokopediaName",
                            hintText: "Username toko di Tokopedia",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Shopee",
                            fieldName: "shopeeName",
                            hintText: "Username toko di Shopee",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Bukalapak",
                            fieldName: "bukalapakName",
                            hintText: "Username toko di Bukalapak",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Social Media",
                            style: CustomTextStyles.normalText(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkDatalab),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Instagram",
                            fieldName: "instagramAcc",
                            hintText: "Username Instagram",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomRowTextField(
                            labelText: "Facebook",
                            fieldName: "facebookAcc",
                            hintText: "Username Facebook",
                          ),
                        ])))));
  }
}
