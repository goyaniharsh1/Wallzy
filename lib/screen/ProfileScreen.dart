// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:wallzy/screen/loginscreen.dart';
import 'package:wallzy/utilities/String.dart';
import 'package:wallzy/utilities/custom_widgets.dart';
import 'package:wallzy/widgets/Transparentcontainer.dart';

class ProfileScreen extends StatefulWidget {
  final String email;
  final String img;
  final String username;

  const ProfileScreen({
    super.key,
    required this.email,
    required this.img,
    required this.username,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wdarkblue,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 34.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/peakpx-379.jpg",
                        ),
                        opacity: 0.6,
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 10.5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: textWidget(widget.username,
                    fontSize: 19.sp, textColor: wskyblue),
              ),
              SizedBox(
                height: 0.2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: textWidget(widget.email,
                    fontSize: 11.sp, textColor: wskyblue),
              ),
              SizedBox(
                height: 8.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.signOut();

                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    log("83:LOG ===>${prefs.getString('UIDs')}");
                    prefs.setString('UIDs', "");
                    Get.to(() => const LoginScreen());
                  },
                  child: Transparentbox(
                      childd: textWidget("Logout", textColor: wskyblue),
                      heightt: 5.h,
                      widthh: 30.w),
                ),
              ),
              const Spacer()
            ],
          ),
          Positioned(
              top: 29.3.h,
              left: 5.w,
              child: CircleAvatar(
                backgroundColor: wwhite,
                radius: 45.sp,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.img),
                  radius: 40.sp,
                ),
              )),
          Positioned(
            top: 30.1.h,
            left: 90.w,
            child: Icon(
              Icons.edit,
              size: 22.sp,
              color: wwhite,
            ),
          )
        ],
      ),
    );
  }
}
