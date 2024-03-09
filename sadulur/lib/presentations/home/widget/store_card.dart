import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_store.dart';

class UMKMStoreCard extends StatelessWidget {
  final UMKMStore store;
  const UMKMStoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100.0, // Set the minimum height as needed
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/store', arguments: {'id': store.id});
          },
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(store.photoProfile ??
                          'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
                      minRadius: 10,
                      maxRadius: 20,
                      backgroundColor: AppColor.darkDatalab,
                    ),
                    title: Text(
                      store.umkmName ?? "No Given Store Name",
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: AppColor.darkDatalab,
                          fontWeight:
                              FontWeight.w700, // You can adjust the font weight
                          fontSize: 16.0, // Adjust the font size if needed
                        ),
                      ),
                    ),
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "[${store.level}] - ",
                    //         style: GoogleFonts.lato(
                    //           textStyle: TextStyle(
                    //             color: _getColorForLevel(store.level),
                    //             fontWeight: FontWeight
                    //                 .w700, // You can adjust the font weight
                    //             fontSize:
                    //                 16.0, // Adjust the font size if needed
                    //           ),
                    //         ),
                    //       ),
                    //       Text(
                    //         store.umkmName ?? "No Given Store Name",
                    //         maxLines: 2,
                    //         overflow: TextOverflow.fade,
                    //         style: GoogleFonts.lato(
                    //           textStyle: const TextStyle(
                    //             color: AppColor.darkDatalab,
                    //             fontWeight: FontWeight
                    //                 .w700, // You can adjust the font weight
                    //             fontSize:
                    //                 16.0, // Adjust the font size if needed
                    //           ),
                    //         ),
                    //       ),
                    //     ]),
                    subtitle: Text(
                        "${store.address ?? "No Given Address"}, ${store.city}, ${store.province}",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: AppColor.darkGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0))),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(store.description ?? "No Given Description",
                      maxLines: 2,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: AppColor.darkDatalab,
                              fontSize: 14,
                              fontWeight: FontWeight.normal))),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      iconInfo(Icons.phone, AppColor.darkGreen,
                          store.phoneNumber ?? "No Given Phone Number"),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: AppColor.secondaryTextDatalab,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:
                            Text(store.level, style: CustomTextStyles.tagText1),
                      ),
                      ...store.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: AppColor.darkDatalab,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag,
                            style: CustomTextStyles.tagText1,
                          ),
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Color _getColorForLevel(String level) {
    switch (level) {
      case "medium":
        return AppColor.darkGreen;
      case "micro":
        return AppColor.darkRed;
      case "small":
        return AppColor.darkOrange;
      default:
        return Colors.black; // Default color if level doesn't match any case
    }
  }

  Widget iconInfo(IconData icon, Color iconColor, String info) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8.0),
        Text(
          info,
          style: const TextStyle(
            color: AppColor.darkDatalab,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
