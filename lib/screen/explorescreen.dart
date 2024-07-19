import 'package:bubble_lens/bubble_lens.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/screen/FullviewScreen.dart';
import 'package:wallzy/utilities/String.dart';
import 'package:wallzy/utilities/custom_widgets.dart';

class Explorescreen extends StatefulWidget {
  const Explorescreen({super.key});

  @override
  State<Explorescreen> createState() => _ExplorescreenState();
}

class _ExplorescreenState extends State<Explorescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wdarkblue,
      body: Padding(
        padding: EdgeInsets.only(
          top: 7.h,
          left: 3.w,
          right: 3.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: wskyblue,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                textWidget(
                  "Explore",
                  fontSize: 26.sp,
                  textColor: wskyblue,
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 80.h,
              color: wdarkblue,
              child: BubbleLens(
                  duration: const Duration(milliseconds: 300),
                  radius: Radius.circular(25.sp),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  widgets: [
                    for (var i = 0; i < 300; i++)
                      GestureDetector(
                        onTap: () {
                          Get.to(const Fullviewscreen());
                        },
                        child: SizedBox(
                          width: 10.w,
                          height: 10.h,
                          child: Image.asset(
                            "assets/images/peakpx-246.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
