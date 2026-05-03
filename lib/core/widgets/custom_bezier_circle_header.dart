import 'dart:math' as math;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_images.dart';
import 'package:lottie/lottie.dart';

class CustomBezierCircleHeader extends Header {
  final Key? key;

  /// Foreground color.
  final Color? foregroundColor;

  /// Background color.
  final Color? backgroundColor;

  final String? releaseLabel;

  const CustomBezierCircleHeader({
    this.key,
    super.triggerOffset = 100,
    super.clamping = false,
    super.position,
    SpringBuilder super.readySpringBuilder = kBezierSpringBuilder,
    super.springRebound = false,
    FrictionFactor super.frictionFactor = kBezierFrictionFactor,
    super.safeArea,
    super.infiniteOffset,
    super.hitOver,
    super.infiniteHitOver,
    super.hapticFeedback,
    this.foregroundColor,
    this.backgroundColor,
    this.releaseLabel,
  }) : super(
         processedDuration: kBezierCircleDisappearDuration,
       );

  @override
  Widget build(BuildContext context, IndicatorState state) {
    assert(
      state.axis == Axis.vertical,
      'BezierCircleHeader does not support horizontal scrolling.',
    );
    assert(!state.reverse, 'BezierCircleHeader does not support reverse.');
    return _CustomBezierCircleIndicator(
      key: key,
      state: state,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      releaseLabel: releaseLabel,
    );
  }
}

const double _kBallRadius = 16.0;

const double _kProgressRadius = _kBallRadius + 4;

const Duration kBezierCircleDisappearDuration = Duration(milliseconds: 800);

/// Bezier indicator.
/// Base widget for [CustomBezierCircleHeader].
class _CustomBezierCircleIndicator extends StatefulWidget {
  /// Indicator properties and state.
  final IndicatorState state;

  /// Foreground color.
  final Color? foregroundColor;

  /// Background color.
  final Color? backgroundColor;

  final String? releaseLabel;

  const _CustomBezierCircleIndicator({
    super.key,
    required this.state,
    this.foregroundColor,
    this.backgroundColor,
    this.releaseLabel,
  });

  @override
  State<_CustomBezierCircleIndicator> createState() =>
      _CustomBezierCircleIndicatorState();
}

