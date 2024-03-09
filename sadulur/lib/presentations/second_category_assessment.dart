import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/store/app.state.dart';

class SecondCategoryAssessmentPage extends StatelessWidget {
  const SecondCategoryAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SecondCategoryAssessmentViewModel>(
      converter: (Store<AppState> store) => _SecondCategoryAssessmentViewModel(
          user: store.state.loginState.user ?? UMKMUser.empty(),
          assessment: store.state.loginState.user.assessment.basicAssessment,
          isLoading: store.state.assessmentState.loading,
          questions: store.state.assessmentState.entreprenurialQuestions ?? []),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.user.updatedAt != null) {
          if (previousViewModel!.user.assessment.basicAssessment !=
              newViewModel.user.assessment.basicAssessment) {
            CustomFlushbar.showFlushbar(context, "Success Update Profile",
                "Basic Informations Updated", AppColor.flushbarSuccessBG);
          }
        }
      },
      // onInit: (store) => store.dispatch(GetEntreprenurialAssessmentAction()),
      builder:
          (BuildContext context, _SecondCategoryAssessmentViewModel viewModel) {
        return _SecondCategoryAssessmentContent(
          title: "Category Assessment",
          isLoading: viewModel.isLoading,
          assessment: viewModel.assessment,
          user: viewModel.user,
          questions: viewModel.questions,
        );
      },
    );
  }
}

class _SecondCategoryAssessmentViewModel {
  final UMKMUser user;
  final bool isLoading;
  final List<String> questions;
  final CategoryAssessment assessment;

  _SecondCategoryAssessmentViewModel(
      {required this.user,
      required this.isLoading,
      required this.questions,
      required this.assessment});
}

class _SecondCategoryAssessmentContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;
  final List<String> questions;
  final CategoryAssessment assessment;

  const _SecondCategoryAssessmentContent(
      {required this.title,
      required this.isLoading,
      required this.user,
      required this.assessment,
      required this.questions});

  @override
  _SecondCategoryAssessmentContentState createState() =>
      _SecondCategoryAssessmentContentState();
}

class _SecondCategoryAssessmentContentState
    extends State<_SecondCategoryAssessmentContent> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
            child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              color: Colors.white,
              margin: const EdgeInsets.all(16),
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Category Informations II',
                              style: CustomTextStyles.normalText(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 16,
                          ),
                          // CustomGroupDropdown(
                          //     labelText: 'Profile of the Owner',
                          //     fieldName: 'profileOwner',
                          //     initialValue:
                          //         widget.assessment.profileOwner.isNotEmpty ||
                          //                 widget.assessment.profileOwner != ""
                          //             ? widget.assessment.profileOwner
                          //             : "Non−/low educated and poor",
                          //     items: const [
                          //       "Non−/low educated and poor",
                          //       "Many are well educated and from non-poor families",
                          //       "Most are well-educated and from medium to high-income families."
                          //     ]),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // CustomGroupDropdown(
                          //     labelText: 'Technology Used',
                          //     fieldName: 'technology',
                          //     initialValue: widget
                          //                 .assessment.techUsed.isNotEmpty ||
                          //             widget.assessment.techUsed != ""
                          //         ? widget.assessment.techUsed
                          //         : "do not utilize information technology (IT)",
                          //     items: const [
                          //       "do not utilize information technology (IT)",
                          //       "Many use machines and utilize IT",
                          //       "Degree of modern technology used is much higher and all utilize IT"
                          //     ]),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // CustomGroupDropdown(
                          //     labelText: 'Owner by Gender',
                          //     fieldName: 'ownerGender',
                          //     initialValue:
                          //         widget.assessment.genderOwner.isNotEmpty ||
                          //                 widget.assessment.genderOwner != ""
                          //             ? widget.assessment.genderOwner
                          //             : "Many MIEs are owned/managed by women",
                          //     items: const [
                          //       "Many MIEs are owned/managed by women",
                          //       "Less women are involved as owners/entrepreneurs",
                          //       "Very few women as owners/entrepreneurs"
                          //     ]),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // CustomGroupDropdown(
                          //     labelText: 'Motivation to run own business',
                          //     fieldName: 'motivation',
                          //     initialValue:
                          //         widget.assessment.motivation.isNotEmpty ||
                          //                 widget.assessment.motivation != ""
                          //             ? widget.assessment.motivation
                          //             : "to survive",
                          //     items: const [
                          //       "to survive",
                          //       "Mostly for profit",
                          //       "All for profit"
                          //     ]),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // CustomGroupDropdown(
                          //     labelText: 'Spirit of entrepreneurship',
                          //     fieldName: 'spirit',
                          //     initialValue:
                          //         widget.assessment.spirit.isNotEmpty ||
                          //                 widget.assessment.spirit != ""
                          //             ? widget.assessment.spirit
                          //             : "Low",
                          //     items: ["Low", "Mostly High", "All High"]),
                          // const SizedBox(
                          //   height: 24,
                          // ),
                          _submitButton(
                            context,
                            _formKey.currentState?.saveAndValidate() ?? false,
                          )
                        ],
                      ),
                      widget.isLoading
                          ? const CircularProgressCard()
                          : Container()
                    ],
                  ))),
        )));
  }

  Widget _submitButton(BuildContext context, bool isFormValid) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return isFormValid
            ? () async {
                // _formKey.currentState?.save();
                // CategoryAssessment assessment = widget.assessment.copyWith(
                //   profileOwner:
                //       _formKey.currentState!.fields["profileOwner"]?.value,
                //   techUsed: _formKey.currentState!.fields["technology"]?.value,
                //   genderOwner:
                //       _formKey.currentState!.fields["ownerGender"]?.value,
                //   motivation:
                //       _formKey.currentState!.fields["motivation"]?.value,
                //   spirit: _formKey.currentState!.fields["spirit"]?.value,
                // );

                // store.dispatch(UpdateCategoryAssessmentAction(
                //     user: widget.user, assessment: assessment));
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
