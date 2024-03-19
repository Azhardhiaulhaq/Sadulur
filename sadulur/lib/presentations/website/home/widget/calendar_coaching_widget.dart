import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/paddings.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:sadulur/models/participant_list.dart';
import 'package:sadulur/models/umkm_category_info.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/coaching/coaching_form_page.dart';
import 'package:sadulur/presentations/coaching/meet/meet_card.dart';
import 'package:sadulur/presentations/website/home/widget/mini_information.dart';
import 'package:sadulur/presentations/website/home/widget/recent_stores.dart';
import 'package:sadulur/responsive.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/gmeet/gmeet.action.dart';
import 'package:sadulur/store/login/login.action.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCoachingPage extends StatelessWidget {
  const CalendarCoachingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CalendarCoachingPageViewModel>(
      converter: (Store<AppState> store) => _CalendarCoachingPageViewModel(
          user: store.state.loginState.user,
          gmeetList: store.state.gmeetState.gmeetList,
          participantList: store.state.gmeetState.participantList,
          isLoading: store.state.umkmStoreState.loading),
      onInit: (store) {
        store.dispatch(GmeetInitAction(email: ""));
      },
      builder:
          (BuildContext context, _CalendarCoachingPageViewModel viewModel) {
        return _CalendarCoachingPageContent(
            title: "Calendar Coaching",
            isLoading: viewModel.isLoading,
            meetList: viewModel.gmeetList,
            participantList: viewModel.participantList,
            user: viewModel.user);
      },
      onDidChange: (previousViewModel, viewModel) {},
    );
  }
}

class _CalendarCoachingPageViewModel {
  final bool isLoading;
  final List<ParticipantList> participantList;
  final UMKMUser user;
  final List<GoogleMeet> gmeetList;

  _CalendarCoachingPageViewModel(
      {required this.isLoading,
      required this.gmeetList,
      required this.user,
      required this.participantList});
}

class _CalendarCoachingPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;
  final List<ParticipantList> participantList;
  final List<GoogleMeet> meetList;

  const _CalendarCoachingPageContent(
      {required this.title,
      required this.isLoading,
      required this.meetList,
      required this.participantList,
      required this.user});

  @override
  _CalendarCoachingPageContentState createState() =>
      _CalendarCoachingPageContentState();
}

class _CalendarCoachingPageContentState
    extends State<_CalendarCoachingPageContent> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<GoogleMeet> _selectedDate = [];
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant _CalendarCoachingPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              onDaySelected: _onDaySelected,
              eventLoader: _eventLoader,
              selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
              calendarStyle: const CalendarStyle(
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
            const SizedBox(
              height: 10,
            ),
            _selectedDate.isNotEmpty
                ? Text("Daftar Coaching", style: CustomTextStyles.appBarTitle2)
                : Text(
                    "Tidak ada Coaching hari ini",
                    style: CustomTextStyles.normalText(
                        fontSize: 14, color: AppColor.darkDatalab),
                  ),
            const SizedBox(
              height: 10,
            ),
            ..._selectedDate.map((meet) => WebCoachingCard(googleMeet: meet)),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              color: AppColor.white,
                              child: CoachingFormPage(
                                participantList: widget.participantList,
                                isDialog: true,
                              )));
                    });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.darkDatalab),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return const Color.fromARGB(255, 39, 49, 68);
                    }
                    return AppColor.darkDatalab;
                  },
                ),
              ),
              child: Text('Tambahkan Jadwal Coaching',
                  style: CustomTextStyles.normalText(
                      fontSize: 14, color: AppColor.secondaryTextDatalab)),
            ),
          ],
        ));
  }
}
