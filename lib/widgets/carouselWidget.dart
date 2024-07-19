// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wallzy/utilities/String.dart';

class CarouselWidget extends StatelessWidget {
  final String images;
  const CarouselWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: wwhite.withAlpha(12), borderRadius: BorderRadius.circular(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          images,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
