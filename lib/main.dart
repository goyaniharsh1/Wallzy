import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

import 'screen/BottomnavigationScreen.dart';
import 'screen/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            iosClientId:
                "836094784710-71ndrl4mb84ic4mpprhm7lc8acjgmkei.apps.googleusercontent.com",
            androidClientId:
                "836094784710-vkmmlbfp8iej0i1h3u70cr7q6ii54s7o.apps.googleusercontent.com",
            apiKey: "AIzaSyBxd1a1a3tvzJIctEcwdzVtlZ1lOuhE-C4",
            appId: "1:836094784710:android:adf987310d9859630d53c7",
            messagingSenderId: "836094784710",
            projectId: "wallzy-8b4d3"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: (const LoginScreen()),
          //   const Bottomnavigation(
          //   email: "",
          //   img: "",
          //   username: "",
          // )
        );
      },
    );
  }
}
