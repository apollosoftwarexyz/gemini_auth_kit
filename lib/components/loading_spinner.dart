import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Implementation of a widget as [StatefulWidget] with [AnimationController]
class LoadingSpinner extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final bool animating;

  const LoadingSpinner({
    required this.activeColor,
    required this.inactiveColor,
    this.animating = true,
    Key? key,
  }) : super(key: key);

  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner> with SingleTickerProviderStateMixin {
  final _tickCount = 8;
  final _startRatio = 0.45;
  final _endRatio = 0.85;
  final _radius = 24.0;
  final _relativeWidth = 0.35;
  final _animationDuration = const Duration(seconds: 1);
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    if (widget.animating) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(LoadingSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating) {
        _animationController.repeat();
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _radius * 2,
      width: _radius * 2,
      child: CustomPaint(
        painter: _AppActivityIndicatorPainter(
          animationController: _animationController,
          radius: _radius,
          tickCount: _tickCount,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          relativeWidth: _relativeWidth,
          startRatio: _startRatio,
          endRatio: _endRatio,
        ),
      ),
    );
  }
}

class _AppActivityIndicatorPainter extends CustomPainter {
  final int _halfTickCount;
  final Animation<double> animationController;
  final Color? activeColor;
  final Color? inactiveColor;
  final double relativeWidth;
  final int tickCount;
  final double radius;
  final RRect _tickRRect;
  final double startRatio;
  final double endRatio;

  _AppActivityIndicatorPainter({
    required this.radius,
    required this.tickCount,
    required this.animationController,
    this.activeColor,
    this.inactiveColor,
    required this.relativeWidth,
    required this.startRatio,
    required this.endRatio,
  })  : _halfTickCount = tickCount ~/ 2,
        _tickRRect = RRect.fromLTRBXY(
          -radius * endRatio,
          relativeWidth * radius / 10,
          -radius * startRatio,
          -relativeWidth * radius / 10,
          1,
          1,
        ),
        super(repaint: animationController);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2);
    final activeTick = (tickCount * animationController.value).floor();
    for (int i = 0; i < tickCount; ++i) {
      paint.color = Color.lerp(
        activeColor,
        inactiveColor,
        ((i + activeTick) % tickCount) / _halfTickCount,
      )!;
      canvas
        ..drawRRect(_tickRRect, paint)
        ..rotate(-math.pi * 2 / tickCount);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_AppActivityIndicatorPainter oldPainter) {
    return oldPainter.animationController != animationController;
  }
}
