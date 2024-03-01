import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/widgets/store_detail/edit_profile_info.dart';
import 'package:sadulur/presentations/widgets/store_detail/edit_store_info.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';

class EditStoreDetailPage extends StatelessWidget {
  const EditStoreDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _EditStoreDetailPageViewModel>(
      converter: (Store<AppState> store) => _EditStoreDetailPageViewModel(
          storeDetail: store.state.loginState.user.store,
          user: store.state.loginState.user,
          isLoading: store.state.umkmStoreState.loading),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.storeDetail.photoProfile !=
                newViewModel.storeDetail.photoProfile &&
            newViewModel.storeDetail.photoProfile != null) {
          CustomFlushbar.showFlushbar(context, "Update Photo Profile Success",
              "Successfully Update Photo Profile", AppColor.flushbarSuccessBG);
        } else if (newViewModel.user != null &&
            previousViewModel!.user!.updatedAt
                .isBefore(newViewModel.user!.updatedAt)) {
          CustomFlushbar.showFlushbar(context, "Update Profile Success",
              "Successfully Update Store Info", AppColor.flushbarSuccessBG);
        }
      },
      builder: (BuildContext context, _EditStoreDetailPageViewModel viewModel) {
        return _EditStoreDetailPageContent(
            title: "Edit Profile",
            isLoading: viewModel.isLoading,
            user: viewModel.user,
            store: viewModel.storeDetail);
      },
    );
  }
}

class _EditStoreDetailPageViewModel {
  final UMKMStore storeDetail;
  final bool isLoading;
  final UMKMUser? user;

  _EditStoreDetailPageViewModel(
      {required this.storeDetail, required this.isLoading, this.user});
}

class _EditStoreDetailPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMStore store;
  final UMKMUser? user;
  const _EditStoreDetailPageContent(
      {required this.title,
      required this.isLoading,
      required this.store,
      this.user});

  @override
  _EditStoreDetailPageContentState createState() =>
      _EditStoreDetailPageContentState();
}

class _EditStoreDetailPageContentState
    extends State<_EditStoreDetailPageContent> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

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
                'Profile UMKM',
                style: CustomTextStyles.appBarTitle2,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                  child: FormBuilder(
                      key: _formKey,
                      initialValue: {
                        "email": widget.user?.email,
                        "tags": widget.store.tags,
                        "userID": widget.user?.id,
                        "name": widget.user?.name,
                        "age": widget.user?.age.toString(),
                        "education": widget.user?.education,
                        "city": widget.store.city,
                        "address": widget.store.address,
                        "province": widget.store.province,
                        "description": widget.store.description,
                        "phoneNumber": widget.store.phoneNumber,
                        "facebookAcc": widget.store.facebook,
                        "instagramAcc": widget.store.instagram,
                        "tokopediaName": widget.store.tokopedia,
                        "shopeeName": widget.store.shopee,
                        "bukalapakName": widget.store.bukalapak,
                        "umkmName": widget.store.umkmName
                      },
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                elevation: 8.0,
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Container(
                                    color: Colors.white,
                                    constraints: BoxConstraints(
                                        minWidth: double.infinity),
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(widget
                                                  .store.photoProfile ??
                                              'https://firebasestorage.googleapis.com/v0/b/umkm-application.appspot.com/o/store_default_icon.png?alt=media&token=6f762ddb-d559-493f-878e-da794afb84c9'),
                                          minRadius: 30,
                                          maxRadius: 60,
                                          backgroundColor: AppColor.darkDatalab,
                                        ),
                                        const SizedBox(
                                            height:
                                                8), // Add some spacing between the CircleAvatar and the button
                                        _updatePhotoButton(context),
                                      ],
                                    ))),
                            EditInfoProfile(
                                store: widget.store, user: widget.user),
                            const SizedBox(
                              height: 12,
                            ),
                            EditInfoStore(
                                store: widget.store, user: widget.user),
                            const SizedBox(
                              height: 16,
                            ),
                            _saveButton(context,
                                _formKey.currentState?.validate() ?? false),
                            const SizedBox(
                              height: 70,
                            )
                          ]))),
            ),
            widget.isLoading
                ? const Center(
                    child: CircularProgressCard(),
                  )
                : Container(),
          ],
        ));
  }

  Widget _updatePhotoButton(BuildContext context) {
    File? selectedFile;

    return StoreConnector<AppState, VoidCallback>(
        converter: (Store<AppState> store) {
      return () async {
        // Add your edit photo functionality here
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          selectedFile = File(pickedFile.path);

          // ignore: use_build_context_synchronously
          store.dispatch(UpdateUMKMPictureAction(
              file: selectedFile!,
              context: context,
              userID: widget.user?.id ?? "",
              store: widget.store));
        }
      };
    }, builder: (BuildContext context, VoidCallback callback) {
      return ElevatedButton(
        onPressed: callback,
        child: const Text('Edit Picture'),
      );
    });
  }

  Widget _saveButton(BuildContext context, bool isFormValid) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return isFormValid
            ? () async {
                _formKey.currentState?.save();
                Map<String, dynamic>? formValues = _formKey.currentState?.value;
                await store.dispatch(UpdateUMKMStoreInfoAction(
                    request: formValues,
                    context: context,
                    store: widget.store,
                    user: widget.user));
              }
            : () async {};
      },
      builder: (BuildContext context, VoidCallback callback) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
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
                  'Simpan',
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
