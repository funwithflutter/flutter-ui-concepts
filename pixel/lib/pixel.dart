import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fast_noise/fast_noise.dart';

class PixelNoise extends StatefulWidget {
  final Color color;
  const PixelNoise({Key key, this.color = Colors.white}) : super(key: key);

  @override
  _PixelNoiseState createState() => _PixelNoiseState();
}

class _PixelNoiseState extends State<PixelNoise>
    with SingleTickerProviderStateMixin {
  PerlinNoise _perlinNoise;

  AnimationController _controller;
  Animation _scrollAnim;

  @override
  void initState() {
    Random random = Random();
    _perlinNoise =
        PerlinNoise(octaves: 4, frequency: 0.15, seed: random.nextInt(1337));
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 100));
    _scrollAnim = IntTween(begin: 1, end: 100).animate(_controller);
    _controller.addListener(() {
      print('${_scrollAnim.value} animation');
    });
    _controller.addStatusListener(_loopingAnimation);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loopingAnimation(status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: AnimatedBuilder(
        animation: _scrollAnim,
        builder: (context, child) {
          return CustomPaint(
            painter: NoisePainter(
              _perlinNoise,
              _scrollAnim.value,
              color: Color.fromARGB(255, 235, 221, 196),
            ),
            isComplex: true,
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          );
        },
      ),
    );
  }
}

class NoisePainter extends CustomPainter {
  final PerlinNoise _noise;
  final int _xOffset;
  final Color color;
  final double pixelSize; // area to color in
  final double blockSize; // block for each pixel to create surrounding border

  static const _max = 0.5; // maximum noise value
  static const _min = -_max; // minimum noise value

  NoisePainter(
    this._noise,
    this._xOffset, {
    this.color = Colors.white,
    this.pixelSize = 18,
  }) : this.blockSize = pixelSize * 1.4;

  @override
  void paint(Canvas canvas, Size size) {
    Paint painting = Paint()..style = PaintingStyle.fill;
    for (var x = 0.0; x < size.width / blockSize; x++) {
      for (var y = 0.0; y < size.height / blockSize; y++) {
        var noise = _noise.getPerlin2(_xOffset + x, y);
        var percentage = (noise - _min) / (_max - _min);
        var rgb = (percentage * 255);
        if (rgb > 140) {
          canvas.drawRect(
              Rect.fromLTWH(x * blockSize, y * blockSize, pixelSize, pixelSize),
              painting..color = color.withAlpha(rgb.floor()));
        }
      }
    }
  }

  @override
  bool shouldRepaint(NoisePainter oldDelegate) {
    if (oldDelegate._xOffset != (_xOffset)) {
      return true;
    }
    return false;
  }
}
