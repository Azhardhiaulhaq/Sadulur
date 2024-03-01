import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreOverviewCard extends StatelessWidget {
  final UMKMStore store;
  const StoreOverviewCard({super.key, required this.store});

  Future<void> share(String phone, String message) async {
    var phoneNumber = '+$phone';
    // ignore: non_constant_identifier_names
    var whatsappURl_android =
        "whatsapp://send?phone=$phoneNumber&text=$message";
    if (await canLaunchUrl(whatsappURl_android as Uri)) {
      await launchUrl(whatsappURl_android as Uri);
    }
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(store.photoProfile ??
                                'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
                            minRadius: 30,
                            maxRadius: 60,
                            backgroundColor: AppColor.darkDatalab,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(store.umkmName ?? "No Given Store Name",
                                    style: CustomTextStyles.normalText(
                                        color: AppColor.textDatalab,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text("${store.city}, ${store.province}",
                                    style: CustomTextStyles.normalText(
                                        color: AppColor.black)),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.email,
                                      color: AppColor.textDatalab,
                                    ),
                                    const SizedBox(width: 8),
                                    //TODO: RESTORE EMAIL
                                    // Text(store.email,
                                    //     style: CustomTextStyles.normalText(
                                    //         color: AppColor.black)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: AppColor.textDatalab,
                                    ),
                                    const SizedBox(width: 8),
                                    Text("${store.phoneNumber}",
                                        style: CustomTextStyles.normalText(
                                            color: AppColor.black)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ])))));
  }
}
