import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/dataFile/data_file.dart';
import 'package:ecpods/util/constant_widget.dart';

import '../../model/popular_model.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelPopular> notificationLists = DataFile.notificationList;

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
          child: Column(
            children: [
              getVerSpace(30.h),
              getAppBar(() {
                backClick();
              }, "Notifications"),
              getVerSpace(40.h),
              notificationLists.isEmpty
                  ? buildNullListWidget()
                  : buildNotificationList()
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Expanded buildNotificationList() {
    return Expanded(
        flex: 1,
        child: ListView.builder(
          primary: true,
          shrinkWrap: false,
          itemCount: notificationLists.length,
          itemBuilder: (context, index) {
            ModelPopular modelPopular = notificationLists[index];
            return Container(
              decoration: BoxDecoration(
                  color: lightBg, borderRadius: BorderRadius.circular(22.h)),
              padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 19.h),
              child: Row(
                children: [
                  getAssetImage(modelPopular.image, width: 42.h, height: 42.h),
                  getHorSpace(18.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(modelPopular.name, 16.sp, Colors.white, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(2.h),
                      getCustomFont(modelPopular.time, 12.sp, hintColor, 1,
                          fontWeight: FontWeight.w400)
                    ],
                  )
                ],
              ),
            ).marginOnly(bottom: 20.h);
          },
        ));
  }

  Expanded buildNullListWidget() {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getAssetImage("empty_notification.png",
                height: 150.h, width: 150.h),
            getVerSpace(30.h),
            getCustomFont("No Notification Yet!", 26.sp, Colors.white, 1,
                fontWeight: FontWeight.w700),
            getVerSpace(4.h),
            getMultilineCustomFont(
                "We’ll notify you when something arrives.", 16.sp, Colors.white,
                fontWeight: FontWeight.w400)
          ],
        ));
  }
}
