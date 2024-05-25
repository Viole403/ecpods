import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../dataFile/data_file.dart';
import '../../routes/app_routes.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<String> trendingPodcastLists = DataFile.trendingPodcastList;

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
              }, "Trending Podcast"),
              getVerSpace(40.h),
              buildTrendingList()
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Widget buildTrendingList() {
    return Expanded(
      child: ListView.builder(
        primary: true,
        shrinkWrap: false,
        itemCount: trendingPodcastLists.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Constant.sendToNext(context, Routes.podcastDetailRoute);
            },
            child: Container(
              height: 160.h,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.h),
                  image: DecorationImage(
                      image: AssetImage(Constant.assetImagePath +
                          trendingPodcastLists[index]),
                      fit: BoxFit.fill)),
            ),
          );
        },
      ),
    );
  }
}
