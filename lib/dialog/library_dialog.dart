import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:get/get.dart';
import 'package:ecpods/controller/controller.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant_widget.dart';

import '../routes/app_routes.dart';
import '../util/constant.dart';

// ignore: must_be_immutable
class LibraryDialog extends StatefulWidget {
  int index;

  LibraryDialog(this.index, {super.key});

  @override
  State<LibraryDialog> createState() => _LibraryDialogState();
}

class _LibraryDialogState extends State<LibraryDialog> {
  LibraryController controller = Get.put(LibraryController());

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          decoration: BoxDecoration(
              color: lightBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(22.h))),
          child: Column(
            children: [
              getVerSpace(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCustomFont("Office Ladies", 20.sp, Colors.white, 1,
                      fontWeight: FontWeight.w700),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 30.h,
                      width: 30.h,
                      decoration: BoxDecoration(
                        color: dividerColor,
                        borderRadius: BorderRadius.circular(30.h),
                      ),
                      child: getSvgImage("close.svg").paddingAll(7.h),
                    ),
                  )
                ],
              ),
              getVerSpace(20.h),
              getDivider(setColor: dividerColor),
              getVerSpace(30.h),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Constant.sendToNext(context, Routes.podcastDetailRoute);
                },
                child: Row(
                  children: [
                    getSvgImage("play.svg", width: 20.h, height: 20.h),
                    getHorSpace(20.h),
                    getCustomFont("Listen Now", 18.sp, Colors.white, 1,
                        fontWeight: FontWeight.w500)
                  ],
                ),
              ),
              getVerSpace(20.h),
              Row(
                children: [
                  getSvgImage("menu.svg", width: 20.h, height: 20.h),
                  getHorSpace(20.h),
                  getCustomFont("More Information", 18.sp, Colors.white, 1,
                      fontWeight: FontWeight.w500)
                ],
              ),
              getVerSpace(20.h),
              GestureDetector(
                onTap: () async {
                  await FlutterShare.share(
                      title: 'Example share',
                      text: 'Example share text',
                      linkUrl: 'https://flutter.dev/',
                      chooserTitle: 'Example Chooser Title');
                },
                child: Row(
                  children: [
                    getSvgImage("Share.svg", width: 20.h, height: 20.h),
                    getHorSpace(20.h),
                    getCustomFont("Share", 18.sp, Colors.white, 1,
                        fontWeight: FontWeight.w500)
                  ],
                ),
              ),
              getVerSpace(20.h),
              Row(
                children: [
                  getSvgImage("download.svg", width: 20.h, height: 20.h),
                  getHorSpace(20.h),
                  getCustomFont("Download", 18.sp, Colors.white, 1,
                      fontWeight: FontWeight.w500)
                ],
              ),
              getVerSpace(20.h),
              GestureDetector(
                onTap: () {
                  Get.back();
                  controller.removeItem(widget.index);
                },
                child: Row(
                  children: [
                    getSvgImage("close.svg", width: 20.h, height: 20.h),
                    getHorSpace(20.h),
                    getCustomFont(
                        "Remove From Libraray", 18.sp, Colors.white, 1,
                        fontWeight: FontWeight.w500)
                  ],
                ),
              ),
              getVerSpace(40.h),
            ],
          ),
        )
      ],
    );
  }
}
