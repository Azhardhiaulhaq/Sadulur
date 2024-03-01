// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/forum/forum.action.dart';

class NewForumEditor extends StatelessWidget {
  const NewForumEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _NewForumViewModel>(
      converter: (Store<AppState> store) => _NewForumViewModel(
          user: store.state.loginState.user,
          posts: store.state.forumState.posts,
          error: store.state.forumState.error,
          isLoading: store.state.forumState.loading),
      builder: (BuildContext context, _NewForumViewModel viewModel) {
        return NewForumEditorContent(
          userID: viewModel.user.id,
          userName: viewModel.user.userName,
          isLoading: viewModel.isLoading,
        );
      },
      onDidChange: (previousViewModel, viewModel) {
        if (previousViewModel!.posts.length < viewModel.posts.length) {
          CustomFlushbar.showFlushbar(context, "Success",
              "Post is successfully added", AppColor.flushbarSuccessBG);

          Navigator.pushNamedAndRemoveUntil(
              context, "/forum", (route) => false);
        } else if (viewModel.error != "") {
          CustomFlushbar.showFlushbar(context, "Error Add Post",
              viewModel.error, AppColor.flushbarErrorBG);
        }
      },
    );
  }
}

class _NewForumViewModel {
  final bool isLoading;
  final UMKMUser user;
  final List<ForumPost> posts;
  final String error;

  _NewForumViewModel(
      {required this.user,
      required this.isLoading,
      required this.posts,
      required this.error});
}

class NewForumEditorContent extends StatefulWidget {
  final String userID;
  final String userName;
  final bool isLoading;

  const NewForumEditorContent(
      {required this.userID, required this.userName, required this.isLoading});

  @override
  NewForumEditorContentState createState() => NewForumEditorContentState();
}

class NewForumEditorContentState extends State<NewForumEditorContent> {
  List<String> pickedFileNames = [];

  final TextEditingController _tagController = TextEditingController();
  List<String> tags = [];
  final _formKey = GlobalKey<FormBuilderState>();

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty) {
      setState(() {
        tags.add(tag);
        _tagController.clear();
      });
    }
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        pickedFileNames = pickedFiles.map((pickedFile) {
          return File(pickedFile.path).path;
        }).toList();
      });
    }
  }

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
                "New Post",
                style: CustomTextStyles.appBarTitle2,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Stack(children: [
          Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.all(12),
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: CustomTextStyles.normalText(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        labelText: "",
                        fieldName: "title",
                        maxLines: 1,
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "What's on your mind ?",
                        style: CustomTextStyles.normalText(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        labelText: "",
                        fieldName: "content",
                        maxLines: 5,
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Tags",
                        style: CustomTextStyles.normalText(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppColor.backgroundWhite,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: AppColor.darkDatalab,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                labelText: "",
                                fieldName: "tags",
                                maxLines: 1,
                                prefixIcon: const Icon(Icons.add),
                                controller: _tagController,
                                onSubmitted: (_) => _addTag(),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (String tag in tags)
                                    Chip(
                                      label: Text(tag),
                                      onDeleted: () {
                                        setState(() {
                                          tags.remove(tag);
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      _submitButton(context, true),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      )
                    ]),
              )),
          widget.isLoading
              ? const Center(
                  child: CircularProgressCard(),
                )
              : Container(),
        ])));
  }

  Widget _submitButton(BuildContext context, bool isFormValid) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return isFormValid
            ? () async {
                ForumPost post = ForumPost(
                    author: widget.userName,
                    authorID: widget.userID,
                    postID: '',
                    title: _formKey.currentState!.fields["title"]!.value
                        .toString(),
                    createdTime: DateTime.now(),
                    content: _formKey.currentState!.fields["content"]!.value
                        .toString(),
                    tags: tags,
                    likes: 0,
                    views: 0,
                    comments: 0,
                    images: []);
                store.dispatch(AddForumPostAction(post: post));
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
                  'Post Thread',
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
