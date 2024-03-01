import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/entrepreneurial_assessment.dart';
import 'package:sadulur/presentations/category_assessment.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AssessmentUMKMPage extends StatelessWidget {
  const AssessmentUMKMPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _UmkmPageViewModel>(
      converter: (Store<AppState> store) => _UmkmPageViewModel(
          error: store.state.umkmStoreState.error,
          store: store.state.loginState.user.store,
          user: store.state.loginState.user,
          isLoading: store.state.umkmStoreState.loading),
      onInit: (store) => store.dispatch(GetAllUmkmStoreAction()),
      onWillChange: (previousViewModel, newViewModel) {
        logger.d(previousViewModel?.store.photoProfile);
        logger.d(newViewModel.store.photoProfile);
      },
      builder: (BuildContext context, _UmkmPageViewModel viewModel) {
        return AssessmentPage(
          title: "UMKM Dashboard",
          isLoading: viewModel.isLoading,
          user: viewModel.user,
        );
      },
      onDidChange: (previousViewModel, viewModel) {},
    );
  }
}

class _UmkmPageViewModel {
  final UMKMStore store;
  final bool isLoading;
  final UMKMUser user;
  final String error;

  _UmkmPageViewModel(
      {required this.store,
      required this.user,
      required this.isLoading,
      required this.error});
}

class AssessmentPage extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;

  const AssessmentPage(
      {required this.title, required this.isLoading, required this.user});

  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  double _progress = 0;
  int currentPage = 0;
  final PageController _ProgressController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _progress = 1 / 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 80.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.darkDatalab),
            onPressed: () {
              // Handle the back button functionality here
              Navigator.of(context).pop();
            },
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sadulur',
                style: CustomTextStyles.appBarTitle1,
              ),
              Text(
                'Assessment UMKM',
                style: CustomTextStyles.appBarTitle2,
              ),
              const SizedBox(
                height: 8,
              ),
              AnimatedSmoothIndicator(
                activeIndex: _progress.toInt(),
                count: 2,
                effect: const WormEffect(
                    dotColor: AppColor.darkDatalab,
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: AppColor.secondaryTextDatalab),
              )
            ],
          ),
        ),
        body: PageView(
            controller: _ProgressController,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
                _progress = (currentPage) /
                    1; // Update the progress based on the current page
              });
            },
            children: const [
              // EditStoreDetailPage(),
              EntrepreneurialAssessmentPage(),
              // BasicCategoryAssessmentPage(),
              CategoryAsessmentPage(),
              // SecondCategoryAssessmentPage()
            ]));
  }
}
