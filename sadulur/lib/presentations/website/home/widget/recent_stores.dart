import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/paddings.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/recent_stores.dart';
import 'package:sadulur/models/umkm_store.dart';

class RecentStores extends StatelessWidget {
  final List<UMKMStore> stores;
  const RecentStores({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: const [
                  DataColumn(
                    label: Text("Nama UMKM"),
                  ),
                  DataColumn(
                    label: Text("Level"),
                  ),
                  DataColumn(
                    label: Text("No Telpon"),
                  ),
                  DataColumn(
                    label: Text("Email"),
                  ),
                ],
                rows: List.generate(
                  stores.length,
                  (index) => recentUserDataRow(stores[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentUserDataRow(UMKMStore store, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            TextAvatar(
              size: 35,
              backgroundColor: Colors.white,
              textColor: Colors.white,
              fontSize: 14,
              upperCase: true,
              numberLetters: 1,
              shape: Shape.Rectangle,
              text: store.umkmName,
            ),
            // CircleAvatar(
            //   foregroundImage: NetworkImage(store.photoProfile ??
            //       'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
            //   maxRadius: 20,
            //   backgroundColor: AppColor.darkDatalab,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                store.umkmName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: AppColor.secondaryTextDatalab,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(store.level, style: CustomTextStyles.tagText1),
        ),
      ),
      // DataCell(Padding(
      //   padding: EdgeInsets.symmetric(vertical: 10),
      //   child: Wrap(
      //       alignment: WrapAlignment.start,
      //       spacing: 2,
      //       runSpacing: 2,
      //       children: [
      //         ...store.tags.take(3).map((tag) {
      //           return Container(
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      //             margin: const EdgeInsets.symmetric(horizontal: 4),
      //             decoration: BoxDecoration(
      //               color: AppColor.darkDatalab,
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //             child: Text(
      //               tag,
      //               style: CustomTextStyles.tagText1,
      //             ),
      //           );
      //         })
      //       ]),
      // )),
      DataCell(Text(store.phoneNumber ?? "Tidak ada No Telpon")),
      DataCell(Text(store.email != "" ? store.email! : "Tidak ada Email")),
      // DataCell(
      //   Row(
      //     children: [
      //       TextButton(
      //         child: Text('View', style: TextStyle(color: Colors.greenAccent)),
      //         onPressed: () {},
      //       ),
      //       SizedBox(
      //         width: 6,
      //       ),
      //       TextButton(
      //         child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
      //         onPressed: () {
      //           showDialog(
      //               context: context,
      //               builder: (_) {
      //                 return AlertDialog(
      //                     title: Center(
      //                       child: Column(
      //                         children: [
      //                           Icon(Icons.warning_outlined,
      //                               size: 36, color: Colors.red),
      //                           SizedBox(height: 20),
      //                           Text("Confirm Deletion"),
      //                         ],
      //                       ),
      //                     ),
      //                     content: Container(
      //                       color: Colors.amber,
      //                       height: 70,
      //                       child: Column(
      //                         children: [
      //                           Text(
      //                               "Are you sure want to delete '${userInfo.name}'?"),
      //                           SizedBox(
      //                             height: 16,
      //                           ),
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               ElevatedButton.icon(
      //                                   icon: Icon(
      //                                     Icons.close,
      //                                     size: 14,
      //                                   ),
      //                                   style: ElevatedButton.styleFrom(
      //                                       backgroundColor: Colors.grey),
      //                                   onPressed: () {
      //                                     Navigator.of(context).pop();
      //                                   },
      //                                   label: Text("Cancel")),
      //                               SizedBox(
      //                                 width: 20,
      //                               ),
      //                               ElevatedButton.icon(
      //                                   icon: Icon(
      //                                     Icons.delete,
      //                                     size: 14,
      //                                   ),
      //                                   style: ElevatedButton.styleFrom(
      //                                       backgroundColor: Colors.red),
      //                                   onPressed: () {},
      //                                   label: Text("Delete"))
      //                             ],
      //                           )
      //                         ],
      //                       ),
      //                     ));
      //               });
      //         },
      //         // Delete
      //       ),
      //     ],
      //   ),
      // ),
    ],
  );
}
