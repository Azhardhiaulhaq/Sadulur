import 'package:flutter/material.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/presentations/widgets/store_detail/description_store_card.dart';
import 'package:sadulur/presentations/widgets/store_detail/overview_store_card.dart';

class StoreDescription extends StatefulWidget {
  StoreDescription({
    super.key,
    required this.store,
  });

  final UMKMStore store;

  @override
  _StoreDescriptionState createState() => _StoreDescriptionState();
}

// ignore: must_be_immutable
class _StoreDescriptionState extends State<StoreDescription> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        SingleChildScrollView(
            child: widget.store.id == ''
                ? Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text('Segera Buka Toko Milik Anda!',
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.normalText(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Segera buka toko milikmu dan bergabung dengan jaringan UMKM lainnya untuk meningkatkan bisnis anda!',
                          style: CustomTextStyles.normalText(
                              fontSize: 16, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _createButton(context)
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      StoreOverviewCard(store: widget.store),
                      const SizedBox(
                        height: 5,
                      ),
                      StoreDescriptionCard(store: widget.store),
                      const SizedBox(
                        height: 70,
                      )
                    ],
                  ))
      ],
    );
  }

  Widget _createButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          color: AppColor.darkDatalab),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blueGrey,
          onTap: () {
            Navigator.pushNamed(context, '/store/assessment',
                arguments: {'id': widget.store.id});
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text(
              'Buat Toko',
              style: TextStyle(
                fontSize: 20,
                color: AppColor.secondaryTextDatalab,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
