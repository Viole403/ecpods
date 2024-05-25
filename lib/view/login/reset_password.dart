import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/dialog/pass_change_dialog.dart';

import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  void backClick() {
    Constant.backToPrev(context);
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  final resetForm = GlobalKey<FormState>();

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
          child: Form(
            key: resetForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                getVerSpace(50.h),
                getToolbarWithIcon(() {
                  backClick();
                }),
                getVerSpace(40.h),
                getCustomFont("Reset Password", 26.sp, Colors.white, 1,
                    fontWeight: FontWeight.w700),
                getVerSpace(50.h),
                defaultTextField(
                    context, passwordController, "New Password", "eye.svg",
                    isPass: true, validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Please enter valid password';
                  }
                  return null;
                }),
                getVerSpace(20.h),
                defaultTextField(context, confPasswordController,
                    "Confirm Password", "eye.svg", isPass: true,
                    validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Please enter valid confirm password';
                  }
                  return null;
                }),
                getVerSpace(50.h),
                getButton(
                    context, accentColor, "Change Password", Colors.black, () {

                      Get.dialog(
                        const PassChangeDialog(),
                      );
                }, 18.sp,
                    buttonHeight: 60.h,
                    borderRadius: BorderRadius.circular(12.h),weight: FontWeight.w700),
              ],
            ).paddingSymmetric(horizontal: 20.h),
          ),
        ),
      ),
    );
  }
}
