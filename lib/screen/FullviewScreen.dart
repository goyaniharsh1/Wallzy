// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/utilities/Common_Controller.dart';
import 'package:wallzy/utilities/String.dart';
import 'package:wallzy/utilities/custom_widgets.dart';
import 'package:wallzy/widgets/Transparentcontainer.dart';

class Fullviewscreen extends StatefulWidget {
  const Fullviewscreen({super.key});

  @override
  State<Fullviewscreen> createState() => _FullviewscreenState();
}

class _FullviewscreenState extends State<Fullviewscreen> {
  double? process;
  final db = FirebaseFirestore.instance;
  bool isselected = false;
  RxBool likeis = false.obs;
  CommonController commonController = Get.put(CommonController());
  RxInt currentIndex = 0.obs;
  PageController? controller =
      PageController(viewportFraction: 1, keepPage: true);
  int like = 0;

  ini() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uuUID = prefs.getString('UIDs');
    final docRef = db.collection("Users").doc(uuUID);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    List favorite = data["favorite"];
    final dbreal = FirebaseDatabase.instance
        .ref(commonController.selectCat.value)
        .child(commonController.selectImageList[currentIndex.value]["uId"]);

    DatabaseEvent event = await dbreal.once();

    Map<dynamic, dynamic> likeData = event.snapshot.value as dynamic;
    like = likeData["Like"];
    log("51:LOG ===>${likeData["Like"]}");
    log("52:LOG ===>$favorite");

    likeis.value = favorite
        .where((element) =>
            element["uId"] ==
            commonController.selectImageList[currentIndex.value]["uId"])
        .isNotEmpty;
    log("56:LOG ===>${favorite.where((element) => element["uId"] == commonController.selectImageList[currentIndex.value]["uId"]).isNotEmpty}");
    log("44:LOG ===>${likeis.value}");
    log("45:LOG ===>${commonController.selectImageList[currentIndex.value]["uId"]}");
  }

  @override
  Widget build(BuildContext context) {
    ini();

    log("32:LOG ===>${currentIndex.value}");
    currentIndex.value = commonController.selectIndex.value;
    controller =
        PageController(initialPage: commonController.selectIndex.value);
    return Scaffold(
      backgroundColor: wdarkblue,
      body: Obx(() => Stack(
            children: [
              PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  currentIndex.value = value;
                  ini();
                },
                itemBuilder: (context, index) => SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: GestureDetector(
                    onDoubleTap: () async {
                      final dbreal = FirebaseDatabase.instance
                          .ref(commonController.selectCat.value)
                          .child(commonController
                              .selectImageList[currentIndex.value]["uId"]);
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? uUID = prefs.getString('UIDs');

                      try {
                        final docRef = db.collection("Users").doc(uUID);
                        DocumentSnapshot doc = await docRef.get();
                        final data = doc.data() as Map<String, dynamic>;
                        List favorite = data["favorite"];

                        if (likeis.value) {
                          for (int i = 0; i < favorite.length; i++) {
                            if (favorite[i]["uId"] ==
                                commonController
                                        .selectImageList[currentIndex.value]
                                    ["uId"]) {
                              favorite.removeAt(i);
                              likeis.value = false;
                              like--;
                              log("104:LOG ===>${commonController.selectCat.value}");
                            }
                          }
                        } else {
                          favorite.add({
                            "CatSlug": commonController.selectCat.value,
                            "uId": commonController
                                .selectImageList[currentIndex.value]["uId"]
                          });
                          likeis.value = true;
                          like++;
                          log("104:LOG ===>${commonController.selectCat.value}");
                        }

                        log("122:LOG ===>$uUID");
                        db
                            .collection("Users")
                            .doc(uUID)
                            .update({"favorite": favorite});

                        log("127:LOG ===>$like");
                        log("128:LOG ===>${commonController.selectImageList[currentIndex.value]["uId"]}");
                        dbreal.update({"Like": like});
                      } catch (e) {
                        log("130:LOG ===>$e");
                      }
                    },
                    child: Image.network(
                      commonController.selectImageList[index]["Image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 89.h,
                left: 5.w,
                child: GestureDetector(
                  onTap: () async {
                    final dbreal = FirebaseDatabase.instance
                        .ref(commonController.selectCat.value)
                        .child(commonController
                            .selectImageList[currentIndex.value]["uId"]);
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? uID = prefs.getString('UIDs');

                    try {
                      final docRef = db.collection("Users").doc(uID);
                      DocumentSnapshot doc = await docRef.get();
                      final data = doc.data() as Map<String, dynamic>;
                      List favorite = data["favorite"];

                      if (likeis.value) {
                        for (int i = 0; i < favorite.length; i++) {
                          if (favorite[i] ==
                              commonController
                                  .selectImageList[currentIndex.value]["uId"]) {
                            favorite.removeAt(i);
                            likeis.value = false;
                            like--;
                          }
                        }
                      } else {
                        favorite.add({
                          "CatSlug": commonController.selectCat.value,
                          "uId": commonController
                              .selectImageList[currentIndex.value]["uId"]
                        });
                        likeis.value = true;
                        like++;
                      }

                      log("122:LOG ===>$uID");
                      db
                          .collection("Users")
                          .doc(uID)
                          .update({"favorite": favorite});

                      log("127:LOG ===>$like");
                      log("128:LOG ===>${commonController.selectImageList[currentIndex.value]["uId"]}");
                      dbreal.update({"Like": like});
                    } catch (e) {
                      log("130:LOG ===>$e");
                    }
                  },
                  child: Icon(
                    Icons.favorite_outlined,
                    size: 40,
                    color: (likeis.value) ? wpink : wwhite,
                  ),
                ),
              ),
              fancybutton(
                Icons.download_rounded,
                isselected,
                const Duration(milliseconds: 200),
                bottom: 6.h,
                right: 20.w,
                onTap: () {
                  FileDownloader.downloadFile(
                    url: commonController.selectImageList[currentIndex.value]
                        ["Image"],
                    onProgress: (fileName, progress) {
                      setState(() {
                        process = progress;
                      });
                    },
                    onDownloadCompleted: (path) {
                      setState(() {
                        log("path $path");
                        setState(() {
                          process = null;
                        });
                      });
                    },
                  );
                },
              ),
              fancybutton(
                  Icons.share, isselected, const Duration(milliseconds: 300),
                  bottom: 6.h, right: 34.w),
              Positioned(
                  top: 89.h,
                  left: 83.w,
                  child: GestureDetector(
                    onTap: () {
                      log("86:LOG ===>");
                      setState(() {
                        isselected = !isselected;
                      });
                    },
                    child: Container(
                      height: 5.h,
                      width: 5.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: wwhite,
                      ),
                      child: Icon(isselected
                          ? Icons.cancel
                          : Icons.more_horiz_outlined),
                    ),
                  )),
              Positioned(
                  top: 10.h,
                  left: 85.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Transparentbox(
                        childd: const Icon(Icons.cancel),
                        heightt: 5.h,
                        widthh: 10.w),
                  ))
            ],
          )),
    );
  }
}
