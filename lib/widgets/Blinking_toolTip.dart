import 'dart:async';
import 'package:flutter/material.dart';

class BlinkingTooltip extends StatefulWidget {
  final String message;
  final Widget child;
  final int blinkCount; // Number of times the tooltip should blink

  BlinkingTooltip({
    required this.message,
    required this.child,
    this.blinkCount = 5,
  });

  @override
  _BlinkingTooltipState createState() => _BlinkingTooltipState();
}

class _BlinkingTooltipState extends State<BlinkingTooltip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _timer;
  int _currentBlinkCount = 0;
  final Duration _blinkInterval = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    // Start blinking
    _startBlinking();
  }

  void _startBlinking() {
    _timer = Timer.periodic(_blinkInterval, (timer) {
      setState(() {
        _currentBlinkCount++;
        if (_currentBlinkCount >= widget.blinkCount) {
          _timer.cancel();
          _animationController.stop();
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Tooltip(
        message: widget.message,
        child: widget.child,
      ),
    );
  }
}
