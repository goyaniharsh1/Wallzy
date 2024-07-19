// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/screen/BottomnavigationScreen.dart';
import 'package:wallzy/utilities/String.dart';
import 'package:wallzy/utilities/custom_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  signInWithGoogle() async {
    final db = FirebaseFirestore.instance;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var res = await googleSignIn.signIn();
      if (res == null) {
        return;
      }
      final userdata = await res.authentication;
      final crd = GoogleAuthProvider.credential(
        accessToken: userdata.accessToken,
        idToken: userdata.idToken,
      );
      var finalresult = await FirebaseAuth.instance.signInWithCredential(crd);
      await prefs.setString('UIDs', res.id);
      log(res.email);
      log("res.photoUrl");
      log("res.displayName");
      log("44:LOG ===>${res.serverAuthCode}");
      log("45:LOG ===>${res.email}");
      db.collection("Users").doc(res.id).set({
        "name": res.displayName,
        "image": res.photoUrl,
        "UserId": res.id,
        "favorite": []
      });
      Get.to(Bottomnavigation(
        email: res.email,
        img: res.photoUrl.toString(),
        username: res.displayName.toString(),
      ));
    } catch (e) {
      log("52:LOG ===>$e");
    }
  }

  onlyLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    var res = await googleSignIn.signIn();
    Get.to(Bottomnavigation(
      email: res!.email,
      img: res.photoUrl.toString(),
      username: res.displayName.toString(),
    ));
  }

  loginCheck() async {
    String uIDs = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uIDs = prefs.getString('UIDs') ?? "";

    if (uIDs.isNotEmpty) {
      onlyLogin();
    } else {
      signInWithGoogle();
    }
  }

  @override
  void initState() {
    super.initState();
    loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/images/walllogin.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 26.h,
              left: 8.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(welcome,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      textColor: wdarkpurple),
                  textWidget(appname,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      textColor: wdarkpurple),
                  SizedBox(
                    height: 4.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      // signInWithGoogle();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      height: 7.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          color: wdarkpurple.withAlpha(18),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset(
                            "assets/images/googleimg.png",
                            height: 30.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          textWidget(google,
                              fontSize: 18.sp,
                              textColor:
                                  const Color.fromARGB(255, 234, 228, 255),
                              fontWeight: FontWeight.w700),
                          const Spacer()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
