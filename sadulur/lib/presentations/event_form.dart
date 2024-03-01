import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/event.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/widgets/form/custom_date_picker.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/assessment/assessment.action.dart';
import 'package:sadulur/store/event/event.action.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';

class EventFormPage extends StatelessWidget {
  const EventFormPage({super.key, this.eventID});
  final String? eventID;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _EventFormViewModel>(
      converter: (Store<AppState> store) => _EventFormViewModel(
        user: store.state.loginState.user,
        isLoading: store.state.eventState.loading,
      ),
      onInit: (store) => store.dispatch(
          GetUmkmStoreDetailAction(user: store.state.loginState.user)),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.user.store.updatedAt != null) {
          if (previousViewModel!.user.store.updatedAt!
              .isBefore(newViewModel.user.store.updatedAt!)) {
            CustomFlushbar.showFlushbar(context, "Success Update Profile",
                "Basic Informations Updated", AppColor.flushbarSuccessBG);
          }
        }
      },
      builder: (BuildContext context, _EventFormViewModel viewModel) {
        return _EventFormContent(
          title: "New Form",
          isLoading: viewModel.isLoading,
          user: viewModel.user,
        );
      },
    );
  }
}

class _EventFormViewModel {
  final UMKMUser user;
  final bool isLoading;

  _EventFormViewModel({required this.user, required this.isLoading});
}

class _EventFormContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;

  const _EventFormContent({
    required this.title,
    required this.isLoading,
    required this.user,
  });

  @override
  _EventFormContentState createState() => _EventFormContentState();
}

class _EventFormContentState extends State<_EventFormContent> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
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
              widget.title,
              style: CustomTextStyles.appBarTitle2,
            ),
          ],
        ),
      ),
      body: Container(
          color: Colors.grey[200],
          child: SingleChildScrollView(
              child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                color: Colors.white,
                margin: const EdgeInsets.all(16),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Event Information',
                                style: CustomTextStyles.normalText(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                                keyboardType: TextInputType.name,
                                labelText: 'Event Name',
                                hintText: 'Name of the Event',
                                validator: FormBuilderValidators.required(),
                                fieldName: 'name'),
                            const SizedBox(
                              height: 16,
                            ),
                            const CustomDatePicker(
                              fieldName: "eventDate",
                              labelText: "Event Date",
                              isRequired: true,
                              suffixIcon: Icon(Icons.calendar_month_rounded),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              labelText: 'Event Description',
                              hintText: 'Description of the Event',
                              fieldName: 'description',
                              validator: FormBuilderValidators.required(),
                              maxLines: 4,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                                keyboardType: TextInputType.text,
                                labelText: 'Event Location',
                                hintText: 'Location of the Event',
                                fieldName: 'location',
                                validator: FormBuilderValidators.required()),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                                keyboardType: TextInputType.text,
                                labelText: 'Event Link',
                                hintText:
                                    'Registration Link of the Event (if any)',
                                fieldName: 'link',
                                validator: FormBuilderValidators.required()),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                                keyboardType: TextInputType.phone,
                                labelText: 'Contact Person',
                                hintText: 'Contact Person',
                                fieldName: 'contactPerson',
                                validator: FormBuilderValidators.required()),
                            const SizedBox(
                              height: 24,
                            ),
                            _submitButton(
                              context,
                              true,
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                        widget.isLoading
                            ? const CircularProgressCard()
                            : Container()
                      ],
                    ))),
          ))),
    );
  }

  Widget _submitButton(BuildContext context, bool isFormValid) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return isFormValid
            ? () async {
                String name = _formKey.currentState?.fields["name"]?.value;
                var eventDate =
                    _formKey.currentState?.fields["eventDate"]?.value;

                var description =
                    _formKey.currentState?.fields["description"]?.value;
                var location = _formKey.currentState?.fields["location"]?.value;
                var contactPerson =
                    _formKey.currentState?.fields["contactPerson"]?.value;

                var link = _formKey.currentState?.fields["link"]?.value;
                Event newEvent = Event(
                    id: "",
                    name: name,
                    date: eventDate,
                    description: description,
                    location: location,
                    contactPerson: contactPerson,
                    link: link,
                    author: widget.user.id);

                store.dispatch(AddEventAction(event: newEvent));
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.blueGrey,
              onTap: callback,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 20,
                    color: isFormValid
                        ? AppColor.secondaryTextDatalab
                        : AppColor.darkDatalab,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
