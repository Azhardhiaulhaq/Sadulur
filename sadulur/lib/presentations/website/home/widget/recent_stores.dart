import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/paddings.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/presentations/store_detail.dart';

class RecentStores extends StatefulWidget {
  final List<UMKMStore> stores;
  const RecentStores({Key? key, required this.stores}) : super(key: key);

  @override
  _RecentStoresState createState() => _RecentStoresState();
}

class _RecentStoresState extends State<RecentStores> {
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
                source: _DataSource(context: context, data: widget.stores)),
          ),
        ),
      ),
    );
  }
}

DataRow recentUserDataRow(UMKMStore store, BuildContext context) {
  return DataRow(
    key: ValueKey(store.id),
    onLongPress: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                content: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    color: AppColor.white,
                    child: StoreDetailPage(id: store.id)));
          });
    },
    color:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered)) {
        return AppColor.backgroundGrey.withOpacity(0.5);
      }
      return null;
    }),
    cells: [
      DataCell(
        Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(store.photoProfile ??
                  'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
              maxRadius: 20,
              backgroundColor: AppColor.darkDatalab,
            ),
            Expanded(
              // Wrap the Text widget with Expanded
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  store.umkmName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
      DataCell(Text(store.phoneNumber ?? "Tidak ada No Telpon")),
      DataCell(Text(store.email != "" ? store.email! : "Tidak ada Email")),
    ],
  );
}

class _DataSource extends DataTableSource {
  final List<UMKMStore> data;
  final BuildContext context;
  _DataSource({required this.data, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      key: ValueKey(item.id),
      onSelectChanged: (value) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: AppColor.white,
                      child: StoreDetailPage(id: item.id)));
            });
      },
      color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return AppColor.backgroundGrey.withOpacity(0.5);
        }
        return AppColor.white;
      }),
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(item.photoProfile ??
                    'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
                maxRadius: 20,
                backgroundColor: AppColor.darkDatalab,
              ),
              Expanded(
                // Wrap the Text widget with Expanded
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Text(
                    item.umkmName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
            child: Text(item.level, style: CustomTextStyles.tagText1),
          ),
        ),
        DataCell(Text(item.phoneNumber ?? "Tidak ada No Telpon")),
        DataCell(Text(item.email != "" ? item.email! : "Tidak ada Email")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
