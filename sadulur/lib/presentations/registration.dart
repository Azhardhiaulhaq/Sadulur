// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis/domains/v1.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/bezier_container.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/presentations/widgets/naviagion_bar.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/login/login.action.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SignUpPageViewModel>(
      converter: (Store<AppState> store) => _SignUpPageViewModel(
          isLoggedIn: store.state.loginState.isLoggedIn,
          isLoading: store.state.loginState.loading,
          user: store.state.loginState.user,
          errorMessage: store.state.loginState.error),
      onWillChange: (previousViewModel, newViewModel) {
        if (newViewModel.isLoggedIn) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigation(
                  menuScreenContext: context, user: newViewModel.user),
            ),
            (route) => false, // Remove all existing routes from the stack
          );
        }
      },
      builder: (BuildContext context, _SignUpPageViewModel viewModel) {
        return _SignUpPageContent(
          title: title,
          isLoading: viewModel.isLoading,
          isLoggedIn: viewModel.isLoggedIn,
          errorMessage: viewModel.errorMessage,
        );
      },
    );
  }
}

class _SignUpPageViewModel {
  final bool isLoggedIn;
  final bool isLoading;
  final String? errorMessage;
  final UMKMUser user;
  _SignUpPageViewModel(
      {required this.isLoggedIn,
      required this.isLoading,
      this.errorMessage,
      required this.user});
}

class _SignUpPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;

  const _SignUpPageContent(
      {required this.title,
      required this.isLoading,
      required this.isLoggedIn,
      this.errorMessage});

  @override
  _SignUpPageContentState createState() => _SignUpPageContentState();
}

class _SignUpPageContentState extends State<_SignUpPageContent> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "");

  Widget _submitButton(BuildContext context, bool isFormValid) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return isFormValid
            ? () async {
                String email = emailController.text;
                String password = passwordController.text;
                String userName = usernameController.text;
                await store.dispatch(RegistrationAction(
                    email: email,
                    password: password,
                    context: context,
                    userName: userName));
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
                  'Masuk',
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

  Widget _createAccountLabel(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sudah punya akun ?',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColor.darkDatalab),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Daftar',
              style: TextStyle(
                  color: AppColor.secondaryTextDatalab,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      color: AppColor.backgroundDatalab,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * .2),
                    const Text(
                      "Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.textDatalab),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      labelText: "Masukkan alamat email",
                      fieldName: "email",
                      controller: emailController,
                      prefixIcon:
                          const Icon(Icons.email, color: AppColor.darkDatalab),
                      validator: FormBuilderValidators.email(
                          errorText: "Email Tidak Valid"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Nama Pengguna",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.textDatalab),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      labelText: "Masukkan User Name",
                      fieldName: "username",
                      controller: usernameController,
                      prefixIcon:
                          const Icon(Icons.person, color: AppColor.darkDatalab),
                      validator: FormBuilderValidators.required(
                          errorText: 'Username Wajib Diisi'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.textDatalab),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        labelText: "Masukkan Password",
                        fieldName: "password",
                        isPassword: true,
                        prefixIcon:
                            const Icon(Icons.lock, color: AppColor.darkDatalab),
                        controller: passwordController,
                        validator: FormBuilderValidators.minLength(8,
                            errorText: 'Password Minimal 8 Karakter')),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Konfirmasi Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.textDatalab),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        labelText: "Konfirmasi Password",
                        fieldName: "confirmPassword",
                        isPassword: true,
                        prefixIcon: const Icon(Icons.lock_outlined,
                            color: AppColor.darkDatalab),
                        controller: confirmPasswordController,
                        validator: FormBuilderValidators.equal(
                            passwordController.text,
                            errorText: 'Password Tidak Cocok')),
                    const SizedBox(
                      height: 20,
                    ),
                    _submitButton(
                        context, _formKey.currentState?.validate() ?? false),
                    SizedBox(
                      height: height * .055,
                    ),
                    _createAccountLabel(context)
                  ]),
            )),
          ),
          widget.isLoading
              ? const Center(
                  child: CircularProgressCard(),
                )
              : Container(),
        ],
      ),
    ));
  }
}
