import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/services/auth/auth_exceptions.dart';
import 'package:todo_app/services/auth/bloc/auth_bloc.dart';
import 'package:todo_app/services/auth/bloc/auth_event.dart';
import 'package:todo_app/services/auth/bloc/auth_state.dart';
import 'package:todo_app/theme/custom_text_style.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/utils/dialogs/error_dialog.dart';
import 'package:todo_app/widgets/app_bar/custom_app_bar.dart';
import 'package:todo_app/widgets/custom_elevated_button.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(
              context,
              'Weak Password',
            );
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(
              context,
              'Email is already in use',
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              'Please Enter a valid Email',
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              'Authentication Error',
            );
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appTheme.gray5001,
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(context),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 27),
              child: Padding(
                padding: EdgeInsets.only(left: 28, right: 32, bottom: 5),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    _buildPageHeader(context),
                    SizedBox(height: 60),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "E-mail",
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 24),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "Password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    SizedBox(height: 27),
                    CustomElevatedButton(
                        text: "Next",
                        onPressed: () {
                          String email = emailController.text;
                          String password = passwordController.text;
                          onTapNext(context, email, password);
                        }),
                    SizedBox(height: 29),
                    GestureDetector(
                      onTap: () {
                        onTapAlreadyHaveAn(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style: theme.textTheme.labelLarge),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text("Login",
                                style: CustomTextStyles
                                    .labelLargeSecondaryContainerSemiBold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      context: context,
      leadingWidth: 52,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
        onPressed: () {
          onTapArrowLeft(context);
        },
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: 280,
        child: Text(
          "Join us Today!",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.displaySmall!.copyWith(height: 1.18),
        ),
      ),
      SizedBox(height: 2),
      Container(
        width: 281,
        margin: EdgeInsets.only(right: 29),
        child: Text(
          "Please provide the following details to create an account.",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall!.copyWith(height: 1.67),
        ),
      ),
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    context.read<AuthBloc>().add(
          const AuthEventLogout(),
        );
  }

  /// Navigates to the homeScreen when the action is triggered.
  onTapNext(BuildContext context, String email, String password) {
    print(email);
    print(password);
    context.read<AuthBloc>().add(
          AuthEventRegister(
            email,
            password,
          ),
        );
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapAlreadyHaveAn(BuildContext context) {
    context.read<AuthBloc>().add(
          AuthEventShouldLogin(),
        );
  }
}
