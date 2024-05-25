import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/routes/app_routes.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant.dart';
import 'package:ecpods/util/constant_widget.dart';

import '../../../controller/controller.dart';
import '../../../dataFile/data_file.dart';
import '../../../dialog/filter_dialog.dart';
import '../../../model/home_slider_model.dart';
import '../../../model/popular_model.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  TextEditingController searchController = TextEditingController();
  HomeScreenController controller = Get.put(HomeScreenController());
  List<ModelHomeSlider> homeSliderLists = DataFile.homeSliderList;
  List<ModelPopular> popularLists = DataFile.popularList;
  List<ModelPopular> trendingLists = DataFile.trendingList;
  List<ModelPopular> lifeStyleLists = DataFile.lifeStyleList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getVerSpace(30.h),
        buildAppBar(),
        getVerSpace(30.h),
        buildSearchWidget(context),
        getVerSpace(30.h),
        Expanded(
            flex: 1,
            child: ListView(
              primary: true,
              shrinkWrap: false,
              children: [
                buildSliderWidget(),
                getVerSpace(20.h),
                buildPopularPodcastList(),
                getVerSpace(30.h),
                buildTrendingPodcastList(),
                getVerSpace(10.h),
                buildLifestylePodcastList(),
                getVerSpace(40.h),
              ],
            ))
      ],
    );
  }

  Column buildLifestylePodcastList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont("Lifestyle & Health  Podcast", 18.sp, Colors.white, 1,
                fontWeight: FontWeight.w700, txtHeight: 1.5.h),
            GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.lifeStylePodcastListRoute);
              },
              child: getCustomFont("View All", 12.sp, accentColor, 1,
                  fontWeight: FontWeight.w700),
            )
          ],
        ).paddingSymmetric(horizontal: 20.h),
        getVerSpace(20.h),
        SizedBox(
          height: 181.h,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              ModelPopular modelPopular = lifeStyleLists[index];
              return GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.podcastDetailRoute);
                },
                child: SizedBox(
                  width: 111.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.h),
                            image: DecorationImage(
                                image: AssetImage(Constant.assetImagePath +
                                    modelPopular.image),
                                fit: BoxFit.fill)),
                        height: 107.h,
                      ),
                      getVerSpace(12.h),
                      getCustomFont(modelPopular.name, 14.sp, Colors.white, 2,
                          fontWeight: FontWeight.w400),
                      getVerSpace(2.h),
                      getCustomFont(modelPopular.time, 12.sp, searchHint, 1,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                ).paddingOnly(left: index == 0 ? 20.h : 0, right: 20.h),
              );
            },
          ),
        )
      ],
    );
  }

  Column buildTrendingPodcastList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getCustomFont("Trending Podcast", 18.sp, Colors.white, 1,
                    fontWeight: FontWeight.w700),
                getHorSpace(8.h),
                getSvgImage("flame.svg", width: 14.h, height: 18.h)
              ],
            ),
            GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.trendingPodcastListRoute);
              },
              child: getCustomFont("View All", 12.sp, accentColor, 1,
                  fontWeight: FontWeight.w700),
            )
          ],
        ).paddingSymmetric(horizontal: 20.h),
        getVerSpace(20.h),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            ModelPopular modelPopular = trendingLists[index];
            return GestureDetector(
              onTap: () {
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
                    getAssetImage(modelPopular.image,
                        height: 76.h, width: 76.h),
                    getHorSpace(12.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                              modelPopular.name, 16.sp, Colors.white, 1,
                              fontWeight: FontWeight.w700),
                          getVerSpace(6.h),
                          getCustomFont("${modelPopular.time}  •  Listening",
                              12.sp, searchHint, 1,
                              fontWeight: FontWeight.w400)
                        ],
                      ),
                    ),
                    getSvgImage("video_circle.svg", width: 34.h, height: 34.h)
                  ],
                ),
              ),
            );
          },
        ).paddingSymmetric(horizontal: 20.h)
      ],
    );
  }

  Column buildPopularPodcastList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont("Popular Podcast", 18.sp, Colors.white, 1,
                fontWeight: FontWeight.w700),
            GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.popularPodcastListRoute);
              },
              child: getCustomFont("View All", 12.sp, accentColor, 1,
                  fontWeight: FontWeight.w700),
            )
          ],
        ).paddingSymmetric(horizontal: 20.h),
        getVerSpace(20.h),
        SizedBox(
          height: 187.h,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: popularLists.length,
            itemBuilder: (context, index) {
              ModelPopular modelPopular = popularLists[index];
              return GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.podcastDetailRoute);
                },
                child: Container(
                  width: 332.h,
                  decoration: BoxDecoration(
                      color: containerBg,
                      borderRadius: BorderRadius.circular(22.h)),
                  child: Column(
                    children: [
                      Container(
                        height: 113.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Constant.assetImagePath +
                                    modelPopular.image),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(22.h))),
                      ).paddingOnly(top: 6.h, right: 6.h, left: 6.h),
                      getVerSpace(12.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCustomFont(
                                  modelPopular.name, 16.sp, Colors.white, 1,
                                  fontWeight: FontWeight.w700),
                              getVerSpace(2.h),
                              Row(
                                children: [
                                  getCustomFont(
                                    modelPopular.time,
                                    12.sp,
                                    searchHint,
                                    1,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  getCustomFont(
                                    "  •  Listening",
                                    12.sp,
                                    searchHint,
                                    1,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              )
                            ],
                          ),
                          getSvgImage("video_circle.svg",
                              height: 34.h, width: 34.h)
                        ],
                      ).paddingSymmetric(horizontal: 12.h)
                    ],
                  ),
                ).paddingOnly(left: index == 0 ? 20.h : 0, right: 20.h),
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildSliderWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider.builder(
            itemCount: homeSliderLists.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              ModelHomeSlider modelHome = homeSliderLists[itemIndex];
              return Container(
                height: 140.h,
                width: 374.w,
                decoration: BoxDecoration(
                    color: modelHome.color.toColor(),
                    borderRadius: BorderRadius.circular(22.h),
                    image: DecorationImage(
                        image: AssetImage(
                            Constant.assetImagePath + modelHome.image),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    modelHome.title == ""
                        ? Container()
                        : Column(
                            children: [
                              getCustomFont(
                                  modelHome.title, 20.sp, Colors.black, 1,
                                  fontWeight: FontWeight.w700,
                                  txtHeight: 1.5.h,
                                  textAlign: TextAlign.start),
                              getVerSpace(2.h),
                            ],
                          ),
                    getMultilineCustomFont(
                        modelHome.discription, 16.sp, Colors.black,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                        txtHeight: 1.5.h),
                    getVerSpace(12.h),
                    Row(
                      children: [
                        getCustomFont("Get Started ", 12.sp, Colors.black, 1,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.underline),
                        getHorSpace(6.h),
                        getSvgImage("arrow-right.svg",
                            width: 16.h, height: 16.h)
                      ],
                    )
                  ],
                ).paddingOnly(left: 190.w, right: 14.h),
              ).paddingOnly(right: 14.h);
            },
            options: CarouselOptions(
                height: 140.h,
                viewportFraction: 1.06.h,
                initialPage: 0,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  controller.indexChange(index.obs);
                })),
        getVerSpace(16.h),
        GetBuilder<HomeScreenController>(
          init: HomeScreenController(),
          builder: (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              homeSliderLists.length,
              (position) {
                return getSvgImage(
                        position == controller.index.value
                            ? "select_dot.svg"
                            : "unselect_dot.svg",
                        height: 7.h,
                        width: 7.h)
                    .paddingOnly(left: position == 0 ? 0 : 3.h, right: 3.h);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget buildSearchWidget(BuildContext context) {
    return getSearchWidget(context, "Search...", searchController,
            isEnable: false,
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
      Constant.sendToNext(context, Routes.searchScreenRoute);
    }, isReadonly: true)
        .paddingSymmetric(horizontal: 20.h);
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getTwoRichText(
              "POD",
              accentColor,
              FontWeight.w700,
              22.sp,
              "CAST",
              Colors.white,
              FontWeight.w700,
              22.sp,
            )
          ],
        ),
        GestureDetector(
            onTap: () {
              Constant.sendToNext(context, Routes.myProfileScreenRoute);
            },
            child:
                getAssetImage("profile_image.png", height: 50.h, width: 50.h))
      ],
    ).paddingSymmetric(horizontal: 20.h);
  }
}
