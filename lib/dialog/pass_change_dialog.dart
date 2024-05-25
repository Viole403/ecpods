import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/routes/app_routes.dart';
import 'package:ecpods/util/color_category.dart';
import 'package:ecpods/util/constant.dart';
import 'package:ecpods/util/constant_widget.dart';

class PassChangeDialog extends StatefulWidget {
  const PassChangeDialog({super.key});

  @override
  State<PassChangeDialog> createState() => _PassChangeDialogState();
}

class _PassChangeDialogState extends State<PassChangeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: lightBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.h),
      ),
      child: SizedBox(
        width: 354.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getVerSpace(50.h),
            getAssetImage("pass_chage.png", height: 150.h, width: 150.h),
            getVerSpace(40.h),
            getCustomFont("Password Changed", 26.sp, Colors.white, 1,
                fontWeight: FontWeight.w700, txtHeight: 1.5.h),
            getVerSpace(4.h),
            getMultilineCustomFont(
                "Your account has been successfully changed!",
                16.sp,
                Colors.white,
                fontWeight: FontWeight.w400,
                txtHeight: 1.5.h,
                textAlign: TextAlign.center)
                .paddingSymmetric(horizontal: 30.h),
            getVerSpace(30.h),
            getButton(context, accentColor, "Ok", Colors.black, () {
              Constant.sendToNext(context, Routes.loginRoute);

            }, 18.sp,
                buttonHeight: 60.h,
                borderRadius: BorderRadius.circular(12.h),weight: FontWeight.w700)
                .marginSymmetric(horizontal: 50.h),
            getVerSpace(50.h)
          ],
        ),
      ),
    );
  }
}
