// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/screen/FullviewScreen.dart';
import 'package:wallzy/utilities/Common_Controller.dart';
import 'package:wallzy/utilities/String.dart';
import 'package:wallzy/utilities/custom_widgets.dart';

class CardDetailscreen extends StatefulWidget {
  const CardDetailscreen({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CardDetailscreen> {
  CommonController commonController = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    final db = FirebaseDatabase.instance.ref(commonController.selectCat.value);
    return Scaffold(
      backgroundColor: wdarkblue,
      body: Padding(
        padding: EdgeInsets.only(top: 7.h, left: 1.w, right: 1.w),
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
                  width: 4.w,
                ),
                textWidget(commonController.selectCatName.value,
                    textColor: wskyblue, fontSize: 25.sp),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: db.onValue,
                builder: (context, snapshot) {
                  Map<dynamic, dynamic> map = {};
                  List<dynamic> list = [];
                  if (snapshot.hasData) {
                    map = snapshot.data?.snapshot.value as dynamic;
                    list.clear();
                    list = map.values.toList();
                  }
                  return (snapshot.hasData)
                      ? GridView.builder(
                          itemCount: list.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.08.h,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(const Fullviewscreen());
                                commonController.selectImageList.value = list;
                                commonController.selectIndex.value = index;
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(list[index]["Image"],
                                    fit: BoxFit.cover),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
