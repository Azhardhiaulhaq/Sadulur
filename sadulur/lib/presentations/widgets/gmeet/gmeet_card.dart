import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMeetCard extends StatelessWidget {
  final GoogleMeet googleMeet;

  GoogleMeetCard({required this.googleMeet});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100.0, // Set the minimum height as needed
        ),
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
              children: [
                Row(children: [
                  Image.asset(
                    'assets/gmeet.png', // Replace with your image path
                    width: 30.0, // Adjust the width as needed
                    height: 30.0, // Adjust the height as needed
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    googleMeet.title,
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                      color: AppColor.darkDatalab,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0, // Adjust the font size if needed
                    )),
                  ),
                ]),
                const SizedBox(height: 8.0),
                Text(
                  '${DateFormat('MMM dd, yyyy').format(googleMeet.startTime)} | ${DateFormat('hh:mm a').format(googleMeet.startTime)} - ${DateFormat('hh:mm a').format(googleMeet.endTime)} ',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                    color: AppColor.darkDatalab,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0, // Adjust the font size if needed
                  )),
                ),
                const SizedBox(height: 4.0),
                Text(
                  googleMeet.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                    color: AppColor.darkDatalab,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.0, // Adjust the font size if needed
                  )),
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(googleMeet.meetLink);
                    await _launchUrl(url);
                    // Open the Google Meet link
                    // You may want to implement the URL launching logic here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.darkDatalab), // Set button color here
                  ),
                  child: Text(
                    'Join Google Meet',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                      color: AppColor.secondaryTextDatalab,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0, // Adjust the font size if needed
                    )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
