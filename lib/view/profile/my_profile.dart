import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/controller/controller.dart';
import 'package:ecpods/util/constant_widget.dart';

import '../../util/color_category.dart';
import '../../util/constant.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    nameController.text = "Masalief Maulana";
    emailController.text = "admin@masalief.my.id";
    phoneController.text = "(62)851-5621-7662";
    dateController.text = "4 July,2022";
    setStatusBarColor(bgDark);
    Constant.setupSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgDark,
        body: SafeArea(
          child: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) => Column(
              children: [
                getVerSpace(30.h),
                buildAppBar(controller),
                getVerSpace(30.h),
                buildImageWidget(controller),
                getVerSpace(30.h),
                getProfileTextField(
                  context,
                  nameController,
                  "Full Name",
                  "profile.svg",
                  isReadonly: controller.edit.value ? false : true,
                ),
                getVerSpace(20.h),
                getProfileTextField(
                  context,
                  emailController,
                  "Email",
                  "email.svg",
                  isReadonly: controller.edit.value ? false : true,
                ),
                getVerSpace(20.h),
                getProfileTextField(
                  context,
                  phoneController,
                  "Phone Number",
                  "call.svg",
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  isReadonly: controller.edit.value ? false : true,
                ),
                getVerSpace(20.h),
                getProfileTextField(
                  context,
                  dateController,
                  "Date of Birth",
                  "calendar.svg",
                  isReadonly: controller.edit.value ? false : true,
                ),
                getVerSpace(50.h),
                getButton(
                    context,
                    accentColor,
                    controller.edit.value ? "Save" : "Edit Profile",
                    Colors.black, () {
                  controller.editchange();
                }, 18.sp,
                    weight: FontWeight.w700,
                    borderRadius: BorderRadius.circular(12.h),
                    buttonHeight: 60.h)
              ],
            ).paddingSymmetric(horizontal: 20.h),
          ),
        ),
      ),
    );
  }

  Stack buildImageWidget(ProfileController controller) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        (controller.imagePath.value.isNotEmpty)
            ? Container(
                height: 110.h,
                width: 110.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(110.h / 2),
                    image: DecorationImage(
                        image: FileImage(File(controller.imagePath.value)),
                        fit: BoxFit.fill)),
              )
            : getAssetImage("profile_image.png", height: 110.h, width: 110.h),
        controller.edit.value
            ? GestureDetector(
                onTap: () {
                  controller.getImage();
                },
                child: getAssetImage("edit.png", width: 30.h, height: 30.h))
            : const SizedBox()
      ],
    );
  }

  Widget buildAppBar(ProfileController controller) {
    return getAppBar(() {
      controller.editFalse();
      backClick();
    }, controller.edit.value ? "Edit Profile" : "My Profile");
  }
}
