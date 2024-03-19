import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/paddings.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:sadulur/models/umkm_category_info.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/website/home/widget/calendar_coaching_widget.dart';
import 'package:sadulur/presentations/website/home/widget/mini_information.dart';
import 'package:sadulur/presentations/website/home/widget/recent_stores.dart';
import 'package:sadulur/responsive.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/gmeet/gmeet.action.dart';
import 'package:sadulur/store/login/login.action.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';
import 'package:table_calendar/table_calendar.dart';

import 'widget/header.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _DashboardPageViewModel>(
      converter: (Store<AppState> store) => _DashboardPageViewModel(
          error: store.state.umkmStoreState.error,
          umkmStores: store.state.umkmStoreState.umkmStores,
          user: store.state.loginState.user,
          isLoading: store.state.umkmStoreState.loading),
      onInit: (store) {
        store.dispatch(GetAllUmkmStoreAction());
        store.dispatch(
            GetUserDetailAction(userID: store.state.loginState.user.id));
      },
      builder: (BuildContext context, _DashboardPageViewModel viewModel) {
        return _DashboardPageContent(
            title: "UMKM Dashboard",
            isLoading: viewModel.isLoading,
            stores: viewModel.umkmStores,
            user: viewModel.user);
      },
      onDidChange: (previousViewModel, viewModel) {
        if (viewModel.error != '') {}
      },
    );
  }
}

class _DashboardPageViewModel {
  final List<UMKMStore> umkmStores;
  final bool isLoading;
  final String error;
  final UMKMUser user;

  _DashboardPageViewModel(
      {required this.umkmStores,
      required this.isLoading,
      required this.error,
      required this.user});
}

class _DashboardPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final List<UMKMStore> stores;
  final UMKMUser user;

  const _DashboardPageContent(
      {required this.title,
      required this.isLoading,
      required this.stores,
      required this.user});

  @override
  _DashboardPageContentState createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<_DashboardPageContent> {
  List<UMKMStore> micros = [];
  List<UMKMStore> smalls = [];
  List<UMKMStore> mediums = [];
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant _DashboardPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      micros = widget.stores.where((store) => store.level == "micro").toList();
      smalls = widget.stores.where((store) => store.level == "small").toList();
      mediums =
          widget.stores.where((store) => store.level == "medium").toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              // Header(
              //   user: widget.user,
              // ),
              const SizedBox(height: defaultPadding),
              MiniInformation(
                stores: [
                  UMKMCategoryInfo(category: "micro", stores: micros),
                  UMKMCategoryInfo(category: "small", stores: smalls),
                  UMKMCategoryInfo(category: "medium", stores: mediums),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //MyFiels(),
                        //SizedBox(height: defaultPadding),
                        RecentStores(stores: widget.stores),
                        // SizedBox(height: defaultPadding),
                        // RecentDiscussions(),
                        // if (Responsive.isMobile(context))
                        //   SizedBox(height: defaultPadding),
                        // if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    const SizedBox(width: defaultPadding),
                  if (!Responsive.isMobile(context))
                    const Expanded(flex: 2, child: CalendarCoachingPage())
                  // // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                  //   Expanded(
                  //     flex: 2,
                  //     child: UserDetailsWidget(),
                  //   ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
