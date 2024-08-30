import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class Loading {

  Loading._();

  static Future showLoading({Duration? duration}) async{
    showToastWidget(
      Container(
        color: Colors.transparent,
        constraints: const BoxConstraints.expand(),
        child: Align(
          child: Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.r)),color: Colors.black45),
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor:  const AlwaysStoppedAnimation(Colors.white),
            ),
          ),

        ),
      ),
        handleTouch: true,
        duration: duration ?? const Duration(hours: 1)
    );
  }

  static void dismissAll() {
    dismissAllToast();
  }
} 