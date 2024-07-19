import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/utilities/String.dart';

// text
Widget textWidget(String text,
    {TextAlign? textAlign,
    int? maxLines,
    bool? softWrap,
    TextOverflow? textOverflow,
    TextStyle? style,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    softWrap: softWrap,
    overflow: textOverflow,
    style: style ??
        TextStyle(
          decoration: decoration,
          color: textColor ?? wwhite,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 11.sp,
        ),
  );
}

// floating action button
Widget floatingbutton(IconData? icons, bool isselected,
    {double? bottom, double? right, GestureTapCallback? onTap}) {
  return AnimatedPositioned(
    bottom: isselected ? bottom : 5.h, //27
    right: isselected ? right : 9.w,
    curve: Curves.easeInOutQuint,
    duration: const Duration(milliseconds: 200),
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isselected ? 60 : 20,
        width: isselected ? 60 : 20,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: wskyblue.withAlpha(1200),
                  spreadRadius: 3,
                  blurRadius: 2)
            ],
            color: wgreen,
            borderRadius: BorderRadius.circular(isselected ? 20 : 10)),
        child: Icon(
          icons,
          size: 30,
          color: wwhite,
        ),
      ),
    ),
  );
}

//fancy Button
Widget fancybutton(IconData? icons, bool isselected, Duration duration,
    {double? bottom, double? right, GestureTapCallback? onTap}) {
  return AnimatedPositioned(
    bottom: isselected ? bottom : 7.5.h, //27
    right: isselected ? right : 9.w,
    curve: Curves.easeInOutQuint,
    duration: //const Duration(milliseconds: 200),
        duration,
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isselected ? 40 : 20,
        width: isselected ? 40 : 20,
        decoration: BoxDecoration(
            color: wwhite,
            borderRadius: BorderRadius.circular(isselected ? 10 : 5)),
        child: Icon(
          icons,
          size: 30,
          color: wblack,
        ),
      ),
    ),
  );
}
