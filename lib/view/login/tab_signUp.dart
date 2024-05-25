// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/controller/controller.dart';
import 'package:ecpods/routes/app_routes.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant.dart';

import '../../util/constant_widget.dart';

// ignore: must_be_immutable
class TabSignUp extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var pageController;

  TabSignUp(this.pageController, {super.key});

  @override
  State<TabSignUp> createState() => _TabSignUpState();
}

class _TabSignUpState extends State<TabSignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final signUpForm = GlobalKey<FormState>();
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpForm,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) => Column(
          children: [
            defaultTextField(
                context, nameController, "Full Name", "profile.svg",
                validator: (name) {
              if (name == null || name.isEmpty) {
                return 'Please enter full name';
              }
              return null;
            }),
            getVerSpace(20.h),
            defaultTextField(context, emailController, "Email", "email.svg",
                validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Please enter email';
              }
              return null;
            }),
            getVerSpace(20.h),
            getCountryTextFiled(
                context, phoneController, "Phone  Number", "call.svg",
                validator: (phone) {
              if (phone == null || phone.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            }),
            getVerSpace(20.h),
            defaultTextField(context, passwordController, "Password", "eye.svg",
                validator: (password) {
              if (password == null || password.isEmpty) {
                return 'Please enter password';
              }
              return null;
            }),
            getVerSpace(16.h),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      controller.onValueChange();
                    },
                    child: getSvgImage(
                        controller.select.value ? "check.svg" : "uncheck.svg",
                        height: 20.h,
                        width: 20.h)),
                getHorSpace(8.h),
                getCustomFont(
                    "I agree with Terms & Privacy ", 12.sp, hintColor, 1,
                    fontWeight: FontWeight.w400)
              ],
            ),
            getVerSpace(54.h),
            getButton(context, accentColor, "Sign Up", Colors.black, () {
              Constant.sendToNext(context, Routes.verificationRoute);
            }, 18.sp,
                buttonHeight: 60.h,
                borderRadius: BorderRadius.circular(12.h),
                weight: FontWeight.w700),
            getVerSpace(35.h),
            getTwoRichText(
                "Already have a account?  ",
                "#A5A4AA".toColor(),
                FontWeight.w400,
                16.sp,
                "Login",
                Colors.white,
                FontWeight.w700,
                16.sp,
                textAlign: TextAlign.center,
                txtHeight: 1.5.h, function: () {
              widget.pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            })
          ],
        ).paddingSymmetric(horizontal: 20.h),
      ),
    );
  }
}
