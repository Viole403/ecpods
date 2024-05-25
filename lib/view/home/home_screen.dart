import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/controller/controller.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant_widget.dart';
import 'package:ecpods/view/home/tab/tab_discover.dart';
import 'package:ecpods/view/home/tab/tab_home.dart';
import 'package:ecpods/view/home/tab/tab_library.dart';
import 'package:ecpods/view/home/tab/tab_profile.dart';

import '../../dataFile/data_file.dart';
import '../../model/bottom_model.dart';
import '../../util/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void backClick() {
    Constant.closeApp();
  }

  HomeController controller = Get.put(HomeController());
  List<ModelBottom> bottomLists = DataFile.bottomList;

  static final List<Widget> _widgetOptions = <Widget>[
    const TabHome(),
    const TabDiscover(),
    const TabLibrary(),
    const TabProfile()
  ];

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(bgDark);
    Constant.setupSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: bgDark,
          bottomNavigationBar: buildBottomnavigation(controller),
          body: SafeArea(
            child: GetX<HomeController>(
              init: HomeController(),
              builder: (controller) =>
              _widgetOptions[controller.index.value],
            ),
          ),
        ),
      ),
    );
  }

  Container buildBottomnavigation(HomeController controller) {
    return Container(
      height: 66.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: "#222222".toColor(),
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.h)),
          boxShadow: [
            BoxShadow(
                color: "#59000000".toColor(),
                offset: const Offset(-1, -30),
                blurRadius: 27.h)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(bottomLists.length, (index) {
          ModelBottom modelBottom = bottomLists[index];
          return GestureDetector(
            onTap: () {
              controller.onChange(index.obs);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getSvgImage(
                    controller.index.value == index
                        ? modelBottom.selectImage
                        : modelBottom.image,
                    height: 24.h,
                    width: 24.h),
                Visibility(
                  visible: controller.index.value == index ? true : false,
                  child: getCustomFont(modelBottom.name, 12.sp, accentColor, 1,
                      fontWeight: FontWeight.w700, txtHeight: 1.5.h),
                )
              ],
            ),
          );
        }),
      ).paddingSymmetric(horizontal: 30.h),
    );
  }
}
