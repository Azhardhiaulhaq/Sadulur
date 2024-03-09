// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/google_meet.dart';
import 'package:sadulur/models/participant_list.dart';
import 'package:sadulur/presentations/widgets/form/custom_date_picker.dart';
import 'package:sadulur/presentations/widgets/form/custom_drop_down.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/gmeet/gmeet.action.dart';

class CoachingFormPage extends StatefulWidget {
  List<ParticipantList> participantList;
  CoachingFormPage({super.key, required this.participantList});

  @override
  // ignore: library_private_types_in_public_api
  _CoachingFormPageState createState() => _CoachingFormPageState();
}

class _CoachingFormPageState extends State<CoachingFormPage> {
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
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Meeting Title",
                    fieldName: "meetingTitle",
                    validator: FormBuilderValidators.required(
                        errorText: "Judul Meeting harus diisi"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    labelText: "Meeting Link",
                    fieldName: "meetingLink",
                    validator: FormBuilderValidators.required(
                        errorText: "Link Meeting tidak boleh kosong"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomTextField(
                      labelText: "Meeting Description",
                      fieldName: "meetingDescription",
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
                  // FormBuilderSwitch(
                  //   name: 'addMeetingRoom',
                  //   title: Text(
                  //     'Add Google Meeting Room',
                  //     style: CustomTextStyles.formBoldText1,
                  //   ),
                  //   initialValue: true,
                  //   decoration: const InputDecoration(
                  //     border: InputBorder.none, // Remove the border
                  //     fillColor:
                  //         Colors.transparent, // Set transparent fill color
                  //   ),
                  //   activeColor: AppColor
                  //       .secondaryTextDatalab, // Set the color of the switch thumb when active
                  //   inactiveThumbColor: AppColor.darkGrey,
                  // ),
                  const SizedBox(height: 16.0),
                  CustomGroupDropdown(
                    labelText: 'Email Participants',
                    fieldName: 'participantList',
                    onChanged: (String? value) {
                      setState(() {
                        selectedParticipants = widget.participantList
                            .where((element) => element.name == value)
                            .first
                            .participants;
                      });
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
                  _submitButton(
                      context, _formKey.currentState?.isValid ?? false),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _submitButton(BuildContext context, bool isFormValid) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return isFormValid
            ? () async {
                if (_formKey.currentState!.saveAndValidate()) {
                  // Perform actions with the form data
                  Map<String, dynamic> formData = _formKey.currentState!.value;
                  logger.d(formData);
                  GoogleMeet meet = GoogleMeet(
                      startTime: formData["startDate"],
                      endTime: formData['endDate'],
                      title: formData['meetingTitle'] ?? "",
                      description: formData['meetingDescription'] ?? "",
                      meetLink: formData["meetingLink"],
                      attendees: selectedParticipants);
                  store.dispatch(AddMeetingAction(meet: meet));
                }
              }
            : () async {};
      },
      builder: (BuildContext context, VoidCallback callback) {
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
              color: isFormValid ? AppColor.darkDatalab : AppColor.darkGrey),
          child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: callback,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          isFormValid
                              ? AppColor.darkDatalab
                              : AppColor.darkGrey)),
                  child: Text(
                    'Create Meeting',
                    style: CustomTextStyles.buttonText2,
                  ),
                ),
              )),
        );
      },
    );
  }
}
