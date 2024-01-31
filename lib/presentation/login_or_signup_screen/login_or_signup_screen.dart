import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/image_constant.dart';
import 'package:todo_app/services/auth/auth_exceptions.dart';
import 'package:todo_app/services/auth/bloc/auth_bloc.dart';
import 'package:todo_app/services/auth/bloc/auth_event.dart';
import 'package:todo_app/services/auth/bloc/auth_state.dart';
import 'package:todo_app/theme/custom_button_style.dart';
import 'package:todo_app/theme/custom_text_style.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/utils/dialogs/error_dialog.dart';
import 'package:todo_app/widgets/custom_elevated_button.dart';
import 'package:todo_app/widgets/custom_image_view.dart';

class LoginOrSignupScreen extends StatelessWidget {
  const LoginOrSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) if (state.exception
            is GenericAuthException) {
          await showErrorDialog(
            context,
            "Authentication Error",
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appTheme.gray5001,
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 39),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 80),
                _buildPageHeader(context),
                SizedBox(height: 40),
                CustomImageView(
                    imagePath: ImageConstant.imgLogoGray5001,
                    height: 105,
                    width: 117),
                SizedBox(height: 40),
                Text("Get in through", style: theme.textTheme.titleMedium),
                SizedBox(height: 40),
                CustomElevatedButton(
                    text: "Sign Up",
                    onPressed: () {
                      onTapSignUp(context);
                    }),
                SizedBox(height: 20),
                CustomElevatedButton(
                    text: "Login",
                    buttonStyle: CustomButtonStyles.fillDeepOrange,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallSecondaryContainer,
                    onPressed: () {
                      onTapLogin(context);
                    }),
                SizedBox(height: 5)
              ]),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: 208,
        child: Text(
          "Welcome to our community",
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
          "We assist individuals in enhancing productivity through intricate solutions.",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall!.copyWith(height: 1.67),
        ),
      ),
    ]);
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapSignUp(BuildContext context) {
    context.read<AuthBloc>().add(
          AuthEventShouldRegister(),
        );
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapLogin(BuildContext context) {
    context.read<AuthBloc>().add(
          AuthEventShouldLogin(),
        );
  }
}
