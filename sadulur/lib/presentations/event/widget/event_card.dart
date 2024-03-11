// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/event.dart';
import 'package:sadulur/presentations/event/event_detail_page.dart';

class EventCard extends StatelessWidget {
  Event event;
  bool isExpired;
  EventCard({super.key, required this.event, required this.isExpired});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100.0, // Set the minimum height as needed
        ),
        child: InkWell(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              context,
              settings: const RouteSettings(name: '/event/detail'),
              screen: EventDetailPage(event: event),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    event.name,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        color: AppColor.darkDatalab,
                        fontWeight:
                            FontWeight.bold, // You can adjust the font weight
                        fontSize: 16.0, // Adjust the font size if needed
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: isExpired
                                  ? AppColor.darkGrey
                                  : AppColor.darkDatalab,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  event.date.day.toString(),
                                  style: CustomTextStyles.normalText(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      color: isExpired
                                          ? AppColor.black
                                          : AppColor.secondaryTextDatalab),
                                ),
                                Text(
                                  "${DateFormat.MMM().format(event.date)} ${event.date.year}",
                                  maxLines: 2,
                                  style: CustomTextStyles.normalText(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: isExpired
                                          ? AppColor.black
                                          : AppColor.secondaryTextDatalab),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              event.author,
                              style: CustomTextStyles.normalText(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColor.black),
                            ),
                            Text(
                              event.location,
                              style: CustomTextStyles.normalText(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColor.black),
                            )
                          ],
                        )
                      ]),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  isExpired
                      ? Container()
                      : Text(event.description,
                          maxLines: 3,
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: AppColor.darkDatalab,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))),
                ],
              ),
            ),
          ),
        ));
  }
}
