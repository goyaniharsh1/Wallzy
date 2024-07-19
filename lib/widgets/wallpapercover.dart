import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/utilities/String.dart';

class WallpaperCover extends StatelessWidget {
  final String wallcoverimg;
  const WallpaperCover({super.key, required this.wallcoverimg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
        height: 28.h,
        width: 50.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: wwhite.withAlpha(20),
                blurRadius: 2.sp,
                spreadRadius: 4.sp)
          ],
          borderRadius: BorderRadius.circular(15),
          color: wwhite,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            wallcoverimg,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
