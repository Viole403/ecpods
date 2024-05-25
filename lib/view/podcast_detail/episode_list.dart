import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../dataFile/data_file.dart';
import '../../model/popular_model.dart';
import '../../util/color_category.dart';
import '../../util/constant.dart';
import '../../util/constant_widget.dart';

class EpisodeList extends StatefulWidget {
  const EpisodeList({super.key});

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  void backClick() {
    Constant.backToPrev(context);
  }
  List<ModelPopular> episodeLists = DataFile.episodeList;

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
              }, "Episodes"),
              getVerSpace(40.h),
              Expanded(
                  child: ListView.builder(
                itemCount: episodeLists.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ModelPopular modelPopular = episodeLists[index];
                  return Container(
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                        color: containerBg,
                        borderRadius: BorderRadius.circular(22.h)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              getAssetImage(modelPopular.image,
                                  height: 56.h, width: 56.h),
                              getHorSpace(12.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getCustomFont(
                                      modelPopular.name, 16.sp, Colors.white, 1,
                                      fontWeight: FontWeight.w700),
                                  getVerSpace(6.h),
                                  getCustomFont(
                                      "${modelPopular.time}  •  Listening",
                                      12.sp,
                                      searchHint,
                                      1,
                                      fontWeight: FontWeight.w400)
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            getSvgImage("import.svg",
                                width: 20.h, height: 20.h),
                            getHorSpace(11.h),
                            getSvgImage("play_white.svg",
                                height: 20.h, width: 20.h)
                          ],
                        )
                      ],
                    ),
                  ).marginOnly(bottom: 20.h);
                },
              ))
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }
}
