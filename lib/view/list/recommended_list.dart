import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../dataFile/data_file.dart';
import '../../routes/app_routes.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';
import '../../util/device_util.dart';

class RecommendedList extends StatefulWidget {
  const RecommendedList({super.key});

  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<String> recommendedLists = DataFile.recommendedList;

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
              }, "Recommended "),
              getVerSpace(40.h),
              buildRecommendedList()
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Expanded buildRecommendedList() {
    var height = 107.h;
    var margin = 20.h;
    var crossAxisCount = DeviceUtil.isTablet ? 6 : 3;
    var screenWidth =
        ((context.width - (margin * crossAxisCount)) / crossAxisCount) - margin;
    return Expanded(
      flex: 1,
      child: GridView.builder(
        primary: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: recommendedLists.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.podcastDetailRoute);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.h),
                    image: DecorationImage(
                        image: AssetImage(
                            Constant.assetImagePath + recommendedLists[index]),
                        fit: BoxFit.fill)),
              ));
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
