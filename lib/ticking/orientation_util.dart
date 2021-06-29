import 'package:flutter/services.dart';

Future<int> setVerticalOrientations() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return 1;
}

Future<int> setHorizontalOrientations() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  return 1;
}
