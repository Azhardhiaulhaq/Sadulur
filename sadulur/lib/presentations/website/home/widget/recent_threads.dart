import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/paddings.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/presentations/store_detail.dart';

class RecentThreads extends StatefulWidget {
  final List<ForumPost> posts;
  const RecentThreads({super.key, required this.posts});

  @override
  // ignore: library_private_types_in_public_api
  _RecentThreadsState createState() => _RecentThreadsState();
}

class _RecentThreadsState extends State<RecentThreads> {
  int _pageSize = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Theme(
            data: Theme.of(context).copyWith(
              cardTheme: CardTheme(
                elevation: 0, // remove shadow
                color: AppColor.white,
                margin: const EdgeInsets.all(0), // reset margin
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Change radius
                ),
              ),
            ),
            child: PaginatedDataTable(
                showCheckboxColumn: false,
                horizontalMargin: 0,
                rowsPerPage: _pageSize,
                availableRowsPerPage: const [5, 10, 15],
                showEmptyRows: false,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _pageSize = value!;
                  });
                },
                columnSpacing: defaultPadding,
                columns: const [
                  DataColumn(
                    label: Text("Title"),
                  ),
                  DataColumn(
                    label: Text("Author"),
                  ),
                  DataColumn(
                    label: Text("Views"),
                  ),
                  DataColumn(
                    label: Text("Comments"),
                  ),
                  DataColumn(
                    label: Text("Tags"),
                  ),
                ],
                source: _DataSource(context: context, data: widget.posts)),
          ),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<ForumPost> data;
  final BuildContext context;
  _DataSource({required this.data, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      key: ValueKey(item.postID),
      onSelectChanged: (value) {},
      color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return AppColor.backgroundGrey.withOpacity(0.5);
        }
        return AppColor.white;
      }),
      cells: [
        DataCell(Text(item.title)),

        DataCell(Text(item.author)),
        DataCell(Text(item.views.toString())),
        DataCell(Text(item.comments.toString())),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 4, // Adjust spacing between tags as needed
                children: item.tags.map((tag) => _buildTag(tag)).toList(),
              ),
            ],
          ),
        ),
        // DataCell(
        //   Row(
        //     children: [
        //       CircleAvatar(
        //         foregroundImage: NetworkImage(item.photoProfile ??
        //             'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
        //         maxRadius: 20,
        //         backgroundColor: AppColor.darkDatalab,
        //       ),
        //       Expanded(
        //         // Wrap the Text widget with Expanded
        //         child: Padding(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: defaultPadding),
        //           child: Text(
        //             item.umkmName!,
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // DataCell(
        //   Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        //     margin: const EdgeInsets.symmetric(horizontal: 4),
        //     decoration: BoxDecoration(
        //       color: AppColor.secondaryTextDatalab,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Text(item.level, style: CustomTextStyles.tagText1),
        //   ),
        // ),
        // DataCell(Text(item.phoneNumber ?? "Tidak ada No Telpon")),
        // DataCell(Text(item.email != "" ? item.email! : "Tidak ada Email")),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: AppColor.darkDatalab,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(tag, style: CustomTextStyles.tagText1),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