class _CustomBezierCircleIndicatorState
    extends State<_CustomBezierCircleIndicator>
    with TickerProviderStateMixin {
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const Duration _processedAnimationDuration = Duration(
    milliseconds: 500,
  );

  late AnimationController _animationController;
  late AnimationController _processedAnimationController;
  late AnimationController _disappearAnimationController;

  final ValueNotifier<double> _reboundOffsetNotifier = ValueNotifier<double>(
    0.0,
  );

  IndicatorMode get _mode => widget.state.mode;

  double get _offset => widget.state.offset;

  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  @override
  void initState() {
    super.initState();
    widget.state.notifier.addModeChangeListener(_onModeChange);
    _animationController = AnimationController.unbounded(
      vsync: this,
      duration: _animationDuration,
    );
    _processedAnimationController = AnimationController(
      vsync: this,
      duration: _processedAnimationDuration,
    );
    _disappearAnimationController = AnimationController.unbounded(
      vsync: this,
      duration: kBezierCircleDisappearDuration - _processedAnimationDuration,
    );
  }

  @override
  void dispose() {
    widget.state.notifier.removeModeChangeListener(_onModeChange);
    _animationController.dispose();
    _processedAnimationController.dispose();
    _disappearAnimationController.dispose();
    super.dispose();
  }

  /// Mode change listener.
  void _onModeChange(IndicatorMode mode, double offset) {
    if (mode == IndicatorMode.processing) {
      // Start animation.
      if (!_animationController.isAnimating) {
        _animationController.value = _kBallRadius * 2 + offset;
        _animationController.animateTo(_actualTriggerOffset / 2 - _kBallRadius);
      }
      return;
    } else {
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
    }
    if (mode == IndicatorMode.processed) {
      // Processed animation.
      if (!_processedAnimationController.isAnimating) {
        _processedAnimationController.forward(from: 0).then((_) {
          // Disappear animation.
          _disappearAnimationController.value =
              _actualTriggerOffset / 2 - _kBallRadius;
          _disappearAnimationController.animateTo(
            _kBallRadius * 2 + _actualTriggerOffset,
          );
        });
      }
      return;
    } else {
      if (_processedAnimationController.isAnimating) {
        _processedAnimationController.stop();
      }
    }
  }

  /// Build ball.
  Widget _buildBall(double offset, Color color) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        painter: _BallPaint(
          color: color,
          ballCenterY: offset + _kBallRadius,
          reboundOffset: _animationController.isAnimating
              ? _reboundOffsetNotifier.value
              : null,
        ),
      ),
    );
  }

  /// Build ball tail.
  Widget _buildBallTail(Color color) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        painter: _BallTailPaint(
          color: color,
          ballCenterY: _animationController.value + _kBallRadius,
          scale:
              (_actualTriggerOffset - _animationController.value) /
              (_actualTriggerOffset / 2 + _kBallRadius),
          reboundOffset: _reboundOffsetNotifier.value,
        ),
      ),
    );
  }

  /// Build progress
  Widget _buildProgress(
    double radius,
    double? value,
    double opacity,
    Color color,
  ) {
    return Positioned(
      top: _actualTriggerOffset / 2 - radius,
      child: SizedBox(
        height: radius * 2,
        width: radius * 2,
        child: Opacity(
          opacity: opacity,
          child: CircularProgressIndicator(
            color: color,
            strokeWidth: 2,
            value: value,
          ),
        ),
      ),
    );
  }

  /// Build ball drop
  Widget _buildBallDrop(Color color) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        painter: _BallDropPaint(
          color: color,
          ballCenterY: _disappearAnimationController.value + _kBallRadius,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foregroundColor =
        widget.foregroundColor ?? theme.colorScheme.onPrimary;
    final backgroundColor = widget.backgroundColor ?? theme.colorScheme.primary;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        BezierBackground(
          state: widget.state,
          reverse: false,
          useAnimation: true,
          bounce: true,
          color: backgroundColor,
          onReboundOffsetChanged: (double value) {
            _reboundOffsetNotifier.value = value;
          },
        ),

        // Arrow Animation
        if (_mode == IndicatorMode.drag)
          Opacity(
            opacity: _offset < (_actualTriggerOffset * 0.7)
                ? _offset / (_actualTriggerOffset * 0.7)
                : 1,
            child: Center(
              child: RotatedBox(
                quarterTurns: 2,
                child: Lottie.asset(
                  AppImages.arrowBumpingAnimation,
                  height: _offset < (_actualTriggerOffset * 0.65)
                      ? (_offset / (_actualTriggerOffset * 0.65) * 50)
                      : 50,
                  alignment: Alignment.center,
                  delegates: LottieDelegates(
                    values: <ValueDelegate<dynamic>>[
                      ValueDelegate.colorFilter(
                        <String>['up arrow Outlines', '**'],
                        value: ColorFilter.mode(
                          foregroundColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      ValueDelegate.colorFilter(
                        <String>['green circle Outlines', '**'],
                        value: ColorFilter.mode(
                          foregroundColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        // Text
        if (_mode == IndicatorMode.armed)
          Text(
            widget.releaseLabel ?? 'Release',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w500,
            ),
          ),

        // Ball
        if (_mode == IndicatorMode.processing) ...<Widget>[
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, _) {
              return _buildBall(_animationController.value, foregroundColor);
            },
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, _) {
              return _animationController.isAnimating
                  ? const SizedBox()
                  : _buildProgress(_kProgressRadius, null, 1, foregroundColor);
            },
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, _) {
              final double value = _animationController.value;
              if (!_animationController.isAnimating || value < _kBallRadius) {
                return const SizedBox();
              }
              return _buildBallTail(foregroundColor);
            },
          ),
        ],
        if (_mode == IndicatorMode.processed) ...<Widget>[
          AnimatedBuilder(
            animation: _disappearAnimationController,
            builder: (BuildContext context, _) {
              if (!_disappearAnimationController.isAnimating &&
                  !_processedAnimationController.isAnimating) {
                return const SizedBox();
              }
              return _buildBall(
                _disappearAnimationController.isAnimating
                    ? _disappearAnimationController.value
                    : _actualTriggerOffset / 2 - _kBallRadius,
                foregroundColor,
              );
            },
          ),
          AnimatedBuilder(
            animation: _processedAnimationController,
            builder: (BuildContext context, _) {
              final double value = _processedAnimationController.value;
              return _processedAnimationController.isAnimating
                  ? _buildProgress(
                      _kProgressRadius + value * 4,
                      1,
                      1 - value,
                      foregroundColor,
                    )
                  : const SizedBox();
            },
          ),
          AnimatedBuilder(
            animation: _disappearAnimationController,
            builder: (BuildContext context, _) {
              if (!_disappearAnimationController.isAnimating) {
                return const SizedBox();
              }
              return _buildBallDrop(foregroundColor);
            },
          ),
        ],
      ],
    );
  }
}

Path _getBezierBackgroundPath(Size size, double reboundOffset) {
  final double width = size.width;
  final double height = size.height;
  final Path path = Path();
  path.moveTo(width, height);
  path.lineTo(width, 0);
  path.lineTo(0, 0);
  path.lineTo(0, height);
  path.quadraticBezierTo(
    width / 2,
    (reboundOffset - height) * 2 + height,
    width,
    height,
  );
  return path;
}

class _BallPaint extends CustomPainter {
  final Color color;
  final double ballCenterY;
  final double? reboundOffset;

  _BallPaint({
    required this.color,
    required this.ballCenterY,
    this.reboundOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double width = size.width;
    final double height = size.height;
    final Path path = Path();
    path.addOval(
      Rect.fromCircle(
        center: Offset(width / 2, ballCenterY),
        radius: _kBallRadius,
      ),
    );
    final Path bgPath = _getBezierBackgroundPath(size, reboundOffset ?? height);
    canvas.drawPath(Path.combine(PathOperation.intersect, path, bgPath), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _BallPaint &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          ballCenterY == other.ballCenterY &&
          reboundOffset == other.reboundOffset;

  @override
  int get hashCode =>
      color.hashCode ^ ballCenterY.hashCode ^ reboundOffset.hashCode;
}

class _BallTailPaint extends CustomPainter {
  final Color color;
  final double ballCenterY;
  final double scale;
  final double reboundOffset;

  _BallTailPaint({
    required this.color,
    required this.ballCenterY,
    required this.scale,
    required this.reboundOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (reboundOffset - ballCenterY < _kBallRadius) {
      return;
    }
    final Paint paint = Paint()..color = color;
    final double width = size.width;
    final double bottom = reboundOffset;
    final double startY = ballCenterY + _kBallRadius * scale / 2;
    final double startX =
        width / 2 +
        math.sqrt(_kBallRadius * _kBallRadius * (1 - scale * scale / 4));
    final double bezier1x = (width / 2 + (_kBallRadius * 3 / 4) * (1 - scale));
    final double bezier2x = bezier1x + _kBallRadius;
    final Path path = Path();
    path.moveTo(startX, startY);
    path.quadraticBezierTo(bezier1x, bottom, bezier2x, bottom);
    path.lineTo(width - bezier2x, bottom);
    path.quadraticBezierTo(width - bezier1x, bottom, width - startX, startY);
    final Path bgPath = _getBezierBackgroundPath(size, reboundOffset);
    canvas.drawPath(Path.combine(PathOperation.intersect, path, bgPath), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _BallTailPaint &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          ballCenterY == other.ballCenterY &&
          scale == other.scale &&
          reboundOffset == other.reboundOffset;

  @override
  int get hashCode =>
      color.hashCode ^
      ballCenterY.hashCode ^
      scale.hashCode ^
      reboundOffset.hashCode;
}

class _BallDropPaint extends CustomPainter {
  final Color color;
  final double ballCenterY;

  _BallDropPaint({
    required this.color,
    required this.ballCenterY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double height = size.height;
    final double width = size.width;
    Path path = Path();
    final Path rectPath = Path();
    rectPath.addRect(
      Rect.fromPoints(
        const Offset(0, 0),
        Offset(width, height),
      ),
    );
    if (ballCenterY > height) {
      final double bezierHeight =
          _kBallRadius *
          ((height + 2 * _kBallRadius - ballCenterY) / (3 * _kBallRadius));
      final double bezierWidth = _kBallRadius * _kBallRadius * 2 / bezierHeight;
      path.moveTo((width - bezierWidth) / 2, height);
      path.quadraticBezierTo(
        width / 2,
        height - bezierHeight * 2,
        (width + bezierWidth) / 2,
        height,
      );
      path.close();
      canvas.drawPath(
        Path.combine(PathOperation.intersect, path, rectPath),
        paint,
      );
    } else if (ballCenterY > height - _kBallRadius * 2) {
      final double scale = 1 - ((ballCenterY - _kBallRadius) / height);
      final double bottom = height;
      final double startY = ballCenterY + _kBallRadius * scale / 2;
      final double startX =
          width / 2 +
          math.sqrt(_kBallRadius * _kBallRadius * (1 - scale * scale / 4));
      final double bezier1x =
          (width / 2 + (_kBallRadius * 3 / 4) * (1 - scale));
      final double bezier2x = bezier1x + _kBallRadius;
      path.moveTo(startX, startY);
      path.quadraticBezierTo(bezier1x, bottom, bezier2x, bottom);
      path.lineTo(width - bezier2x, bottom);
      path.quadraticBezierTo(width - bezier1x, bottom, width - startX, startY);
      canvas.drawPath(
        Path.combine(PathOperation.intersect, path, rectPath),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate == this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _BallDropPaint &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          ballCenterY == other.ballCenterY;

  @override
  int get hashCode => color.hashCode ^ ballCenterY.hashCode;
}
