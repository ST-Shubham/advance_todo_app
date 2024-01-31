import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/image_constant.dart';
import 'package:todo_app/services/auth/bloc/auth_bloc.dart';
import 'package:todo_app/services/auth/bloc/auth_state.dart';
import 'package:todo_app/theme/app_decoration.dart';
import 'package:todo_app/theme/custom_text_style.dart';
import 'package:todo_app/theme/theme_helper.dart';
import 'package:todo_app/widgets/custom_elevated_button.dart';
import 'package:todo_app/widgets/custom_icon_button.dart';
import 'package:todo_app/widgets/custom_image_view.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class WishListScreen extends StatelessWidget {
  WishListScreen({Key? key}) : super(key: key);

  TextEditingController filesizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 43),
                  child: Column(children: [
                    CustomIconButton(
                      height: 24,
                      width: 24,
                      padding: EdgeInsets.all(6),
                      alignment: Alignment.centerLeft,
                      onTap: () {
                        onTapBtnArrowLeft(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(height: 75),
                    _buildPageHeader(context),
                    SizedBox(height: 85),
                    _buildDate(context,
                        date: "Task todo",
                        calendar: ImageConstant.imgCalendarOnprimarycontainer,
                        ttMmYy: "Create Action Mobile"),
                    SizedBox(height: 18),
                    _buildDate(context,
                        date: "Date",
                        calendar: ImageConstant.imgCalendar,
                        ttMmYy: "tt/mm/yy"),
                    SizedBox(height: 18),
                    _buildAttachments(context),
                    SizedBox(height: 50),
                    CustomElevatedButton(
                        text: "Make a wish list",
                        buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                        onPressed: () {
                          onTapMakeAWishList(context);
                        }),
                    SizedBox(height: 5)
                  ])))),
    );
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Make a wish list", style: theme.textTheme.headlineMedium),
      SizedBox(height: 11),
      Text("Make your job easier with our reminders",
          style: theme.textTheme.labelLarge)
    ]);
  }

  /// Section Widget
  Widget _buildAttachments(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Attachments", style: CustomTextStyles.labelLargeOnPrimary_1),
      SizedBox(height: 12),
      CustomTextFormField(
          controller: filesizeController,
          hintText: "maximum 10 mb",
          hintStyle: CustomTextStyles.titleSmallOnPrimary,
          textInputAction: TextInputAction.done,
          prefix: Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 17),
              child: CustomImageView(
                  imagePath: ImageConstant.imgClose, height: 23, width: 24)),
          prefixConstraints: BoxConstraints(maxHeight: 58),
          contentPadding: EdgeInsets.only(top: 18, right: 30, bottom: 18),
          borderDecoration: TextFormFieldStyleHelper.outlineOnPrimaryTL14)
    ]);
  }

  /// Common widget
  Widget _buildDate(
    BuildContext context, {
    required String date,
    required String calendar,
    required String ttMmYy,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(date,
          style: CustomTextStyles.labelLargeOnPrimary_1
              .copyWith(color: theme.colorScheme.onPrimary.withOpacity(0.6))),
      SizedBox(height: 12),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 16),
          decoration: AppDecoration.outlineOnPrimary
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder14),
          child: Row(children: [
            CustomImageView(imagePath: calendar, height: 23, width: 24),
            Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(ttMmYy,
                    style: CustomTextStyles.titleSmallOnPrimary.copyWith(
                        color: theme.colorScheme.onPrimary.withOpacity(0.6))))
          ]))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapBtnArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapMakeAWishList(BuildContext context) {
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   AppRoutes.signupScreen,
    //   (_) => false,
    // );
  }
}
