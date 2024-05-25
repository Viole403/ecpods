import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../dataFile/data_file.dart';
import '../../model/popular_model.dart';
import '../../routes/app_routes.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';

class TrendingPodcastList extends StatefulWidget {
  const TrendingPodcastList({super.key});

  @override
  State<TrendingPodcastList> createState() => _TrendingPodcastListState();
}

class _TrendingPodcastListState extends State<TrendingPodcastList> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelPopular> trendingLists = DataFile.trendingList;

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
              }, "Trending Podcast"),
              getVerSpace(30.h),
              buildTrendingPodcastList()
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Expanded buildTrendingPodcastList() {
    return Expanded(
        flex: 1,
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: trendingLists.length,
          itemBuilder: (context, index) {
            ModelPopular modelPopular = trendingLists[index];
            return GestureDetector(
              onTap: (){
                Constant.sendToNext(context, Routes.podcastDetailRoute);
              },
              child: Container(
                padding: EdgeInsets.all(12.h),
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                    color: containerBg,
                    borderRadius: BorderRadius.circular(22.h)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getAssetImage(modelPopular.image, height: 76.h, width: 76.h),
                    getHorSpace(12.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(modelPopular.name, 16.sp, Colors.white, 1,
                              fontWeight: FontWeight.w700, txtHeight: 1.5.h),
                          getVerSpace(6.h),
                          getCustomFont("${modelPopular.time}  •  Listening",
                              12.sp, searchHint, 1,
                              fontWeight: FontWeight.w400, txtHeight: 1.5.h)
                        ],
                      ),
                    ),
                    getSvgImage("video_circle.svg", width: 34.h, height: 34.h)
                  ],
                ),
              ),
            );
          },
        ));
  }
}
