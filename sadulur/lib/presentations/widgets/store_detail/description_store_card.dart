import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreDescriptionCard extends StatelessWidget {
  final UMKMStore store;
  const StoreDescriptionCard({super.key, required this.store});

  void openLink(String url) async {
    Uri link = Uri.parse(url);
    if (await canLaunchUrl(link)) {
      await launchUrl(link);
    } else {
      logger.e('There was a problem to open the url: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
            minHeight: 100.0, // Set the minimum height as needed
            minWidth: double.infinity),
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
                      'Deskripsi Toko',
                      style: CustomTextStyles.normalText(
                          color: AppColor.textDatalab,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      store.description ?? "Deskripsi Belum Tersedia",
                      style: CustomTextStyles.normalText(color: AppColor.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Lokasi',
                      style: CustomTextStyles.normalText(
                          color: AppColor.textDatalab,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${store.address}, ${store.city}, ${store.province}",
                      style: CustomTextStyles.normalText(color: AppColor.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Sosial Media',
                      style: CustomTextStyles.normalText(
                          color: AppColor.textDatalab,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    store.instagram != null
                        ? Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(store.instagram!,
                                  style: CustomTextStyles.normalText(
                                      color: AppColor.black)),
                              icon: Icon(MdiIcons.instagram,
                                  color: Color(0xffE1306C), size: 30),
                              onPressed: () {
                                openLink(
                                    'https://www.instagram.com/${store.instagram}/');
                              },
                            ))
                        : Container(),
                    store.facebook != null
                        ? Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(store.facebook!,
                                  style: CustomTextStyles.normalText(
                                      color: AppColor.black)),
                              icon: Icon(MdiIcons.facebook,
                                  color: AppColor.blueFacebook, size: 30),
                              onPressed: () {
                                openLink(
                                    'https://www.facebook.com/${store.facebook}/');
                              },
                            ))
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'MarketPlace',
                      style: CustomTextStyles.normalText(
                          color: AppColor.textDatalab,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    store.tokopedia != null
                        ? Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(store.tokopedia!,
                                  style: CustomTextStyles.normalText(
                                      color: AppColor.black)),
                              icon: Image.asset("assets/tokopedia.png",
                                  width: 30, height: 30),
                              onPressed: () {
                                // StatisticRepository.updateStatistic(
                                //     id, 'tokopedia');
                                openLink(
                                    '${'https://www.tokopedia.com/${store.tokopedia}'}/');
                              },
                            ))
                        : Container(),
                    store.shopee != null
                        ? Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(store.shopee!,
                                  style: CustomTextStyles.normalText(
                                      color: AppColor.black)),
                              icon: Image.asset("assets/shopee.png",
                                  width: 30, height: 30),
                              onPressed: () {
                                // StatisticRepository.updateStatistic(
                                //     id, 'tokopedia');
                                openLink(
                                    '${'https://www.shopee.com/${store.shopee}'}/');
                              },
                            ))
                        : Container(),
                    store.bukalapak != null
                        ? Container(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              label: Text(store.bukalapak!,
                                  style: CustomTextStyles.normalText(
                                      color: AppColor.black)),
                              icon: Image.asset("assets/bukalapak.png",
                                  width: 30, height: 30),
                              onPressed: () {
                                // StatisticRepository.updateStatistic(
                                //     id, 'tokopedia');
                                openLink(
                                    '${'https://www.bukalapak.com/${store.bukalapak}'}/');
                              },
                            ))
                        : Container(),
                  ],
                ))));
  }
}
