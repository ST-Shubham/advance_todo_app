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
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
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
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 282,
                        margin: EdgeInsets.only(right: 28),
                        child: Text(
                          "Our community is your community too so let's strengthen our community together",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge!
                              .copyWith(height: 1.67),
                        ),
                      ),
                    ),
                    SizedBox(height: 56),
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
                        onTapNext(context, email);
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
    return AppBar(
      leadingWidth: 56,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 32, top: 14, bottom: 17),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      actions: [
        AppbarTitle(
          text: "Login",
          margin: EdgeInsets.symmetric(horizontal: 48, vertical: 14),
        )
      ],
    );
    // return CustomAppBar(
    // );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventLogout());
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
  onTapNext(BuildContext context, String email) {
    context.read<AuthBloc>().add(
          AuthEventForgotPassword(
            email,
          ),
        );
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapDonTHaveAnAccount(BuildContext context) {
    context.read<AuthBloc>().add(
          AuthEventShouldRegister(),
        );
  }
}
