import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/dataFile/data_file.dart';

import '../../model/release_model.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelRelease> historyLists = DataFile.historyList;

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
              }, "History"),
              getVerSpace(40.h),
              historyLists.isEmpty
                  ? buildEmptyHistoryList()
                  : buildHistoryList()
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Expanded buildHistoryList() {
    return Expanded(
        flex: 1,
        child: ListView.builder(
          primary: true,
          shrinkWrap: false,
          itemCount: historyLists.length,
          itemBuilder: (context, index) {
            ModelRelease modelRelease = historyLists[index];
            return Container(
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                  color: containerBg,
                  borderRadius: BorderRadius.circular(22.h)),
              child: Row(
                children: [
                  getAssetImage(modelRelease.image, height: 76.h, width: 76.h),
                  getHorSpace(12.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCustomFont(modelRelease.name, 16.sp, Colors.white, 1,
                            fontWeight: FontWeight.w700),
                        getVerSpace(6.h),
                        getCustomFont("By Slate Plus", 12.sp, searchHint, 1,
                            fontWeight: FontWeight.w400)
                      ],
                    ),
                  )
                ],
              ),
            ).marginOnly(bottom: 20.h);
          },
        ));
  }

  Expanded buildEmptyHistoryList() {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getAssetImage("empty_history.png", height: 150.h, width: 150.h),
            getVerSpace(30.h),
            getCustomFont("No History Yet!", 26.sp, Colors.white, 1,
                fontWeight: FontWeight.w700),
            getVerSpace(4.h),
            getMultilineCustomFont(
                "Lorem ipsum dolor sit amet, consectetur ", 16.sp, Colors.white,
                fontWeight: FontWeight.w400)
          ],
        ));
  }
}
