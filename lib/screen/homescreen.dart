import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/screen/FavoriteCardScreen.dart';
import 'package:wallzy/screen/FullviewScreen.dart';
import 'package:wallzy/screen/explorescreen.dart';
import 'package:wallzy/utilities/Common_Controller.dart';
import 'package:wallzy/utilities/String.dart';
import 'package:wallzy/utilities/custom_widgets.dart';
import 'package:wallzy/widgets/Transparentcontainer.dart';
import 'package:wallzy/widgets/carouselWidget.dart';
import 'package:wallzy/widgets/wallpapercover.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  final String img;
  final String username;
  const HomeScreen(
      {super.key,
      required this.email,
      required this.img,
      required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Details {
  String? iconsname;
  Icon? icon;
  String? imagess;
  Details({this.icon, this.iconsname, this.imagess});
}

List<Details> detaillist = [
  Details(
      icon: const Icon(
        Icons.info,
      ),
      iconsname: "Info",
      imagess: "assets/images/peakpx-365.jpg"),
  Details(
      icon: const Icon(
        Icons.category_rounded,
      ),
      iconsname: "Categories",
      imagess: "assets/images/peakpx-246.jpg"),
  Details(
      icon: const Icon(
        Icons.download,
      ),
      iconsname: "Downloads",
      imagess: "assets/images/peakpx-365.jpg"),
  Details(
      icon: const Icon(
        Icons.logout_outlined,
      ),
      iconsname: "Logout",
      imagess: "assets/images/peakpx-377.jpg"),
];

class _HomeScreenState extends State<HomeScreen> {
  CommonController commonController = Get.put(CommonController());
  String greetings() {
    final hour = TimeOfDay.now().hour;

    if (hour <= 11) {
      return gm;
    } else if (hour <= 17) {
      return ga;
    } else {
      return ge;
    }
  }

  String greetingsimg() {
    final hour = TimeOfDay.now().hour;

    if (hour <= 11) {
      return "assets/images/wallzyMorning.png";
    } else if (hour <= 17) {
      return "assets/images/WallzyAfternoon.png";
    } else {
      return "assets/images/WallzyMoon.png";
    }
  }

  bool isselected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              "assets/images/peakpx-380 2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h, left: 2.w, right: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: Row(
                      children: [
                        textWidget(appname,
                            fontSize: 28.sp,
                            textColor: wwhite,
                            fontWeight: FontWeight.w800),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: wtransparent,
                                context: context,
                                builder: (context) {
                                  return Stack(
                                    children: [
                                      Container(
                                        color: wtransparent,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.h),
                                        height: 52.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: wskyblue,
                                            borderRadius:
                                                BorderRadius.circular(43.sp)),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 1.h),
                                          height: 40.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: wdarkblue,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(45.sp),
                                                topRight:
                                                    Radius.circular(45.sp)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 1.w, right: 1.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.w),
                                                  child: textWidget("Settings",
                                                      textColor: wwhite,
                                                      fontSize: 25),
                                                ),
                                                SizedBox(height: 2.h),
                                                Expanded(
                                                  child: ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          detaillist.length,
                                                      itemBuilder: (context,
                                                              index) =>
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: ListTile(
                                                              leading:
                                                                  detaillist[
                                                                          index]
                                                                      .icon,
                                                              iconColor: wwhite,
                                                              title: textWidget(
                                                                  detaillist[
                                                                          index]
                                                                      .iconsname
                                                                      .toString(),
                                                                  textColor:
                                                                      wwhite,
                                                                  fontSize: 20),
                                                            ),
                                                          )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: 33.5.w,
                                          child: CircleAvatar(
                                            backgroundColor: wskyblue,
                                            radius: 50.sp,
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(widget.img),
                                              backgroundColor: wdarkblue,
                                              radius: 44.5.sp,
                                            ),
                                          )),
                                    ],
                                  );
                                });
                          },
                          child: Icon(
                            Icons.settings,
                            size: 20.sp,
                            color: wwhite,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      textWidget(greetings(),
                          fontSize: 23.sp,
                          textColor: wskyblue,
                          fontWeight: FontWeight.w600),
                      SizedBox(width: 3.w),
                      Image.asset(
                        greetingsimg(),
                        height: 30.sp,
                      )
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Transparentbox(
                      childd: textWidget(newwallpaper, fontSize: 13.sp),
                      heightt: 4.h,
                      widthh: 30.w),
                  SizedBox(height: 1.h),
                  SizedBox(
                    width: 96.w,
                    height: 26.h,
                    child: PageView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CarouselWidget(
                                images: "assets/images/peakpx-379.jpg"))),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Transparentbox(
                          childd: textWidget(notch, fontSize: 13.sp),
                          heightt: 4.h,
                          widthh: 40.w),
                      const Spacer(),
                      Transparentbox(
                          childd: textWidget(see), heightt: 2.h, widthh: 18.w),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: 10.h,
                    child: ListView.builder(
                        itemCount: detaillist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(const Fullviewscreen());
                                },
                                child: Container(
                                  height: 8.h,
                                  width: 28.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(detaillist[index]
                                            .imagess
                                            .toString()),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.1),
                                            BlendMode.darken),
                                      ),
                                      color: wskyblue.withAlpha(72),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            )),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Transparentbox(
                          childd: textWidget(trend, fontSize: 14.sp),
                          heightt: 4.h,
                          widthh: 25.w),
                      Image.asset(
                        "assets/images/WallzyTrending.png",
                        height: 25,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: 34.h,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => const WallpaperCover(
                            wallcoverimg: "assets/images/peakpx-377.jpg")),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          )),
          isselected
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isselected = !isselected;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    color: isselected ? wdarkblue.withAlpha(190) : wtransparent,
                  ),
                )
              : const Offstage(),
          floatingbutton(Icons.download, isselected,
              right: 5.w, bottom: 15.h, onTap: () {}),
          floatingbutton(Icons.explore, isselected, right: 27.w, bottom: 11.h,
              onTap: () {
            Get.to(const Explorescreen());
          }),
          floatingbutton(Icons.favorite, isselected, right: 29.w, bottom: 0.5.h,
              onTap: () {
            commonController.selectCatName.value = "Favorite";
            Get.to(() => const FavoriteCardScreen());
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: wpurple,
        onPressed: () {
          setState(() {
            isselected = !isselected;
          });
        },
        child: const Icon(Icons.menu_rounded),
      ),
    );
  }
}
