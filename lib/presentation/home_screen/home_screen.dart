import 'package:flutter/material.dart';
import 'package:todo_app/core/app_export.dart';

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
              SizedBox(height: 47),
              _buildHomeOption(context),
              SizedBox(height: 13),
              _buildHomeOption1(context),
              SizedBox(height: 13),
              _buildHomeOption2(context),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHomeOption(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4),
      padding: EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 16,
      ),
      decoration: AppDecoration.fillSecondaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUser,
            height: 18,
            width: 20,
            margin: EdgeInsets.symmetric(vertical: 4),
          ),
          Spacer(
            flex: 45,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              "Personality",
              style: CustomTextStyles.titleMediumSecondaryContainer,
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
    );
  }

  /// Section Widget
  Widget _buildHomeOption1(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4),
      padding: EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 16,
      ),
      decoration: AppDecoration.fillDeepPurpleA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFile,
            height: 20,
            width: 17,
            margin: EdgeInsets.only(
              left: 3,
              top: 3,
              bottom: 3,
            ),
          ),
          Spacer(
            flex: 43,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              "Work Today's",
              style: CustomTextStyles.titleMediumDeeppurpleA400,
            ),
          ),
          Spacer(
            flex: 56,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgStroke1DeepPurpleA400,
            height: 6,
            width: 5,
            radius: BorderRadius.circular(
              2,
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHomeOption2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4),
      padding: EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 15,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgSearch,
            height: 20,
            width: 19,
            margin: EdgeInsets.only(
              left: 3,
              top: 4,
              bottom: 4,
            ),
          ),
          Spacer(
            flex: 45,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              "Setting",
              style: CustomTextStyles.titleMediumPrimary,
            ),
          ),
          Spacer(
            flex: 54,
          ),
        ],
      ),
    );
  }
}
