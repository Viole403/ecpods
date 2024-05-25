import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/controller/controller.dart';

import '../../model/popular_model.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  DownloadController controller = Get.put(DownloadController());

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
        resizeToAvoidBottomInset: false,
        backgroundColor: bgDark,
        body: SafeArea(
          child: GetBuilder<DownloadController>(
            init: DownloadController(),
            builder: (controller) => Column(
              children: [
                getVerSpace(30.h),
                getAppBar(() {
                  backClick();
                  controller.getList(false);
                }, "Downlaoads"),
                getVerSpace(40.h),
                // ignore: unrelated_type_equality_checks
                controller.list == false
                    ? Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getAssetImage("empty_downloads.png",
                                height: 150.h, width: 150.h),
                            getVerSpace(30.h),
                            getCustomFont(
                                "No Download Yet!", 26.sp, Colors.white, 1,
                                fontWeight: FontWeight.w700),
                            getVerSpace(4.h),
                            getMultilineCustomFont(
                                "Your Download will be appere here",
                                16.sp,
                                Colors.white,
                                fontWeight: FontWeight.w400),
                            getVerSpace(30.h),
                            getButton(
                                context, bgDark, "Explore Now", accentColor,
                                () {
                              controller.getList(true);
                            }, 18.sp,
                                weight: FontWeight.w700,
                                borderRadius: BorderRadius.circular(12.h),
                                buttonHeight: 60.h,
                                buttonWidth: 208.w,
                                isBorder: true,
                                borderColor: accentColor,
                                borderWidth: 1.h)
                          ],
                        ))
                    : Expanded(
                        flex: 1,
                        child: ListView.builder(
                          primary: true,
                          shrinkWrap: false,
                          itemCount: controller.downloadLists.length,
                          itemBuilder: (context, index) {
                            ModelPopular modelPopular =
                                controller.downloadLists[index];
                            return Container(
                              decoration: BoxDecoration(
                                  color: containerBg,
                                  borderRadius: BorderRadius.circular(22.h)),
                              padding: EdgeInsets.all(12.h),
                              child: Row(
                                children: [
                                  getAssetImage(modelPopular.image,
                                      height: 56.h, width: 56.h),
                                  getHorSpace(12.h),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getCustomFont(modelPopular.name, 16.sp,
                                            Colors.white, 1,
                                            fontWeight: FontWeight.w700),
                                        getVerSpace(6.h),
                                        getCustomFont(
                                            "${modelPopular.time}  •  Listening",
                                            12.sp,
                                            searchHint,
                                            1,
                                            fontWeight: FontWeight.w400)
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.removeItem(index);
                                    },
                                    child: getSvgImage("delete.svg",
                                        width: 20.h, height: 20.h),
                                  )
                                ],
                              ),
                            ).marginOnly(bottom: 20.h);
                          },
                        ))
              ],
            ).paddingSymmetric(horizontal: 20.h),
          ),
        ),
      ),
    );
  }
}
