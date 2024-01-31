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

class WorkTodayScreen extends StatelessWidget {
  const WorkTodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: SafeArea(
          child: Scaffold(
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 43),
                  child: Column(children: [
                    CustomIconButton(
                      height: 24,
                      width: 24,
                      alignment: Alignment.centerLeft,
                      onTap: () {
                        onTapBtnArrowLeft(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(height: 79),
                    _buildPageHeader(context),
                    SizedBox(height: 78),
                    _buildDate(context),
                    SizedBox(height: 59),
                    _buildTodoWorkItem(context),
                    _buildTodoWorkItem1(context),
                    SizedBox(height: 96),
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
      Text("Work Today’s", style: theme.textTheme.headlineMedium),
      SizedBox(height: 7),
      Text("Make your job easier with our reminders",
          style: theme.textTheme.labelLarge)
    ]);
  }

  /// Section Widget
  Widget _buildDate(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 6, bottom: 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Today", style: CustomTextStyles.titleSmallBlack900),
            SizedBox(height: 5),
            Text("02 April 2021", style: CustomTextStyles.titleMediumBlack900)
          ])),
      CustomIconButton(
          height: 58,
          width: 60,
          padding: EdgeInsets.all(17),
          decoration: IconButtonStyleHelper.fillGray,
          child: CustomImageView(imagePath: ImageConstant.imgCalendar))
    ]);
  }

  /// Section Widget
  Widget _buildTodoWorkItem(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
        decoration: AppDecoration.fillWhiteA,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 26,
              width: 28,
              decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6))),
          Padding(
              padding: EdgeInsets.only(left: 13, top: 3, bottom: 2),
              child:
                  Text("Research Product", style: theme.textTheme.bodyMedium)),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowIcon,
              height: 5,
              width: 3,
              margin: EdgeInsets.symmetric(vertical: 10))
        ]));
  }

  /// Section Widget
  Widget _buildTodoWorkItem1(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
        decoration: AppDecoration.fillWhiteA,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 26,
              width: 28,
              decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6))),
          Padding(
              padding: EdgeInsets.only(left: 13, top: 3, bottom: 2),
              child: Text("Create Action Plan",
                  style: theme.textTheme.bodyMedium)),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowIcon,
              height: 5,
              width: 3,
              margin: EdgeInsets.symmetric(vertical: 10))
        ]));
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
