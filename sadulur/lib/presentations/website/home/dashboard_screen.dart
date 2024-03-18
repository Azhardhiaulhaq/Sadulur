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
          gmeetList: store.state.gmeetState.gmeetList,
          isLoading: store.state.umkmStoreState.loading),
      onInit: (store) {
        store.dispatch(GetAllUmkmStoreAction());
        store.dispatch(
            GmeetInitAction(email: store.state.loginState.user.email));
        store.dispatch(
            GetUserDetailAction(userID: store.state.loginState.user.id));
      },
      builder: (BuildContext context, _DashboardPageViewModel viewModel) {
        return _DashboardPageContent(
            title: "UMKM Dashboard",
            isLoading: viewModel.isLoading,
            stores: viewModel.umkmStores,
            meetList: viewModel.gmeetList,
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
  final List<GoogleMeet> gmeetList;

  _DashboardPageViewModel(
      {required this.umkmStores,
      required this.isLoading,
      required this.error,
      required this.gmeetList,
      required this.user});
}

class _DashboardPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final List<UMKMStore> stores;
  final UMKMUser user;
  final List<GoogleMeet> meetList;

  const _DashboardPageContent(
      {required this.title,
      required this.isLoading,
      required this.stores,
      required this.meetList,
      required this.user});

  @override
  _DashboardPageContentState createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<_DashboardPageContent> {
  List<UMKMStore> micros = [];
  List<UMKMStore> smalls = [];
  List<UMKMStore> mediums = [];
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<GoogleMeet> _selectedDate = [];
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
      logger.d("# Meeting ##### ${widget.meetList[0]}");
      logger.d("@@@@@@@ $smalls");
      mediums =
          widget.stores.where((store) => store.level == "medium").toList();
    });
  }

  List<GoogleMeet> _eventLoader(DateTime date) {
    return widget.meetList
        .where((element) => isSameDay(date, element.startTime))
        .toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedDate = widget.meetList
            .where((element) => isSameDay(selectedDay, element.startTime))
            .toList();
        logger.d("!!!!! ${_selectedDate}");
        // _selectedDate = calendarData
        //     .where((element) => isSameDay(selectedDay, element.date))
        //     .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
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
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDay,
                          onDaySelected: _onDaySelected,
                          eventLoader: _eventLoader,
                          selectedDayPredicate: (day) =>
                              isSameDay(_focusedDay, day),
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: AppColor.darkDatalab,
                              shape: BoxShape.circle,
                            ),
                            markerDecoration: BoxDecoration(
                              color: AppColor.secondaryTextDatalab,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    )
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
