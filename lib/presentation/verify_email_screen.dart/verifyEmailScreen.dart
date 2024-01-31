import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/services/auth/auth_exceptions.dart';
import 'package:todo_app/services/auth/bloc/auth_bloc.dart';
import 'package:todo_app/services/auth/bloc/auth_event.dart';
import 'package:todo_app/services/auth/bloc/auth_state.dart';
import 'package:todo_app/theme/custom_button_style.dart';
import 'package:todo_app/theme/custom_text_style.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/utils/dialogs/error_dialog.dart';
import 'package:todo_app/widgets/custom_elevated_button.dart';

class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({Key? key}) : super(key: key);
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
              "Please verify your email first.",
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
                      Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 60,
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Email is not Verified",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 246,
                        child: Text(
                          "We've Sent you an Email Verification, Please Verify Your Email.",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall!.copyWith(
                            height: 1.67,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomElevatedButton(
                        text: "Submit",
                        margin: EdgeInsets.only(
                          left: 52,
                          right: 52,
                          bottom: 20,
                        ),
                        onPressed: () {
                          onTapSubmit(context);
                        },
                      ),
                      CustomElevatedButton(
                        text: "Resend",
                        margin: EdgeInsets.only(
                          left: 52,
                          right: 52,
                          bottom: 20,
                        ),
                        buttonTextStyle:
                            CustomTextStyles.titleSmallSecondaryContainer,
                        buttonStyle: CustomButtonStyles.fillDeepOrange,
                        onPressed: () {
                          onTapResend(context);
                        },
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          onTapLogout(context);
                        },
                        text: 'Logout',
                        margin: EdgeInsets.only(
                          left: 52,
                          right: 52,
                        ),
                        buttonTextStyle:
                            CustomTextStyles.titleSmallSecondaryContainer_1,
                        buttonStyle: CustomButtonStyles.fillGray,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // bottomNavigationBar: _buildStart(context),
        ),
      ),
    );
  }

  //Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email Verification",
            style: theme.textTheme.displaySmall!.copyWith(height: 1.29)),
        SizedBox(height: 40),
      ],
    );
  }

  onTapSubmit(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventCheckVerified());
  }

  onTapLogout(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventLogout());
  }

  onTapResend(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventSendEmailVerification());
  }
}
