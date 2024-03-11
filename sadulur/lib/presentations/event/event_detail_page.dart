import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/event.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/store/app.state.dart';
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
      onWillChange: (previousViewModel, newViewModel) {},
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
    }
  }

  void openLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
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
              widget.event.bannerImage != "" && widget.event.bannerImage != null
                  ? Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 4,
                      color: Colors.white,
                      margin: const EdgeInsets.all(16),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      NetworkImage(widget.event.bannerImage!),
                                  fit: BoxFit.fitWidth),
                              border:
                                  Border.all(color: AppColor.backgroundWhite),
                              borderRadius: BorderRadius.circular(16))))
                  : Container(),
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
                                              'Halo',
                                            )
                                          : CustomFlushbar.showFlushbar(
                                              context,
                                              'Tidak Dapat Menghubungi',
                                              'Nomor Tidak Valid',
                                              AppColor.flushbarErrorBG);
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
              _linkButton(widget.event.link ?? ""),
              const SizedBox(
                height: 70,
              )
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
            link != ''
                ? openLink(link)
                : CustomFlushbar.showFlushbar(
                    context,
                    'Tidak Dapat Membuka Tautan',
                    'Link Tidak Valid',
                    AppColor.flushbarErrorBG);
            ;
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                color: link != '' ? AppColor.darkDatalab : Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
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
}
