import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ticktockname/ticking/size_config.dart';

class ArcCorner extends StatefulWidget {
  final double? controllerValue;
  final Size? moveRectSize;
  const ArcCorner({Key? key, this.controllerValue, this.moveRectSize})
      : super(key: key);

  @override
  _ArcCornerState createState() => _ArcCornerState();
}

class _ArcCornerState extends State<ArcCorner> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: OpenPainter(widget.controllerValue, widget.moveRectSize),
    );
  }
}

class OpenPainter extends CustomPainter {
  final double? controllerValue;
  final Size? moveRectSize;

  OpenPainter(this.controllerValue, this.moveRectSize);

  @override
  void paint(Canvas canvas, Size size) {
    double rtSize = 24;
    double rtOffset = 6;

    double left =
        (SizeConfig.screenWidth! - moveRectSize!.width) * controllerValue!;
    double top = SizeConfig.screenHeight! / 2 - moveRectSize!.height / 2;

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
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
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
