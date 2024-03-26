import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/assessment/assessment.action.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';

class BasicCategoryAssessmentPage extends StatelessWidget {
  const BasicCategoryAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _BasicCategoryAssessmentViewModel>(
      converter: (Store<AppState> store) => _BasicCategoryAssessmentViewModel(
          user: store.state.loginState.user,
          isLoading: store.state.assessmentState.loading,
          store: store.state.loginState.user.store,
          questions: store.state.assessmentState.entreprenurialQuestions ?? []),
      onInit: (store) => store.dispatch(
          GetUmkmStoreDetailAction(id: store.state.loginState.user.id)),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.user.store.updatedAt != null) {
          if (previousViewModel!.user.store.updatedAt!
              .isBefore(newViewModel.user.store.updatedAt!)) {
            CustomFlushbar.showFlushbar(context, "Success Update Profile",
                "Basic Informations Updated", AppColor.flushbarSuccessBG);
          }
        }
      },
      builder:
          (BuildContext context, _BasicCategoryAssessmentViewModel viewModel) {
        return _BasicCategoryAssessmentContent(
          title: "Category Assessment",
          isLoading: viewModel.isLoading,
          user: viewModel.user,
          store: viewModel.store,
        );
      },
    );
  }
}

class _BasicCategoryAssessmentViewModel {
  final UMKMUser user;
  final bool isLoading;
  final List<String> questions;
  final UMKMStore? store;

  _BasicCategoryAssessmentViewModel(
      {required this.user,
      required this.isLoading,
      required this.questions,
      required this.store});
}

class _BasicCategoryAssessmentContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final UMKMUser user;
  final UMKMStore? store;

  const _BasicCategoryAssessmentContent(
      {required this.title,
      required this.isLoading,
      required this.user,
      required this.store});

  @override
  _BasicCategoryAssessmentContentState createState() =>
      _BasicCategoryAssessmentContentState();
}

class _BasicCategoryAssessmentContentState
    extends State<_BasicCategoryAssessmentContent> {
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
                          Text('Basic Informations',
                              style: CustomTextStyles.normalText(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                              keyboardType: TextInputType.number,
                              prefixIcon: Icon(
                                MdiIcons.officeBuilding,
                                color: AppColor.darkDatalab,
                              ),
                              initialValue: widget.store?.totalAsset.toString(),
                              labelText: 'Total Asset',
                              hintText: 'Total owned assets in Rupiah',
                              fieldName: 'asset'),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                              keyboardType: TextInputType.number,
                              prefixIcon: Icon(
                                MdiIcons.cash,
                                color: AppColor.darkDatalab,
                              ),
                              initialValue:
                                  widget.store?.totalRevenue.toString(),
                              labelText: 'Total Revenue',
                              hintText: 'Total revenue per month in Rupiah',
                              fieldName: 'revenue'),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                              keyboardType: TextInputType.number,
                              prefixIcon: Icon(
                                MdiIcons.truckCargoContainer,
                                color: AppColor.darkDatalab,
                              ),
                              initialValue:
                                  widget.store?.productionCapacity.toString(),
                              labelText: 'Production Capacity',
                              hintText: 'Total Production per Month',
                              fieldName: 'production'),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                              keyboardType: TextInputType.number,
                              prefixIcon: const Icon(
                                Icons.people_alt_outlined,
                                color: AppColor.darkDatalab,
                              ),
                              initialValue:
                                  widget.store?.permanentWorkers.toString(),
                              hintText: 'Total Permanent Workers',
                              labelText: 'Permanent Workers',
                              fieldName: 'permanentWorkers'),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                              keyboardType: TextInputType.number,
                              prefixIcon: const Icon(
                                Icons.people_sharp,
                                color: AppColor.darkDatalab,
                              ),
                              initialValue:
                                  widget.store?.nonPermanentWorkers.toString(),
                              hintText: 'Total Non Permanent Workers',
                              labelText: 'Non-Permanent Workers',
                              fieldName: 'nonPermanentWorkers'),
                          const SizedBox(
                            height: 24,
                          ),
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
                int asset =
                    int.parse(_formKey.currentState?.fields["asset"]?.value);
                int revenue =
                    int.parse(_formKey.currentState?.fields["revenue"]?.value);
                int production = int.parse(
                    _formKey.currentState?.fields["production"]?.value);
                int permanentWorkers = int.parse(
                    _formKey.currentState?.fields["permanentWorkers"]?.value);
                int nonPermanentWorkers = int.parse(_formKey
                    .currentState?.fields["nonPermanentWorkers"]?.value);
                store.dispatch(AddBasicAssessmentAction(
                    asset: asset,
                    revenue: revenue,
                    production: production,
                    permanentWorkers: permanentWorkers,
                    nonPermanentWorkers: nonPermanentWorkers,
                    store: widget.store!));
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
