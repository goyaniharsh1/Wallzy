// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Transparentbox extends StatelessWidget {
  final Widget childd;
  final double heightt;
  final double widthh;
  const Transparentbox(
      {super.key,
      required this.childd,
      required this.heightt,
      required this.widthh});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightt,
      width: widthh,
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(9),
          borderRadius: BorderRadius.circular(10)),
      child: Center(child: childd),
    );
  }
}
