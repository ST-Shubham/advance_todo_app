import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/app_export.dart';
import 'package:todo_app/services/auth/auth_exceptions.dart';
import 'package:todo_app/services/auth/bloc/auth_bloc.dart';
import 'package:todo_app/services/auth/bloc/auth_event.dart';
import 'package:todo_app/services/auth/bloc/auth_state.dart';
import 'package:todo_app/utils/dialogs/error_dialog.dart';
import 'package:todo_app/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:todo_app/widgets/app_bar/appbar_title.dart';
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
              'This is an invalid Email address',
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              'Failed to Register',
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
                          String email = emailController.text,
                              password = passwordController.text;
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
      leadingWidth: 52,
      leading: AppbarLeadingIconbutton(
          imagePath: ImageConstant.imgArrowLeft,
          margin: EdgeInsets.only(left: 28, top: 14, bottom: 17),
          onTap: () {
            onTapArrowLeft(context);
          }),
      actions: [
        AppbarTitle(
          text: "Sign Up",
          margin: EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 14,
          ),
        ),
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventLogout());
  }

  /// Navigates to the homeScreen when the action is triggered.
  onTapNext(BuildContext context, String email, String password) {
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
