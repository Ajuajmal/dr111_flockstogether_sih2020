import 'package:flutter/material.dart';

class ScreenSize {
  double height, width;

  ScreenSize getSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    this.height = size.height;
    this.width = size.width;
    return this;
  }
}
