import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/widgets/form/custom_radio_group.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/assessment/assessment.action.dart';

class EntrepreneurialAssessmentPage extends StatelessWidget {
  const EntrepreneurialAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _EntrepreneurialAssessmentViewModel>(
      converter: (Store<AppState> store) => _EntrepreneurialAssessmentViewModel(
          user: store.state.loginState.user,
          isLoading: store.state.assessmentState.loading,
          questions: store.state.assessmentState.entreprenurialQuestions ?? []),
      onInit: (store) => store.dispatch(
          GetEntreprenurialAssessmentAction(user: store.state.loginState.user)),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.user != null &&
            !listEquals(
                previousViewModel
                    ?.user.assessment.entrepreneurialAssessment.assessment,
                newViewModel
                    .user.assessment.entrepreneurialAssessment.assessment) &&
            previousViewModel!.user.updatedAt
                .isBefore(newViewModel.user.updatedAt)) {
          CustomFlushbar.showFlushbar(context, "Success Update Assessment",
              "Entrepreneurial Assessment Updated", AppColor.flushbarSuccessBG);
        }
      },
      builder: (BuildContext context,
          _EntrepreneurialAssessmentViewModel viewModel) {
        return _EntrepreneurialAssessmentContent(
          title: "Entrepreneurial Assessment",
          isLoading: viewModel.isLoading,
          user: viewModel.user,
          questions: viewModel.questions,
        );
      },
    );
  }
}

class _EntrepreneurialAssessmentViewModel {
  final UMKMUser user;
  final bool isLoading;
  final List<String> questions;

  _EntrepreneurialAssessmentViewModel(
      {required this.user, required this.isLoading, required this.questions});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _EntrepreneurialAssessmentViewModel &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}

class _EntrepreneurialAssessmentContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;
  final List<String> questions;

  const _EntrepreneurialAssessmentContent(
      {required this.title,
      required this.isLoading,
      required this.user,
      required this.questions});

  @override
  _EntrepreneurialAssessmentContentState createState() =>
      _EntrepreneurialAssessmentContentState();
}

class _EntrepreneurialAssessmentContentState
    extends State<_EntrepreneurialAssessmentContent> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<int> selectedValues = [];

  void setSelectedValues() {
    if (widget.questions.isNotEmpty) {
      setState(() {
        selectedValues = List<int>.filled(widget.questions.length, 1);
        for (int i = 0;
            i <
                widget.user.assessment.entrepreneurialAssessment.assessment
                    .length;
            i++) {
          selectedValues[i] = int.parse(
              widget.user.assessment.entrepreneurialAssessment.assessment[i]);
        }
      });
    }
  }

  @override
  void initState() {
    setSelectedValues();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _EntrepreneurialAssessmentContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setSelectedValues();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.questions.length,
                            itemBuilder: (context, index) {
                              return CustomRadioGroup(
                                labelText:
                                    "${index + 1}. ${widget.questions[index]}",
                                name: "question_${index + 1}",
                                onSelectionChanged: (value) {
                                  setState(() {
                                    selectedValues[index] = int.parse(value!);
                                  });
                                },
                                initialValue: (index <
                                        widget
                                            .user
                                            .assessment
                                            .entrepreneurialAssessment
                                            .assessment
                                            .length)
                                    ? widget
                                        .user
                                        .assessment
                                        .entrepreneurialAssessment
                                        .assessment[index]
                                    : '1',
                              );
                            },
                          ),
                          _submitButton(context, true, selectedValues),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                      widget.questions.isEmpty || widget.isLoading
                          ? const CircularProgressCard()
                          : Container()
                    ],
                  ))),
        )));
  }

  bool isCriteriaMet(List<int> listValue, int number) {
    return listValue[number - 1] == 5;
  }

  List<String> evaluateCharacteristics(List<int> listValue) {
    List<String> characteristics = [];
    if (isCriteriaMet(listValue, 1) && isCriteriaMet(listValue, 8)) {
      characteristics.add("Work Hard");
      characteristics.add("Is Energetic");
    }

    if (isCriteriaMet(listValue, 6)) {
      characteristics.add("Wants Financial Success");
    }

    if (isCriteriaMet(listValue, 2)) {
      characteristics.add("Has Family Support");
    }

    if (isCriteriaMet(listValue, 10)) {
      characteristics.add("Has Internal Locus of Control");
    }

    if (isCriteriaMet(listValue, 3)) {
      characteristics.add("Takes Risks");
    }

    if (isCriteriaMet(listValue, 4)) {
      characteristics.add("Sacrifices Employment Benefits ");
    }

    if (isCriteriaMet(listValue, 7) && isCriteriaMet(listValue, 11)) {
      characteristics.add("Has a Need to Achieve ");
    }
    if (isCriteriaMet(listValue, 12)) {
      characteristics.add("Has Business Experience");
    }

    if (isCriteriaMet(listValue, 5) && isCriteriaMet(listValue, 9)) {
      characteristics.add("Is Independent");
    }

    if (isCriteriaMet(listValue, 14)) {
      characteristics.add("Has a Self-employed Parent as a Role Model");
    }

    if (isCriteriaMet(listValue, 10) &&
        isCriteriaMet(listValue, 15) &&
        isCriteriaMet(listValue, 18)) {
      characteristics.add("Has Self-confidence");
    }

    if (isCriteriaMet(listValue, 16)) {
      characteristics.add("Has Integrity");
    }

    if (isCriteriaMet(listValue, 17)) {
      characteristics.add("Has Determination");
    }

    if (isCriteriaMet(listValue, 13) && isCriteriaMet(listValue, 19)) {
      characteristics.add("Adapts to Change");
    }

    if (isCriteriaMet(listValue, 20)) {
      characteristics.add("Has a Good Network of Professionals ");
    }

    return characteristics;
  }

  Widget _submitButton(
      BuildContext context, bool isFormValid, List<int> selectedValues) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () async {
          List<String> characteristics =
              evaluateCharacteristics(selectedValues);

          int totalScore = selectedValues.fold(
              0, (previousValue, element) => previousValue + element);
          List<String> stringList =
              selectedValues.map((int number) => number.toString()).toList();

          store.dispatch(AddEntreprenurialAssessmentAction(
              assessment: stringList,
              characteristic: characteristics,
              score: totalScore,
              user: widget.user));
        };
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
