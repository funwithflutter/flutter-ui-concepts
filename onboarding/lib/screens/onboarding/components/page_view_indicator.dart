import 'dart:ui';

import 'package:flutter/material.dart';

class PageViewIndicator extends StatefulWidget {
  final PageController controller;
  final int itemCount;
  final Color color;

  const PageViewIndicator({
    Key key,
    @required this.controller,
    @required this.itemCount,
    this.color,
  }) : super(key: key);

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndicatorPainter(
        4,
        widget.controller.page?.round() ?? -1,
        color: widget.color,
      ),
      child: Container(
        width: 60,
        height: 10,
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final Color color;
  final int length;
  final int currentIndicator;

  Paint dotPaint;
  static const double _smallDot = 4;
  static const double _bigDot = 7;

  IndicatorPainter(this.length, this.currentIndicator,
      {this.color = Colors.black})
      : dotPaint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCircle(canvas, 0, Offset(0, size.height / 2));
    _drawCircle(canvas, 1, Offset(size.width / 3, size.height / 2));
    _drawCircle(canvas, 2, Offset(size.width / 3 * 2, size.height / 2));
    _drawCircle(canvas, 3, Offset(size.width, size.height / 2));
  }

  _drawCircle(Canvas canvas, int indicatorNumber, Offset offset) {
    (indicatorNumber == currentIndicator + 1)
        ? canvas.drawCircle(offset, _bigDot, dotPaint)
        : canvas.drawCircle(offset, _smallDot, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
