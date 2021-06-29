import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;
  static double designWidth = 375.0;
  static double designHeight = 667.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    if (_mediaQueryData.size.width < _mediaQueryData.size.height) {
      screenWidth = _mediaQueryData.size.width;
      screenHeight = _mediaQueryData.size.height;
    } else {
      screenWidth = _mediaQueryData.size.height;
      screenHeight = _mediaQueryData.size.width;
    }

    orientation = _mediaQueryData.orientation;

    // print('screenWidth $screenWidth');
    // print('screenHeight $screenHeight');
    // print('orientation $orientation');
  }

  double getHeight(double inputHeight) {
    double screenHeight = SizeConfig.screenHeight!;
    return (inputHeight / designHeight) * screenHeight;
  }

  double getWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenWidth!;
    return (inputWidth / designWidth) * screenWidth;
  }
}
