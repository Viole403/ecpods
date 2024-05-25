import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/routes/app_routes.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant.dart';
import 'package:ecpods/util/constant_widget.dart';
import 'package:ecpods/util/pref_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getIsFirst();
  }

  _getIsFirst() async {
    bool isSignIn = await PrefData.getIsSignIn();
    bool isIntro = await PrefData.getIsIntro();

    Timer(const Duration(seconds: 3), () {
      if (isIntro) {
        Get.toNamed(Routes.introRoute);
      }
      else if (isSignIn) {
        Get.toNamed(Routes.loginRoute);
      } else {
        Get.toNamed(Routes.homeScreenRoute, arguments: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(bgDark);
    Constant.setupSize(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: bgDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getAssetImage("splash_logo.png", width: 106.h, height: 137.h)
            ],
          ),
        ),
      ),
    );
  }
}
