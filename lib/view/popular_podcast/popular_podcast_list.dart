import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/routes/app_routes.dart';
import 'package:ecpods/util/constant.dart';

import '../../dataFile/data_file.dart';
import '../../model/popular_model.dart';
import '../../util/color_category.dart';
import '../../util/constant_widget.dart';

class PopularPodcastList extends StatefulWidget {
  const PopularPodcastList({super.key});

  @override
  State<PopularPodcastList> createState() => _PopularPodcastListState();
}

class _PopularPodcastListState extends State<PopularPodcastList> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelPopular> popularLists = DataFile.popularList;

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
              getAppBar(() {backClick();}, "Popular Podcast"),
              getVerSpace(30.h),
              buildPopularPodcastList()
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Expanded buildPopularPodcastList() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemCount: popularLists.length,
        primary: true,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          ModelPopular modelPopular = popularLists[index];
          return GestureDetector(
            onTap: (){
              Constant.sendToNext(context, Routes.podcastDetailRoute);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                  color: containerBg, borderRadius: BorderRadius.circular(22.h)),
              child: Column(
                children: [
                  Container(
                    height: 125.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Constant.assetImagePath + modelPopular.image),
                            fit: BoxFit.fill),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(22.h))),
                  ).paddingOnly(top: 8.h, right: 8.h, left: 8.h),
                  getVerSpace(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(modelPopular.name, 16.sp, Colors.white, 1,
                              fontWeight: FontWeight.w700, txtHeight: 1.5.h),
                          getVerSpace(2.h),
                          getCustomFont("${modelPopular.time}  •  Listening",
                              12.sp, searchHint, 1,
                              fontWeight: FontWeight.w400, txtHeight: 1.5.h)
                        ],
                      ),
                      getSvgImage("video_circle.svg", width: 34.h, height: 34.h)
                    ],
                  ).paddingSymmetric(horizontal: 12.h),
                  getVerSpace(12.h)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
