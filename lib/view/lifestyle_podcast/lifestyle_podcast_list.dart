import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../dataFile/data_file.dart';
import '../../model/popular_model.dart';
import '../../routes/app_routes.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';
import '../../util/device_util.dart';

class LifeStylePodcastList extends StatefulWidget {
  const LifeStylePodcastList({super.key});

  @override
  State<LifeStylePodcastList> createState() => _LifeStylePodcastListState();
}

class _LifeStylePodcastListState extends State<LifeStylePodcastList> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelPopular> lifeStyleLists = DataFile.lifeStyleList;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerSpace(30.h),
              getAppBar(() {
                backClick();
              }, "Lifestyle & Health  Podcast"),
              getVerSpace(40.h),
              buildLifestylePodcastList()
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Expanded buildLifestylePodcastList() {
    var height = 165.h;
    var margin = 20.h;
    var crossAxisCount = DeviceUtil.isTablet ? 5 : 3;
    var screenWidth =
        ((context.width - (margin * crossAxisCount)) / crossAxisCount) - margin;
    return Expanded(
      flex: 1,
      child: GridView.builder(
        primary: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: lifeStyleLists.length,
        itemBuilder: (context, index) {
          ModelPopular modelPopular = lifeStyleLists[index];
          return GestureDetector(
            onTap: (){
              Constant.sendToNext(context, Routes.podcastDetailRoute);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 107.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              Constant.assetImagePath + modelPopular.image),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(22.h)),
                ),
                getVerSpace(12.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont(modelPopular.name, 14.sp, Colors.white, 2,
                          fontWeight: FontWeight.w400),
                      getVerSpace(2.h),
                      getCustomFont(modelPopular.time, 12.sp, searchHint, 1,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                )
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
