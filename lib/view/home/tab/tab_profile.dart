import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/routes/app_routes.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/pref_data.dart';

import '../../../util/constant.dart';
import '../../../util/constant_widget.dart';

class TabProfile extends StatefulWidget {
  const TabProfile({super.key});

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {
  void backClick() {
    // Constant.closeApp();
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getVerSpace(30.h),
        getAppBar(() {
          backClick();
        }, "Profile")
            .paddingSymmetric(horizontal: 20.h),
        getVerSpace(30.h),
        Expanded(
          flex: 1,
          child: ListView(
            primary: true,
            shrinkWrap: false,
            children: [
              getAssetImage("profile_image.png", height: 110.h, width: 110.h),
              getVerSpace(14.h),
              getCustomFont("Masalief Maulana", 20.sp, Colors.white, 1,
                  fontWeight: FontWeight.w700, textAlign: TextAlign.center),
              getVerSpace(4.h),
              getCustomFont("admin@masalief.my.id", 14.sp, hintColor, 1,
                  fontWeight: FontWeight.w400, textAlign: TextAlign.center),
              getVerSpace(30.h),
              getProfileWidget(() {
                Constant.sendToNext(context, Routes.myProfileScreenRoute);
              }, "profile.svg", "My Profile")
                  .marginSymmetric(horizontal: 20.h),
              getVerSpace(16.h),
              getProfileWidget(() {
                Constant.sendToNext(context, Routes.notificationScreenRoute);
              }, "notification.svg", "Notifications")
                  .marginSymmetric(horizontal: 20.h),
              getVerSpace(16.h),
              getProfileWidget(() {
                Constant.sendToNext(context, Routes.downloadRoute);
              }, "download1.svg", "Downloads")
                  .marginSymmetric(horizontal: 20.h),
              getVerSpace(16.h),
              getProfileWidget(() {
                Constant.sendToNext(context, Routes.historyRoute);
              }, "history1.svg", "History")
                  .marginSymmetric(horizontal: 20.h),
              getVerSpace(16.h),
              getProfileWidget(() {
                Constant.sendToNext(context, Routes.privacyRoute);
              }, "lock.svg", "Privacy Policy")
                  .marginSymmetric(horizontal: 20.h),
              getVerSpace(16.h),
              getProfileWidget(() {
                Constant.sendToNext(context, Routes.termConditionRoute);
              }, "info.svg", "Terms and condition")
                  .marginSymmetric(horizontal: 20.h),
              getVerSpace(50.h),
              getButton(context, bgDark, "Logout", accentColor, () {
                PrefData.setIsSignIn(true);
                Constant.sendToNext(context, Routes.loginRoute);
              }, 18.sp,
                      weight: FontWeight.w700,
                      buttonHeight: 60.h,
                      borderRadius: BorderRadius.circular(12.h),
                      borderWidth: 1.h,
                      isBorder: true,
                      borderColor: accentColor)
                  .marginSymmetric(horizontal: 20.h),
              getVerSpace(40.h)
            ],
          ),
        )
      ],
    );
  }
}
