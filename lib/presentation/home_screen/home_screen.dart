import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/image_constant.dart';
import 'package:todo_app/services/auth/bloc/auth_bloc.dart';
import 'package:todo_app/services/auth/bloc/auth_event.dart';
import 'package:todo_app/theme/app_decoration.dart';
import 'package:todo_app/theme/custom_text_style.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/utils/dialogs/logout_dialog.dart';
import 'package:todo_app/widgets/custom_image_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 30,
            top: 79,
            right: 30,
          ),
          child: Column(
            children: [
              SizedBox(height: 80),
              Text(
                "Home",
                style: theme.textTheme.displaySmall!.copyWith(height: 1.29),
              ),
              SizedBox(height: 60),
              SizedBox(height: 100),
              _buildHomeOption(
                context: context,
                decoration: AppDecoration.fillSecondaryContainer.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                ),
                iconData: Icons.task_alt_rounded,
                text: "Goals",
                style: CustomTextStyles.titleMediumSecondaryContainer,
                onTap: () {},
              ),
              SizedBox(height: 20),
              _buildHomeOption(
                context: context,
                text: "Tasks",
                decoration: AppDecoration.fillDeepPurpleA.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                ),
                iconData: Icons.task_rounded,
                style: CustomTextStyles.titleMediumDeeppurpleA400,
              ),
              SizedBox(height: 20),
              _buildHomeOption(
                context: context,
                decoration: AppDecoration.fillPrimary.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                ),
                iconData: Icons.book,
                text: "Notes",
                style: CustomTextStyles.titleMediumPrimary,
              ),
              SizedBox(
                height: 20,
              ),
              _buildHomeOption(
                context: context,
                decoration: AppDecoration.fillTertiaryContainer.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                ),
                iconData: Icons.logout,
                text: "Logout",
                style: CustomTextStyles.titleMediumBlack900,
                onTap: () async {
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    context.read<AuthBloc>().add(
                          const AuthEventLogout(),
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHomeOption({
    required BuildContext context,
    Decoration? decoration,
    IconData? iconData,
    required String text,
    TextStyle? style,
    void onTap() = empty,
  }) {
    return Flexible(
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(left: 4),
          padding: EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 16,
          ),
          decoration: decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
              ),
              Spacer(
                flex: 45,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  text,
                  style: style,
                ),
              ),
              Spacer(
                flex: 54,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgStroke1,
                height: 6,
                width: 5,
                radius: BorderRadius.circular(
                  2,
                ),
                margin: EdgeInsets.only(
                  top: 10,
                  right: 5,
                  bottom: 10,
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

void empty() {}
