import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/paddings.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_category_info.dart';
import 'package:sadulur/models/umkm_store.dart';

class MiniInformationWidget extends StatefulWidget {
  final UMKMCategoryInfo umkmInfo;
  final Color iconBackgroundColor;
  final Icon icon;
  const MiniInformationWidget(
      {Key? key,
      required this.umkmInfo,
      this.iconBackgroundColor = AppColor.backgroundGrey,
      this.icon = const Icon(Icons.house)
      // required this.dailyData,
      })
      : super(key: key);
  // final DailyInfoModel dailyData;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

int _value = 1;

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius:
            BorderRadius.circular(10), // Sets the radius for rounded corners
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.umkmInfo.category.toUpperCase(),
                      style: CustomTextStyles.normalText(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.darkDatalab)),
                  Text("${widget.umkmInfo.stores.length.toString()} Stores",
                      style: CustomTextStyles.normalText(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("")
                ],
              ),
            ),
            Positioned(
                top: 5, // Adjust the top position of the icon
                right: 5, // Adjust the right position of the icon
                child: Card(
                    elevation: 0,
                    color: widget.iconBackgroundColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.icon)),
          ],
        ),
      ),
    );
    // Container(
    //   padding: EdgeInsets.all(defaultPadding),
    //   decoration: BoxDecoration(
    //     color: Colors.blueGrey,
    //     borderRadius: const BorderRadius.all(Radius.circular(10)),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Container(
    //             padding: EdgeInsets.all(defaultPadding * 0.75),
    //             height: 40,
    //             width: 40,
    //             decoration: BoxDecoration(
    //               color: AppColor.sbmdarkBlue.withOpacity(0.1),
    //               borderRadius: const BorderRadius.all(Radius.circular(10)),
    //             ),
    //             child: Icon(
    //               Icons.trending_up,
    //               color: AppColor.sbmdarkBlue,
    //               size: 18,
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(right: 12.0),
    //             child: DropdownButton(
    //               icon: Icon(Icons.more_vert, size: 18),
    //               underline: SizedBox(),
    //               style: Theme.of(context).textTheme.button,
    //               value: _value,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("Daily"),
    //                   value: 1,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("Weekly"),
    //                   value: 2,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("Monthly"),
    //                   value: 3,
    //                 ),
    //               ],
    //               onChanged: (int? value) {
    //                 setState(() {
    //                   _value = value!;
    //                 });
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             "Halo",
    //             maxLines: 1,
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 8,
    //       ),
    //     ],
    //   ),
    // );
  }
}
