import 'package:flutter/material.dart';
import 'package:ticktockname/ticking/arc_corner.dart';
import 'package:ticktockname/ticking/size_config.dart';

class TickingNameWidget extends StatefulWidget {
  final List<String> nameList;
  final Duration moveDuration;
  final double moveWidth;
  final Size moveRectSize;
  final Color boxColor;
  final Color textColor;
  final double textSize;
  const TickingNameWidget({
    Key? key,
    required this.nameList,
    required this.moveDuration,
    required this.moveRectSize,
    required this.boxColor,
    required this.textColor,
    required this.textSize,
    required this.moveWidth,
  }) : super(key: key);

  @override
  _TickingNameWidgetState createState() => _TickingNameWidgetState();
}

class _TickingNameWidgetState extends State<TickingNameWidget>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  int _curIndex = 0;
  AnimationStatus _oldStatus = AnimationStatus.forward;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.moveWidth,
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: ArcCorner(
              controllerValue: _controller!.value,
              moveRectSize: widget.moveRectSize,
              moveWidth: widget.moveWidth,
              cornerColor: widget.boxColor,
              boxHeight: SizeConfig.screenHeight! / 2,
            ),
          ),
          Positioned(
            left: _controller!.value *
                (widget.moveWidth - widget.moveRectSize.width),
            top: SizeConfig.screenHeight! / 2 - widget.moveRectSize.height / 2,
            child: Container(
              width: widget.moveRectSize.width,
              height: widget.moveRectSize.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: widget.boxColor),
            ),
          ),
          ClipPath(
            clipper: ClipNameRect(
                controllerValue: _controller!.value,
                moveRectSize: widget.moveRectSize,
                moveWidth: widget.moveWidth,
                boxHeight: SizeConfig.screenHeight! / 2),
            child: Center(
              child: Text(
                widget.nameList[_curIndex],
                style: TextStyle(
                    fontSize: widget.textSize, color: widget.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initAnimations() {
    _controller =
        AnimationController(vsync: this, duration: widget.moveDuration);
    _controller!
      ..repeat(reverse: true)
      ..addListener(() {
        setState(() {
          if (_controller!.status == AnimationStatus.forward &&
                  _oldStatus == AnimationStatus.reverse ||
              _controller!.status == AnimationStatus.reverse &&
                  _oldStatus == AnimationStatus.forward) {
            _curIndex = (_curIndex + 1) % widget.nameList.length;
          }
          _oldStatus = _controller!.status;
        });
      });
  }
}

class ClipNameRect extends CustomClipper<Path> {
  final double? controllerValue;
  final Size? moveRectSize;
  final double? moveWidth;
  final double? boxHeight;

  ClipNameRect({
    required this.controllerValue,
    required this.moveRectSize,
    required this.moveWidth,
    required this.boxHeight,
  });

  @override
  Path getClip(Size size) {
    double left = (moveWidth! - moveRectSize!.width) * controllerValue!;
    double top = boxHeight! - moveRectSize!.height / 2;

    var path = new Path();
    path.lineTo(left, top);
    path.lineTo(left, top + moveRectSize!.height);
    path.lineTo(left + moveRectSize!.width, top + moveRectSize!.height);
    path.lineTo(left + moveRectSize!.width, top);
    path.lineTo(left, top);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
