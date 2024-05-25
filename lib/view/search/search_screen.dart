import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/controller/controller.dart';
import 'package:ecpods/dataFile/data_file.dart';
import 'package:ecpods/dialog/filter_dialog.dart';
import 'package:ecpods/util/constant_widget.dart';

import '../../model/upcoming_model.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  TextEditingController searchController = TextEditingController();
  SearchController controller = Get.put(SearchController());
  List<ModelUpcoming> upcomingLists = DataFile.upcomingList;

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
          child: GetBuilder<SearchController>(
            init: SearchController(),
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerSpace(30.h),
                GestureDetector(
                  onTap: () {
                    backClick();
                  },
                  child:
                      getSvgImage("arrow_back.svg", height: 24.h, width: 24.h)
                          .paddingSymmetric(horizontal: 20.h),
                ),
                getVerSpace(30.h),
                buildSearchWidget(context, controller),
                getVerSpace(19.h),
                if (controller.searchList.isEmpty)
                  buildNullListWidget()
                else
                  Expanded(
                      flex: 1,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        primary: true,
                        shrinkWrap: false,
                        children: [
                          buildSearchList(controller),
                          getVerSpace(10.h),
                          buildUpcomingList()
                        ],
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildUpcomingList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont("Upcoming Podcast", 18.sp, Colors.white, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(20.h),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: upcomingLists.length,
          itemBuilder: (context, index) {
            ModelUpcoming modelUpcoming = upcomingLists[index];
            return Row(
              children: [
                getAssetImage(modelUpcoming.image, width: 50.h, height: 50.h),
                getHorSpace(20.h),
                Expanded(
                  flex: 1,
                  child: getCustomFont(
                      modelUpcoming.name, 16.sp, Colors.white, 1,
                      fontWeight: FontWeight.w400),
                ),
                getCustomFont(modelUpcoming.date, 16.sp, Colors.white, 1,
                    fontWeight: FontWeight.w400)
              ],
            ).marginOnly(bottom: 20.h);
          },
        )
      ],
    );
  }

  Column buildSearchList(SearchController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont("Recent Search", 18.sp, Colors.white, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(20.h),
        ListView.builder(
          itemCount: controller.searchList.length,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: getCustomFont(
                      controller.searchList[index], 14.sp, Colors.white, 1,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  child: getSvgImage("close.svg", height: 20.h, width: 20.h),
                  onTap: () {
                    controller.itemRemove(index);
                  },
                )
              ],
            ).marginOnly(bottom: 20.h);
          },
        )
      ],
    );
  }

  Expanded buildNullListWidget() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getAssetImage("no_search.png", width: 150.h, height: 150.h),
        getVerSpace(40.h),
        getCustomFont("No Result to show!", 26.sp, Colors.white, 1,
            fontWeight: FontWeight.w700, textAlign: TextAlign.center),
        getVerSpace(4.h),
        getMultilineCustomFont("Please check Spelling or try different keyword",
            16.sp, Colors.white,
            fontWeight: FontWeight.w400, textAlign: TextAlign.center)
      ],
    ).paddingSymmetric(horizontal: 20.h));
  }

  Widget buildSearchWidget(BuildContext context, SearchController controller) {
    return getSearchWidget(context, "Search...", searchController,
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
        suffiximage: "filter.svg",
        imagefunction: () {
          Get.bottomSheet(const FilterDialog(), isScrollControlled: true);
        },
        onTap: () {},
        isReadonly: false,
        onSubmit: (value) {
          if (!controller.searchList.contains(value)) {
            controller.searchList.add(value);
          }
        }).paddingSymmetric(horizontal: 20.h);
  }
}
