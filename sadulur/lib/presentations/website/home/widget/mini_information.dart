import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/paddings.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_category_info.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/presentations/website/home/widget/mini_information_widget.dart';
import 'package:sadulur/responsive.dart';

class MiniInformation extends StatelessWidget {
  final List<UMKMCategoryInfo> stores;
  const MiniInformation({Key? key, required this.stores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Informasi Umum UMKM",
            style: CustomTextStyles.normalText(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.darkDatalab)),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: InformationCard(
            stores: stores,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.2 : 1,
          ),
          tablet: InformationCard(
            stores: stores,
          ),
          desktop: InformationCard(
            stores: stores,
            childAspectRatio: _size.width < 1400 ? 1.5 : 2,
          ),
        ),
      ],
    );
  }
}

class InformationCard extends StatelessWidget {
  final List<UMKMCategoryInfo> stores;
  const InformationCard({
    Key? key,
    required this.stores,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: stores.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          Color bgColor = AppColor.backgroundGrey;
          Icon icon =
              const Icon(Icons.house, color: AppColor.darkGrey, size: 40);
          if (stores[index].category == "small") {
            bgColor = AppColor.ligthGreen;
            icon = const Icon(Icons.store, color: AppColor.darkGreen, size: 40);
          } else if (stores[index].category == "medium") {
            bgColor = AppColor.lightkBlue;
            icon = const Icon(Icons.storefront_sharp,
                color: AppColor.darkDatalab, size: 40);
          }
          return MiniInformationWidget(
              umkmInfo: stores[index],
              iconBackgroundColor: bgColor,
              icon: icon);
        });
  }
}
