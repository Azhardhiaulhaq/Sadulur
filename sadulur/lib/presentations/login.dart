// ------------------------------------------ //
// Template from : TheAlphamerc               //
// Github : TheAlphamerc/flutter_login_signup //
// ------------------------------------------ //

// ignore: unused_import
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/registration.dart';
import 'package:sadulur/presentations/widgets/bezier_container.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/widgets/form/custom_text_field.dart';
import 'package:sadulur/presentations/widgets/navigation_bar.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/login/login.action.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _LoginPageViewModel>(
      converter: (Store<AppState> store) => _LoginPageViewModel(
          isLoggedIn: store.state.loginState.isLoggedIn,
          user: store.state.loginState.user,
          isLoading: store.state.loginState.loading,
          errorMessage: store.state.loginState.error),
      onWillChange: (previousViewModel, newViewModel) {
        if (newViewModel.isLoggedIn) {
          CustomFlushbar.showFlushbar(
              context,
              "Login Success",
              "Welcome ${newViewModel.user.name ?? "Back"}!",
              AppColor.flushbarErrorBG);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigation(
                  menuScreenContext: context, user: newViewModel.user),
            ),
            (route) => false, // Remove all existing routes from the stack
          );
        } else if (newViewModel.errorMessage != '') {
          CustomFlushbar.showFlushbar(
              context,
              "Login Failed",
              newViewModel.errorMessage ??
                  "Something went wrong when logging in",
              AppColor.flushbarErrorBG);
        }
      },
      builder: (BuildContext context, _LoginPageViewModel viewModel) {
        return _LoginPageContent(
          title: title,
          isLoading: viewModel.isLoading,
          isLoggedIn: viewModel.isLoggedIn,
          errorMessage: viewModel.errorMessage,
        );
      },
    );
  }
}

class _LoginPageViewModel {
  final bool isLoggedIn;
  final bool isLoading;
  final String? errorMessage;
  final UMKMUser user;

  _LoginPageViewModel(
      {required this.isLoggedIn,
      required this.isLoading,
      this.errorMessage,
      required this.user});
}

class _LoginPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;

  const _LoginPageContent(
      {required this.title,
      required this.isLoading,
      required this.isLoggedIn,
      this.errorMessage});

  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<_LoginPageContent> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  Widget _submitButton(BuildContext context, bool isFormValid) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return isFormValid
            ? () async {
                String email = emailController.text;
                String password = passwordController.text;
                logger.d("Email : $email, Password : $password");
                await store.dispatch(LoginAction(
                    email: email, password: password, context: context));
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpPage(title: 'Sign Up'),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Belum punya akun ?',
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * .3),
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
                      keyboardType: TextInputType.emailAddress,
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
                        validator: FormBuilderValidators.required(
                            errorText: "Password wajib diisi")),
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
