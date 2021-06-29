import 'package:flutter/material.dart';
import 'package:ticktockname/ticking/size_config.dart';

class TickingNameWidget extends StatefulWidget {
  final List<String> nameList;
  final Duration moveDuration;
  final Size moveRectSize;
  const TickingNameWidget({
    Key? key,
    required this.nameList,
    required this.moveDuration,
    required this.moveRectSize,
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
      width: SizeConfig.screenWidth,
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          Positioned(
            left: _controller!.value *
                (SizeConfig.screenWidth! - widget.moveRectSize.width),
            top: SizeConfig.screenHeight! / 2 - widget.moveRectSize.height / 2,
            child: Container(
              width: widget.moveRectSize.width,
              height: widget.moveRectSize.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.orange),
            ),
          ),
          ClipPath(
            clipper: ClipNameRect(_controller!.value, widget.moveRectSize),
            child: Center(
              child: Text(
                widget.nameList[_curIndex],
                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
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

  ClipNameRect(this.controllerValue, this.moveRectSize);

  @override
  Path getClip(Size size) {
    double left =
        (SizeConfig.screenWidth! - moveRectSize!.width) * controllerValue!;
    double top = SizeConfig.screenHeight! / 2 - moveRectSize!.height / 2;

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
