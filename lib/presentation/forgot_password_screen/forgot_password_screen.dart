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

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateNeedVerification) {
          if (state.exception is UserNotLoggedInAuthException) {
            await showErrorDialog(
              context,
              "Critical Error: User Not Logged In",
            );
          } else if (state.exception is EmailNotVerifiedAuthException) {
            await showErrorDialog(
              context,
              "Email not Verified",
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
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 31, vertical: 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPageHeader(context),
                      SizedBox(height: 30),
                      Text("Forgot Password",
                          style: theme.textTheme.titleMedium),
                      SizedBox(height: 45),
                      CustomTextFormField(
                          controller: emailController,
                          hintText: "Your Email",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress),
                      SizedBox(height: 19),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 246,
                          margin: EdgeInsets.only(right: 64),
                          child: Text(
                            "Please enter your registered email.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall!.copyWith(
                              height: 1.67,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: _buildStart(context),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 56,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 32, top: 14, bottom: 17),
        onTap: () {
          context.read<AuthBloc>().add(const AuthEventLogout());
        },
      ),
      actions: [
        AppbarTitle(
          text: "Forgot Password",
          margin: EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 14,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 262,
          margin: EdgeInsets.only(right: 48),
          child: Text(
            "Helping others means helping yourself. ",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.displaySmall!.copyWith(height: 1.29),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 245,
          margin: EdgeInsets.only(right: 65),
          child: Text(
            "If you are always helping others you are helping yourself too",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelLarge!.copyWith(
              height: 1.67,
            ),
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildStart(BuildContext context) {
    return CustomElevatedButton(
      text: "Submit",
      margin: EdgeInsets.only(left: 32, right: 32, bottom: 52),
      onPressed: () {
        String email = emailController.text;
        context.read<AuthBloc>().add(AuthEventForgotPassword(email));
      },
    );
  }
}
