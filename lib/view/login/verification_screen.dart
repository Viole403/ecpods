import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/util/constant.dart';
import 'package:pinput/pinput.dart';

import '../../dialog/account_create_dialog.dart';
import '../../util/color_category.dart';
import '../../util/constant_widget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(bgDark);
    Constant.setupSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: bgDark,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              getVerSpace(50.h),
              getToolbarWithIcon(() {
                backClick();
              }).paddingSymmetric(horizontal: 20.h),
              getVerSpace(40.h),
              getCustomFont("Verification", 26.sp, Colors.white, 1,
                  fontWeight: FontWeight.w700, txtHeight: 1.5.h),
              getVerSpace(40.h),
              Pinput(
                focusedPinTheme: PinTheme(
                  decoration: BoxDecoration(
                    border: Border.all(color: dividerColor, width: 1.h),
                    borderRadius: BorderRadius.circular(16.h),
                  ),
                  height: 50.h,
                  width: 50.h,
                  margin: EdgeInsets.symmetric(horizontal: 5.h),
                  textStyle: TextStyle(
                      fontSize: 18.h,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constant.fontsFamily),
                ),
                disabledPinTheme: PinTheme(
                  width: 50.h,
                  height: 50.h,
                  margin: EdgeInsets.symmetric(horizontal: 5.h),
                  textStyle: TextStyle(
                      fontSize: 18.h,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constant.fontsFamily),
                  decoration: BoxDecoration(
                      color: bgDark,
                      border: Border.all(color: dividerColor, width: 1.h),
                      borderRadius: BorderRadius.circular(16.h)),
                ),
                defaultPinTheme: PinTheme(
                  width: 50.h,
                  height: 50.h,
                  margin: EdgeInsets.symmetric(horizontal: 5.h),
                  textStyle: TextStyle(
                      fontSize: 18.h,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constant.fontsFamily),
                  decoration: BoxDecoration(
                      color: bgDark,
                      border: Border.all(color: dividerColor, width: 1.h),
                      borderRadius: BorderRadius.circular(16.h)),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {},
                length: 5,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              getVerSpace(30.h),
              getTwoRichText(
                  "Don’t receive code? ",
                  "#A5A4AA".toColor(),
                  FontWeight.w400,
                  16.sp,
                  "Resend",
                  Colors.white,
                  FontWeight.w700,
                  16.sp,
                  textAlign: TextAlign.center,
                  txtHeight: 1.5.h,
                  function: () {}),
              getVerSpace(50.h),
              getButton(context, accentColor, "Verify & Proceed", Colors.black,
                      () {
                Get.dialog(const AccountCreateDialog());
              }, 18.sp,
                      buttonHeight: 60.h,
                      borderRadius: BorderRadius.circular(12.h),
                      weight: FontWeight.w700)
                  .paddingSymmetric(horizontal: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
