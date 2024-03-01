import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/store_product.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreProductCard extends StatelessWidget {
  final StoreProduct product;
  const StoreProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return IntrinsicHeight(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Set the border radius for rounded corners
                        child: Image.network(
                          product.imageUrl,
                          scale: 0.7,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        product.name,
                        style: CustomTextStyles.normalText(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkDatalab),
                      ),
                      Text(
                        currencyFormatter.format(product.price),
                        style: CustomTextStyles.normalText(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColor.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        product.description,
                        maxLines: 2,
                        style: CustomTextStyles.normalText(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColor.black),
                      ),
                      const Divider(
                        thickness: 1,
                        color: AppColor.darkGrey,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.remove_red_eye_outlined,
                              color: AppColor.darkGrey, size: 18),
                          const SizedBox(width: 4.0),
                          Text(
                            '${product.seenNumber} Views',
                            style: CustomTextStyles.iconText1,
                          )
                        ],
                      ),
                    ],
                  )))),
    );
  }
}
