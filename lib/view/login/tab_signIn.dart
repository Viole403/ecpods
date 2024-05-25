// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/routes/app_routes.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant.dart';
import 'package:ecpods/util/constant_widget.dart';

import '../../controller/controller.dart';
import '../../util/pref_data.dart';

// ignore: must_be_immutable
class TabSignIn extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var pageController;

  TabSignIn(this.pageController, {super.key});

  @override
  State<TabSignIn> createState() => _TabSignInState();
}

class _TabSignInState extends State<TabSignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  HomeController controller = Get.put(HomeController());

  final loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginForm,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          defaultTextField(
              context, emailController, "Email Address", "email.svg",
              validator: (email) {
            if (email == null || email.isEmpty) {
              return 'Please enter valid email address';
            }
            return null;
          }),
          getVerSpace(20.h),
          defaultTextField(context, passwordController, "Password", "eye.svg",
              isPass: true, validator: (password) {
            if (password == null || password.isEmpty) {
              return 'Please enter valid password';
            }
            return null;
          }),
          getVerSpace(16.h),
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.forgotPasswordRoute);
                },
                child: getCustomFont("Forgot Password", 16.sp, Colors.white, 1,
                    fontWeight: FontWeight.w400),
              )),
          getVerSpace(50.h),
          getButton(context, accentColor, "Login", Colors.black, () {
            controller.onChange(0.obs);
            PrefData.setIsSignIn(false);
            Constant.sendToNext(context, Routes.homeScreenRoute);
          }, 18.sp,
              buttonHeight: 60.h,
              borderRadius: BorderRadius.circular(12.h),
              weight: FontWeight.w700),
          getVerSpace(30.h),
          Row(
            children: [
              Expanded(child: getDivider(setColor: dividerColor)),
              getCustomFont("Or Continue With", 12.sp, Colors.white, 1,
                      fontWeight: FontWeight.w400)
                  .paddingSymmetric(horizontal: 20.h),
              Expanded(child: getDivider(setColor: dividerColor)),
            ],
          ),
          getVerSpace(30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                  color: lightBg,
                  borderRadius: BorderRadius.circular(12.h),
                ),
                child: getSvgImage("google.svg", height: 24.h, width: 24.h)
                    .paddingAll(18.h),
              ),
              getHorSpace(30.h),
              Container(
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                  color: lightBg,
                  borderRadius: BorderRadius.circular(12.h),
                ),
                child: getSvgImage("facebook.svg", height: 24.h, width: 24.h)
                    .paddingAll(18.h),
              ),
              getHorSpace(30.h),
              Container(
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                  color: lightBg,
                  borderRadius: BorderRadius.circular(12.h),
                ),
                child: getSvgImage("apple.svg", height: 24.h, width: 24.h)
                    .paddingAll(18.h),
              )
            ],
          ),
          getVerSpace(58.h),
          getTwoRichText(
              "Create New Account?  ",
              "#A5A4AA".toColor(),
              FontWeight.w400,
              16.sp,
              "Sign Up",
              Colors.white,
              FontWeight.w700,
              16.sp,
              textAlign: TextAlign.center,
              txtHeight: 1.5.h, function: () {
            widget.pageController.animateToPage(1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          })
        ],
      ).paddingSymmetric(horizontal: 20.h),
    );
  }
}
