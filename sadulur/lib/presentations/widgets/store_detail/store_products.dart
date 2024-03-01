import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/presentations/widgets/store_detail/description_store_card.dart';
import 'package:sadulur/presentations/widgets/store_detail/overview_store_card.dart';
import 'package:sadulur/presentations/widgets/store_detail/store_product_card.dart';

class StoreProducts extends StatefulWidget {
  StoreProducts({
    super.key,
    required this.store,
  });

  final UMKMStore store;

  @override
  _StoreProductsState createState() => _StoreProductsState();
}

// ignore: must_be_immutable
class _StoreProductsState extends State<StoreProducts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AlignedGridView.count(
          crossAxisCount: 2,
          itemCount: widget.store.listProduct?.length,
          itemBuilder: (BuildContext context, int index) {
            return StoreProductCard(product: widget.store.listProduct![index]);
          },
        )
      ],
    );
  }
}
