import 'dart:math';

import 'package:flutter/material.dart';

class ArcCorner extends StatefulWidget {
  final double? controllerValue;
  final Size? moveRectSize;
  final double? moveWidth;
  final double? boxHeight;
  final Color? cornerColor;
  const ArcCorner(
      {Key? key,
      required this.controllerValue,
      required this.moveRectSize,
      required this.moveWidth,
      required this.boxHeight,
      required this.cornerColor})
      : super(key: key);

  @override
  _ArcCornerState createState() => _ArcCornerState();
}

class _ArcCornerState extends State<ArcCorner> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: OpenPainter(widget.controllerValue, widget.moveRectSize,
          widget.moveWidth, widget.boxHeight, widget.cornerColor),
    );
  }
}

class OpenPainter extends CustomPainter {
  final double? controllerValue;
  final Size? moveRectSize;
  final double? moveWidth;
  final double? boxHeight;
  final Color? cornerColor;

  OpenPainter(this.controllerValue, this.moveRectSize, this.moveWidth,
      this.boxHeight, this.cornerColor);

  @override
  void paint(Canvas canvas, Size size) {
    double rtSize = 24;
    double rtOffset = 6;

    double left = (moveWidth! - moveRectSize!.width) * controllerValue!;
    double top = boxHeight! - moveRectSize!.height / 2;

    List<Rect> cornerRects = [
      Rect.fromPoints(Offset(left - rtOffset, top - rtOffset),
          Offset(left + rtSize, top + rtSize)),
      Rect.fromPoints(
          Offset(left + moveRectSize!.width + rtOffset, top - rtOffset),
          Offset(left + moveRectSize!.width - rtSize, top + rtSize)),
      Rect.fromPoints(
          Offset(left - rtOffset, top + moveRectSize!.height + rtOffset),
          Offset(left + rtSize, top + moveRectSize!.height - rtSize)),
      Rect.fromPoints(
          Offset(left + moveRectSize!.width - rtSize,
              top + moveRectSize!.height - rtSize),
          Offset(left + moveRectSize!.width + rtOffset,
              top + moveRectSize!.height + rtOffset)),
    ];
    List<double> radians = [pi, 1.5 * pi, pi / 2, 0];

    var paint1 = Paint()
      ..color = cornerColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    //draw arc
    for (int i = 0; i < 4; i++) {
      canvas.drawArc(
          cornerRects[i],
          radians[i], //radians
          pi / 2, //radians
          false,
          paint1);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
