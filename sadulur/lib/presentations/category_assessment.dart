import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:googleapis/chat/v1.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/business_feasability_assessment.dart';
import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/category_assessment/business_communication.dart';
import 'package:sadulur/presentations/category_assessment/business_feasability.dart';
import 'package:sadulur/presentations/category_assessment/collaboration.dart';
import 'package:sadulur/presentations/category_assessment/decision_making.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/widgets/form/custom_drop_down.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/assessment/assessment.action.dart';

class CategoryAsessmentPage extends StatelessWidget {
  const CategoryAsessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CategoryAsessmentViewModel>(
      converter: (Store<AppState> store) => _CategoryAsessmentViewModel(
          user: store.state.loginState.user,
          isLoading: store.state.assessmentState.loading,
          assessment: store.state.loginState.user.assessment.basicAssessment,
          questions: store.state.assessmentState.entreprenurialQuestions ?? []),
      onInit: (store) => store.dispatch(
          GetCategoryAssessmentAction(user: store.state.loginState.user)),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.user.updatedAt != null) {
          if (previousViewModel!.user.assessment.basicAssessment !=
              newViewModel.user.assessment.basicAssessment) {
            CustomFlushbar.showFlushbar(context, "Success Update Profile",
                "Basic Informations Updated", AppColor.flushbarSuccessBG);
          }
        }
      },
      builder: (BuildContext context, _CategoryAsessmentViewModel viewModel) {
        return _CategoryAsessmentContent(
            title: "Category Assessment",
            isLoading: viewModel.isLoading,
            user: viewModel.user,
            questions: viewModel.questions,
            assessment: viewModel.assessment);
      },
    );
  }
}

class _CategoryAsessmentViewModel {
  final UMKMUser user;
  final bool isLoading;
  final List<String> questions;
  final CategoryAssessment assessment;

  _CategoryAsessmentViewModel(
      {required this.user,
      required this.isLoading,
      required this.questions,
      required this.assessment});
}

class _CategoryAsessmentContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;
  final List<String> questions;
  final CategoryAssessment assessment;

  const _CategoryAsessmentContent(
      {required this.title,
      required this.isLoading,
      required this.user,
      required this.assessment,
      required this.questions});

  @override
  _CategoryAsessmentContentState createState() =>
      _CategoryAsessmentContentState();
}

class _CategoryAsessmentContentState extends State<_CategoryAsessmentContent> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _bussinessKey = GlobalKey<BusinessFeasabilityState>();
  final _decisionMakingKey = GlobalKey<DecisionMakingState>();
  final _businessCommKey = GlobalKey<BusinessCommunicationState>();
  final _collaborationKey = GlobalKey<CollaborationState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didUpdateWidget(covariant _CategoryAsessmentContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
            child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Stack(
                  children: [
                    Column(children: [
                      BusinessFeasability(
                        key: _bussinessKey,
                        assessment: widget.assessment.businessFeas,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DecisionMaking(
                        key: _decisionMakingKey,
                        assessment: widget.assessment.decisionMaking,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BusinessCommunication(
                        key: _businessCommKey,
                        assessment: widget.assessment.businessComm,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Collaboration(
                          key: _collaborationKey,
                          assessment: widget.assessment.collaboration),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: _submitButton(context, true),
                      ),
                      const SizedBox(
                        height: 70,
                      )
                    ]),
                    widget.isLoading
                        ? const CircularProgressCard()
                        : Container()
                  ],
                ))));
  }

  Widget _submitButton(BuildContext context, bool isFormValid) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return isFormValid
            ? () async {
                int? score = 0;
                Map<String, dynamic> allData = {};
                var businessFeasability =
                    _bussinessKey.currentState!.getFormValues();
                allData.addAll(businessFeasability['value'].toDictionary());
                score = (score + businessFeasability['score']) as int;
                var decisionMaking =
                    _decisionMakingKey.currentState!.getFormValues();
                allData.addAll(decisionMaking['value'].toDictionary());
                score = (score + decisionMaking['score']) as int;
                var businessCom =
                    _businessCommKey.currentState!.getFormValues();
                allData.addAll(businessCom['value'].toDictionary());
                score = (score + businessCom['score']) as int;
                logger.d(allData);
                var collaborationDict =
                    _collaborationKey.currentState!.getFormValues();
                allData.addAll(collaborationDict['value'].toDictionary());
                score = (score + collaborationDict['score']) as int;

                allData.addAll({'score': score});
                store.dispatch(UpdateCategoryAssessmentAction(
                    user: widget.user, assessment: allData));
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
