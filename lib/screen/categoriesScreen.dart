// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/screen/cardscreen.dart';
import 'package:wallzy/utilities/Common_Controller.dart';
import 'package:wallzy/utilities/String.dart';
import 'package:wallzy/utilities/custom_widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Map<dynamic, dynamic> map = {};
  final db = FirebaseDatabase.instance.ref("Categories");
  CommonController commonController = Get.put(CommonController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wdarkblue,
      body: StreamBuilder(
        stream: db.onValue,
        builder: (context, snapshot) {
          Map<dynamic, dynamic> map =
              snapshot.data?.snapshot.value as dynamic ?? {};
          List<dynamic> list = [];
          list.clear();

          list = map.values.toList();
          return snapshot.hasData
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      forceElevated: true,
                      backgroundColor: wbrightblue,
                      pinned: true,
                      expandedHeight: 17.h,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: textWidget(categories, fontSize: 18.sp),
                          collapseMode: CollapseMode.pin,
                          background: Image.asset(
                            "assets/images/peakpx-377.jpg",
                            fit: BoxFit.cover,
                          )),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: snapshot.data?.snapshot.children.length,
                            (context, index) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    commonController.selectCat.value =
                                        list[index]["CatSlug"];
                                    commonController.selectCatName.value =
                                        list[index]["CatName"];

                                    Get.to(const CardDetailscreen());
                                  },
                                  child: Container(
                                    height: 18.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            list[index]["CatImage"],
                                          ),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              wblack.withOpacity(0.1),
                                              BlendMode.darken),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: wwhite.withAlpha(20),
                                              blurRadius: 1.sp,
                                              spreadRadius: 7.sp)
                                        ],
                                        color: wwhite,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 11.5.h, right: 2.h),
                                        child: textWidget(
                                            list[index]["CatName"],
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w700,
                                            textAlign: TextAlign.right)),
                                  ),
                                ))))
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
