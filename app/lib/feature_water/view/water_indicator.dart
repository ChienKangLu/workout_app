import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaterIndicator extends StatefulWidget {
  const WaterIndicator({
    super.key,
    required this.size,
    this.trackColor,
    this.indicatorColor,
    required this.goal,
    required this.value,
  });

  final Size size;
  final Color? trackColor;
  final Color? indicatorColor;
  final double goal;
  final double value;

  @override
  State<WaterIndicator> createState() => _WaterIndicatorState();
}

class _WaterIndicatorState extends State<WaterIndicator> {
  Size get _size => widget.size;
  Color? get _trackColor => widget.trackColor;
  Color? get _indicatorColor => widget.indicatorColor;
  double get _goal => widget.goal;
  double get _value => widget.value;

  @override
  Widget build(BuildContext context) {
    final ratio = _value / _goal;

    return SizedBox.fromSize(
      size: _size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _CircleIndicator(
            size: _size,
            trackWidth: 10,
            trackColor: _trackColor,
            indicatorWidth: 15,
            indicatorColor: _indicatorColor,
            ratio: ratio,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${_value.toInt()}",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: _indicatorColor,
                      fontSize: 40,
                    ),
              ),
              Text(
                "/ ${_goal.toInt()}ml",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: _trackColor,
                      fontSize: 20,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleIndicator extends StatefulWidget {
  const _CircleIndicator({
    super.key,
    required this.size,
    required this.trackWidth,
    required this.trackColor,
    required this.indicatorWidth,
    required this.indicatorColor,
    required this.ratio,
  });

  final Size size;
  final double trackWidth;
  final Color? trackColor;
  final double indicatorWidth;
  final Color? indicatorColor;
  final double ratio;

  @override
  State<_CircleIndicator> createState() => _CircleIndicatorState();
}

class _CircleIndicatorState extends State<_CircleIndicator> {
  Size get _size => widget.size;
  double get _trackWidth => widget.trackWidth;
  Color? get _trackColor => widget.trackColor;
  double get _indicatorWidth => widget.indicatorWidth;
  Color? get _indicatorColor => widget.indicatorColor;
  double get _ratio => widget.ratio;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: _size,
      painter: CircleIndicatorPainter(
        trackWidth: _trackWidth,
        trackColor: _trackColor,
        indicatorWidth: _indicatorWidth,
        indicatorColor: _indicatorColor,
        ratio: _ratio,
      ),
    );
  }
}

class CircleIndicatorPainter extends CustomPainter {
  CircleIndicatorPainter({
    required this.trackWidth,
    required this.trackColor,
    required this.indicatorWidth,
    required this.indicatorColor,
    required this.ratio,
  });

  final double trackWidth;
  final Color? trackColor;
  final double indicatorWidth;
  final Color? indicatorColor;
  final double ratio;

  @override
  void paint(Canvas canvas, Size size) {
    _drawTrack(canvas, size);
    _drawIndicator(canvas, size);
  }

  void _drawTrack(Canvas canvas, Size size) {
    final top = indicatorWidth - trackWidth / 2;
    final left = indicatorWidth - trackWidth / 2;
    final right = size.width - (indicatorWidth - trackWidth / 2);
    final bottom = size.width - (indicatorWidth - trackWidth / 2);
    final rect = Rect.fromLTRB(top, left, right, bottom);

    _drawArc(
      canvas,
      rect,
      trackColor ?? Colors.yellow,
      trackWidth,
      1,
    );
  }

  void _drawIndicator(Canvas canvas, Size size) {
    final top = indicatorWidth / 2;
    final left = indicatorWidth / 2;
    final right = size.width - indicatorWidth / 2;
    final bottom = size.width - indicatorWidth / 2;
    final rect = Rect.fromLTRB(top, left, right, bottom);

    _drawArc(
      canvas,
      rect,
      indicatorColor ?? Colors.black,
      indicatorWidth,
      ratio,
    );
  }

  void _drawArc(
    Canvas canvas,
    Rect rect,
    Color color,
    double strokeWidth,
    double ratio,
  ) {
    const startAngle = (3 * math.pi) / 2;
    final sweepAngle = 2 * math.pi * ratio;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
