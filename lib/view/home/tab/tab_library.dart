import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/controller/controller.dart';
import 'package:ecpods/dialog/library_dialog.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant_widget.dart';

import '../../../model/release_model.dart';
import '../../../util/constant.dart';

class TabLibrary extends StatefulWidget {
  const TabLibrary({super.key});

  @override
  State<TabLibrary> createState() => _TabLibraryState();
}

class _TabLibraryState extends State<TabLibrary> {
  void backClick() {
    Constant.closeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getVerSpace(30.h),
        getAppBar(() {
          backClick();
        }, "My Library")
            .paddingSymmetric(horizontal: 20.h),
        getVerSpace(30.h),
        buildLibraryList(),
        buildAddStoriesButton(context),
        getVerSpace(40.h)
      ],
    );
  }

  Widget buildAddStoriesButton(BuildContext context) {
    return getButton(context, accentColor, "Add More Stories", Colors.black,
            () {}, 18.sp,
            weight: FontWeight.w700,
            borderRadius: BorderRadius.circular(12.h),
            buttonHeight: 60.h)
        .marginSymmetric(horizontal: 20.h);
  }

  Expanded buildLibraryList() {
    return Expanded(
        flex: 1,
        child: GetBuilder<LibraryController>(
          init: LibraryController(),
          builder: (controller) => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            primary: true,
            shrinkWrap: false,
            itemCount: controller.libraryLists.length,
            itemBuilder: (context, index) {
              ModelRelease modelRelease = controller.libraryLists[index];
              return Container(
                padding: EdgeInsets.all(12.h),
                decoration: BoxDecoration(
                    color: containerBg,
                    borderRadius: BorderRadius.circular(22.h)),
                child: Row(
                  children: [
                    getAssetImage(modelRelease.image,
                        width: 76.h, height: 76.h),
                    getHorSpace(12.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                              modelRelease.name, 16.sp, Colors.white, 1,
                              fontWeight: FontWeight.w700),
                          getVerSpace(6.h),
                          getCustomFont("By Slate Plus", 12.sp, searchHint, 1,
                              fontWeight: FontWeight.w400)
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.bottomSheet(LibraryDialog(index),
                              isScrollControlled: true);
                        },
                        child:
                            getSvgImage("more.svg", height: 24.h, width: 24.h))
                  ],
                ),
              ).marginOnly(bottom: 20.h);
            },
          ),
        ));
  }
}
