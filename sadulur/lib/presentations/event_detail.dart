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
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _EventDetailViewModel>(
      converter: (Store<AppState> store) => _EventDetailViewModel(
          user: store.state.loginState.user,
          isLoading: store.state.eventState.loading,
          event: event),
      // onInit: (store) => store.dispatch(
      //     GetUmkmStoreDetailAction(user: store.state.loginState.user)),
      onWillChange: (previousViewModel, newViewModel) {
        // if (previousViewModel?.user.store.updatedAt != null) {
        //   if (previousViewModel!.user.store.updatedAt!
        //       .isBefore(newViewModel.user.store.updatedAt!)) {
        //     CustomFlushbar.showFlushbar(context, "Success Update Profile",
        //         "Basic Informations Updated", AppColor.flushbarSuccessBG);
        //   }
        // }
      },
      builder: (BuildContext context, _EventDetailViewModel viewModel) {
        return _EventDetailContent(
            title: "New Form",
            isLoading: viewModel.isLoading,
            user: viewModel.user,
            event: viewModel.event);
      },
    );
  }
}

class _EventDetailViewModel {
  final UMKMUser user;
  final Event event;
  final bool isLoading;

  _EventDetailViewModel(
      {required this.user, required this.isLoading, required this.event});
}

class _EventDetailContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;
  final Event event;
  const _EventDetailContent(
      {required this.title,
      required this.isLoading,
      required this.user,
      required this.event});

  @override
  _EventDetailContentState createState() => _EventDetailContentState();
}

class _EventDetailContentState extends State<_EventDetailContent> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> share(String phone, String message) async {
    var phoneNumber = '+$phone';
    // ignore: non_constant_identifier_names
    var whatsappURl_android =
        "whatsapp://send?phone=$phoneNumber&text=$message";
    if (await canLaunchUrl(Uri.parse(whatsappURl_android))) {
      await launchUrl(Uri.parse(whatsappURl_android));
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }

  void openLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('There was a problem to open the url: $url');
    }
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
              widget.event.name,
              style: CustomTextStyles.appBarTitle2,
            ),
          ],
        ),
      ),
      body: Container(
          color: Colors.grey[200],
          child: SingleChildScrollView(
              child: Column(
            children: [
              Card(
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                  widget.event.description != ''
                                      ? widget.event.description
                                      : 'Belum ada deskripsi event',
                                  overflow: TextOverflow.fade,
                                  style: CustomTextStyles.normalText(),
                                  textAlign: TextAlign.justify),
                              const SizedBox(
                                height: 25,
                              ),
                              Text('Contact Person',
                                  style: CustomTextStyles.normalText(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: TextButton.icon(
                                    label: Text(
                                        widget.event.contactPerson != ''
                                            ? '+62 ${widget.event.contactPerson}'
                                            : 'Belum ada narahubung',
                                        style: CustomTextStyles.normalText(
                                            fontWeight: FontWeight.bold)),
                                    icon: Icon(MdiIcons.whatsapp,
                                        color: Colors.green, size: 30),
                                    onPressed: () {
                                      widget.event.contactPerson != ''
                                          ? share(
                                              '62${widget.event.contactPerson}',
                                              'Halo')
                                          : print('Contact Person is null');
                                    },
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                          widget.isLoading
                              ? const CircularProgressCard()
                              : Container()
                        ],
                      ))),
              _linkButton(widget.event.link ?? "")
            ],
          ))),
    );
  }

  Widget _linkButton(String link) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            link != '' ? openLink(link) : print(link);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                color: link != '' ? AppColor.darkDatalab : Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                        height: 20,
                        child: Center(
                          child: Text(
                            link != ''
                                ? 'DAFTAR'
                                : 'BELUM ADA LINK PENDAFTARAN',
                            style: TextStyle(
                                color: link != ''
                                    ? AppColor.secondaryTextDatalab
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
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
