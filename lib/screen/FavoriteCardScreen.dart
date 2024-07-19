// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/utilities/Common_Controller.dart';
import 'package:wallzy/utilities/String.dart';
import 'package:wallzy/utilities/custom_widgets.dart';

class FavoriteCardScreen extends StatefulWidget {
  const FavoriteCardScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteCardScreen> createState() => _FavoriteCardScreenState();
}

class _FavoriteCardScreenState extends State<FavoriteCardScreen> {
  @override
  void initState() {
    super.initState();
    ini();
  }

  final db = FirebaseFirestore.instance;
  ini() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uID = prefs.getString('UIDs');
    final docRef = db.collection("Users").doc(uID);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    List favorite = data["favorite"];

    log("34:LOG ===>$favorite");

    // DatabaseEvent event = await dbreal.once();

    // Map<dynamic,dynamic> likeData = event.snapshot.value as dynamic;
  }

  // final db = FirebaseDatabase.instance;
  CommonController commonController = Get.put(CommonController());
  @override
  Widget build(BuildContext context) {
    final db = FirebaseDatabase.instance.ref();
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
                    log("83:LOG ===>${snapshot.data?.snapshot.value}");
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
                                // Get.to(const Fullviewscreen());
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
