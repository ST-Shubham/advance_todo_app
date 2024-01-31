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
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLogin) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              "User Not Found",
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              "Wrong Credentials",
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              "Please enter a valid email-id",
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              "Authentication Error",
            );
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(context),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 11),
              child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32, bottom: 5),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    _buildPageHeader(context),
                    SizedBox(height: 60),
                    CustomTextFormField(
                        controller: emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                        borderDecoration:
                            TextFormFieldStyleHelper.outlineOnPrimaryTL14),
                    SizedBox(height: 24),
                    CustomTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        borderDecoration:
                            TextFormFieldStyleHelper.outlineOnPrimaryTL14),
                    SizedBox(height: 26),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          onTapTxtForgotPassword(context);
                        },
                        child: Text("Forgot Password?",
                            style: CustomTextStyles
                                .labelLargeSecondaryContainerSemiBold),
                      ),
                    ),
                    SizedBox(height: 23),
                    CustomElevatedButton(
                      text: "Next",
                      onPressed: () {
                        String email = emailController.text;
                        String password = passwordController.text;
                        onTapNext(
                          context,
                          email,
                          password,
                        );
                      },
                    ),
                    SizedBox(height: 33),
                    GestureDetector(
                      onTap: () {
                        onTapDonTHaveAnAccount(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Text("Don’t have an account?",
                                style: theme.textTheme.labelLarge),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text("SignUp",
                                style: CustomTextStyles
                                    .labelLargeSecondaryContainerSemiBold),
                          )
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
            "Login",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: 208,
        child: Text(
          "Welcome Back!",
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
          "Please Enter your Credentials to Login",
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

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgotPassword(BuildContext context) {
    context.read<AuthBloc>().add(
          AuthEventForgotPassword(
            null,
          ),
        );
  }

  /// Navigates to the homeScreen when the action is triggered.
  onTapNext(
    BuildContext context,
    String email,
    String password,
  ) {
    context.read<AuthBloc>().add(AuthEventLogin(email, password));
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapDonTHaveAnAccount(BuildContext context) {
    context.read<AuthBloc>().add(
          AuthEventShouldRegister(),
        );
  }
}
