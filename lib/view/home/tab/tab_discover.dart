import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/dataFile/data_file.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant.dart';

import '../../../dialog/filter_dialog.dart';
import '../../../model/release_model.dart';
import '../../../routes/app_routes.dart';
import '../../../util/constant_widget.dart';

class TabDiscover extends StatefulWidget {
  const TabDiscover({super.key});

  @override
  State<TabDiscover> createState() => _TabDiscoverState();
}

class _TabDiscoverState extends State<TabDiscover> {
  TextEditingController searchController = TextEditingController();
  List<ModelRelease> releaseLists = DataFile.releaseList;
  List<String> recommendedLists = DataFile.recommendedList;
  List<String> trendingPodcastLists = DataFile.trendingPodcastList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getVerSpace(30.h),
        buildSearchWidget(context),
        getVerSpace(30.h),
        Expanded(
            flex: 1,
            child: ListView(
              primary: true,
              shrinkWrap: false,
              children: [
                buildReleaseList(),
                getVerSpace(30.h),
                buildRecommendedList(),
                getVerSpace(30.h),
                buildTrendingList(),
                getVerSpace(46.h)
              ],
            ))
      ],
    );
  }

  Column buildTrendingList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont('Trending Podcast', 18.sp, Colors.white, 1,
                fontWeight: FontWeight.w700),
            GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.trendingListRoute);
              },
              child: getCustomFont("View All", 12.sp, accentColor, 1,
                  fontWeight: FontWeight.w700),
            )
          ],
        ).paddingSymmetric(horizontal: 20.h),
        getVerSpace(20.h),
        SizedBox(
          height: 160.h,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: trendingPodcastLists.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.podcastDetailRoute);
                },
                child: Container(
                  width: 316.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.h),
                      image: DecorationImage(
                          image: AssetImage(Constant.assetImagePath +
                              trendingPodcastLists[index]),
                          fit: BoxFit.fill)),
                ).marginOnly(left: index == 0 ? 20.h : 0, right: 20.h),
              );
            },
          ),
        )
      ],
    );
  }

  Column buildRecommendedList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont('Recommended', 18.sp, Colors.white, 1,
                fontWeight: FontWeight.w700),
            GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.recommendedListRoute);
              },
              child: getCustomFont("View All", 12.sp, accentColor, 1,
                  fontWeight: FontWeight.w700),
            )
          ],
        ).paddingSymmetric(horizontal: 20.h),
        getVerSpace(20.h),
        SizedBox(
          height: 107.h,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: recommendedLists.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.podcastDetailRoute);
                },
                child: Container(
                  width: 111.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.h),
                      image: DecorationImage(
                          image: AssetImage(Constant.assetImagePath +
                              recommendedLists[index]),
                          fit: BoxFit.fill)),
                ).marginOnly(left: index == 0 ? 20.h : 0, right: 20.h),
              );
            },
          ),
        )
      ],
    );
  }

  Column buildReleaseList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont('New Releases', 18.sp, Colors.white, 1,
                fontWeight: FontWeight.w700),
            GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.newReleaseListRoute);
              },
              child: getCustomFont("View All", 12.sp, accentColor, 1,
                  fontWeight: FontWeight.w700),
            )
          ],
        ).paddingSymmetric(horizontal: 20.h),
        getVerSpace(20.h),
        SizedBox(
          height: 230.h,
          child: ListView.builder(
            itemCount: releaseLists.length,
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              ModelRelease modelRelease = releaseLists[index];
              return GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.podcastDetailRoute);
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: index == 0 ? 20.h : 0, right: 20.h),
                  width: 177.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 177.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            image: DecorationImage(
                                image: AssetImage(Constant.assetImagePath +
                                    modelRelease.image),
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
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildSearchWidget(BuildContext context) {
    return getSearchWidget(context, "Search anything...", searchController,
            isEnable: true,
            isprefix: true,
            prefix: Row(
              children: [
                getHorSpace(18.h),
                getSvgImage("search.svg", height: 24.h, width: 24.h),
              ],
            ),
            constraint: BoxConstraints(maxHeight: 24.h, maxWidth: 55.h),
            withSufix: true,
            suffiximage: "filter.svg", imagefunction: () {
      Get.bottomSheet(const FilterDialog(), isScrollControlled: true);
    }, onTap: () {
      // Constant.sendToNext(context, Routes.searchScreenRoute);
    }, isReadonly: false)
        .paddingSymmetric(horizontal: 20.h);
  }
}
