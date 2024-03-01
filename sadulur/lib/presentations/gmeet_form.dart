// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/presentations/widgets/form/custom_date_picker.dart';
import 'package:sadulur/presentations/widgets/form/custom_drop_down.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';

class GoogleMeetFormPage extends StatefulWidget {
  @override
  _GoogleMeetFormPageState createState() => _GoogleMeetFormPageState();
}

class _GoogleMeetFormPageState extends State<GoogleMeetFormPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<String> selectedParticipants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 80.0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sadulur',
                style: CustomTextStyles.appBarTitle1,
              ),
              Text(
                "Create New Meeting",
                style: CustomTextStyles.appBarTitle2,
              ),
            ],
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const CustomTextField(
                      labelText: "Meeting Title",
                      fieldName: "meetingTitle",
                      isRequired: false),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomTextField(
                      labelText: "Meeting Description",
                      fieldName: "meetingDescription",
                      isRequired: false,
                      maxLines: 4),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    children: [
                      Expanded(
                          child: CustomDatePicker(
                        fieldName: "startDate",
                        labelText: "Start Date",
                        isRequired: false,
                        suffixIcon: Icon(Icons.calendar_today),
                      )),
                      SizedBox(width: 16.0), // Add spacing between date pickers
                      Expanded(
                          child: CustomDatePicker(
                        fieldName: "endDate",
                        labelText: "End Date",
                        isRequired: false,
                        suffixIcon: Icon(Icons.calendar_month),
                      )),
                    ],
                  ),
                  FormBuilderSwitch(
                    name: 'addMeetingRoom',
                    title: Text(
                      'Add Google Meeting Room',
                      style: CustomTextStyles.formBoldText1,
                    ),
                    initialValue: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none, // Remove the border
                      fillColor:
                          Colors.transparent, // Set transparent fill color
                    ),
                    activeColor: AppColor
                        .secondaryTextDatalab, // Set the color of the switch thumb when active
                    inactiveThumbColor: AppColor.darkGrey,
                  ),
                  const SizedBox(height: 16.0),
                  CustomGroupDropdown(
                    labelText: 'Email Participants',
                    fieldName: 'participantList',
                    onChanged: (String? value) {
                      print('Selected Email Group: $value');
                      // You may add participants based on the selected group
                      // For simplicity, let's add predefined participants
                      if (value == 'Group A') {
                        setState(() {
                          selectedParticipants = [
                            'participant1@example.com',
                            'participant2@example.com'
                          ];
                        });
                      } else if (value == 'Group B') {
                        setState(() {
                          selectedParticipants = [
                            'participant3@example.com',
                            'participant4@example.com'
                          ];
                        });
                      } else if (value == 'Group C') {
                        setState(() {
                          selectedParticipants = [
                            'participant5@example.com',
                            'participant6@example.com'
                          ];
                        });
                      }
                    },
                    items: const ['Group A', 'Group B', 'Group C'],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Selected Participants:',
                    style: CustomTextStyles.formBoldText1,
                  ),
                  const SizedBox(height: 8.0),
                  if (selectedParticipants.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedParticipants
                          .map((participant) => Text(participant))
                          .toList(),
                    )
                  else
                    const Text('No participants selected'),
                  const SizedBox(height: 16.0),
                  Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              // Perform actions with the form data
                              Map<String, dynamic> formData =
                                  _formKey.currentState!.value;
                              // GoogleMeet googleMeet = GoogleMeet(
                              //   startTime: formData['startTime'],
                              //   endTime: formData['endTime'],
                              //   title: formData['title'],
                              //   description: formData['description'],
                              //   location: formData['location'] ?? '',
                              //   meetLink: '', // You may want to generate a meet link here
                              //   attendees: (formData['attendees'] as String).split('\n'),
                              // );

                              // Do something with the GoogleMeet object, e.g., save to database
                              // print(googleMeet);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.darkDatalab)),
                          child: Text(
                            'Create Google Meet',
                            style: CustomTextStyles.buttonText2,
                          ),
                        ),
                      )),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ),
        ));
  }
}
