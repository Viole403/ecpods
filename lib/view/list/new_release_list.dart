import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/routes/app_routes.dart';

import '../../dataFile/data_file.dart';
import '../../model/release_model.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';
import '../../util/device_util.dart';

class NewReleaseListScreen extends StatefulWidget {
  const NewReleaseListScreen({super.key});

  @override
  State<NewReleaseListScreen> createState() => _NewReleaseListScreenState();
}

class _NewReleaseListScreenState extends State<NewReleaseListScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelRelease> releaseLists = DataFile.releaseList;

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
              }, "New Releases"),
              getVerSpace(40.h),
              buildNewReleaseList()
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Expanded buildNewReleaseList() {
    var height = 215.h;
    var margin = 20.h;
    var crossAxisCount = DeviceUtil.isTablet ? 4 : 2;
    var screenWidth =
        ((context.width - (margin * crossAxisCount)) / crossAxisCount) - margin;
    return Expanded(
      flex: 1,
      child: GridView.builder(
        primary: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: releaseLists.length,
        itemBuilder: (context, index) {
          ModelRelease modelRelease = releaseLists[index];
          return GestureDetector(
            onTap: () {
              Constant.sendToNext(context, Routes.podcastDetailRoute);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 177.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.h),
                      image: DecorationImage(
                          image: AssetImage(
                              Constant.assetImagePath + modelRelease.image),
                          fit: BoxFit.fill)),
                ),
                getVerSpace(12.h),
                getCustomFont(modelRelease.name, 14.sp, Colors.white, 1,
                    fontWeight: FontWeight.w400),
                getVerSpace(2.h),
                getCustomFont("250 Plays", 12.sp, searchHint, 1,
                    fontWeight: FontWeight.w400)
              ],
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: margin,
          childAspectRatio: screenWidth / height,
          crossAxisSpacing: margin,
        ),
      ),
    );
  }
}
