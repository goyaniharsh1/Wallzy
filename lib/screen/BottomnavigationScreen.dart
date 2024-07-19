// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wallzy/screen/CategoriesScreen.dart';
import 'package:wallzy/screen/ProfileScreen.dart';
import 'package:wallzy/utilities/String.dart';

import 'homescreen.dart';

class Bottomnavigation extends StatefulWidget {
  final String email;
  final String img;
  final String username;
  const Bottomnavigation({
    super.key,
    required this.email,
    required this.img,
    required this.username,
  });

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int currentindex = 0;
  List screen = [];
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  void initState() {
    screen = [
      HomeScreen(
        email: widget.email,
        img: widget.img,
        username: widget.username,
      ),
      const CategoriesScreen(),
      ProfileScreen(
        email: widget.email,
        img: widget.img,
        username: widget.username,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: wdarkblue,
            selectedItemColor: wskyblue,
            unselectedItemColor: wwhite,
            showUnselectedLabels: false,
            onTap: onTap,
            currentIndex: currentindex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.window), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ]));
  }
}
