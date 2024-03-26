import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/store_detail/statistic_store_card.dart';
import 'package:sadulur/presentations/widgets/store_detail/store_description.dart';
import 'package:sadulur/presentations/widgets/store_detail/store_products.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/assessment/assessment.action.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';

class StoreDetailPage extends StatelessWidget {
  final String id;

  const StoreDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _StoreDetailPageViewModel>(
      converter: (Store<AppState> store) => _StoreDetailPageViewModel(
          storeUser: store.state.umkmStoreState.selectedUser,
          user: store.state.loginState.user,
          error: store.state.umkmStoreState.error,
          categoryAssessment: store.state.assessmentState.assessmentList ?? [],
          isLoading: store.state.umkmStoreState.loading),
      onInit: (store) {
        store.dispatch(GetUmkmStoreDetailAction(id: id));
        store.dispatch(GetCategoryAssessmentAction(id: id));
      },
      builder: (BuildContext context, _StoreDetailPageViewModel viewModel) {
        return _StoreDetailPageContent(
          title: viewModel.storeUser.store.umkmName ?? "",
          isLoading: viewModel.isLoading,
          user: viewModel.user,
          storeUser: viewModel.storeUser,
          categoryAssessment: viewModel.categoryAssessment,
        );
      },
    );
  }
}

class _StoreDetailPageViewModel {
  final UMKMUser storeUser;
  final bool isLoading;
  final UMKMUser user;
  final String error;
  final List<CategoryAssessment> categoryAssessment;

  _StoreDetailPageViewModel(
      {required this.storeUser,
      required this.isLoading,
      required this.user,
      required this.categoryAssessment,
      required this.error});
}

class _StoreDetailPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser storeUser;
  final UMKMUser user;
  final List<CategoryAssessment> categoryAssessment;
  const _StoreDetailPageContent(
      {required this.title,
      required this.isLoading,
      required this.storeUser,
      required this.user,
      required this.categoryAssessment});

  @override
  _StoreDetailPageContentState createState() => _StoreDetailPageContentState();
}

class _StoreDetailPageContentState extends State<_StoreDetailPageContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _StoreDetailPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            toolbarHeight: 80.0,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColor.darkDatalab,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: [
              widget.storeUser.id == widget.user.id
                  ? IconButton(
                      icon: const Icon(Icons.edit_document,
                          color: AppColor.darkDatalab),
                      onPressed: () {
                        Navigator.pushNamed(context, '/store/assessment',
                            arguments: {'id': widget.storeUser.id});
                      },
                    )
                  : Container(),
              widget.storeUser.id == widget.user.id
                  ? IconButton(
                      icon: const Icon(Icons.mode_edit_outline_sharp,
                          color: AppColor.darkDatalab),
                      onPressed: () {
                        Navigator.pushNamed(context, '/store/edit',
                            arguments: {'id': widget.storeUser.id});
                      },
                    )
                  : Container(),
            ],
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.storeUser.store.umkmName ?? "Belum ada Nama Toko",
                  style: CustomTextStyles.appBarTitle1,
                ),
              ],
            ),
            bottom: TabBar(
              indicatorPadding: EdgeInsets.zero,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.darkDatalab),
              labelColor: AppColor.secondaryTextDatalab,
              unselectedLabelColor: AppColor.textDatalab,
              tabs: const [
                SizedBox(
                  width: double.infinity,
                  child: Tab(text: "Deskripsi"),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Tab(text: "Produk"),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Tab(text: "Statistik"),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  StoreDescription(store: widget.storeUser.store),
                  StoreProducts(store: widget.storeUser.store),
                  StatisticStorePage(
                      user: widget.storeUser,
                      categoryAssessments: widget.categoryAssessment)
                ],
              ),
              widget.isLoading
                  ? const Center(
                      child: CircularProgressCard(),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
