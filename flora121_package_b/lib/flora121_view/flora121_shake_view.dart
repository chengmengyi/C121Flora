import 'package:flutter/material.dart';

// class Flora121ShakeView extends StatefulWidget {
//   final Widget child;
//   final double offset; // 晃动幅度
//   final Duration duration;
//
//   const Flora121ShakeView({
//     super.key,
//     required this.child,
//     this.offset = 10.0,
//     this.duration = const Duration(milliseconds: 100),
//   });
//
//   @override
//   State<Flora121ShakeView> createState() => _ShakeWidgetState();
// }
//
// class _ShakeWidgetState extends State<Flora121ShakeView> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.duration,
//     );
//
//     // Tween: 左右偏移
//     _animation = TweenSequence<double>([
//       TweenSequenceItem(tween: Tween(begin: 0, end: -widget.offset), weight: 1),
//       TweenSequenceItem(tween: Tween(begin: -widget.offset, end: widget.offset), weight: 2),
//       TweenSequenceItem(tween: Tween(begin: widget.offset, end: 0), weight: 1),
//     ]).animate(_controller);
//
//     _controller.repeat(); // 无限循环
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(_animation.value, 0), // 横向晃动
//           child: child,
//         );
//       },
//       child: widget.child,
//     );
//   }
// }


class RotateShakeWidget extends StatefulWidget {
  final Widget child;
  final double angle; // 最大旋转角度（弧度）
  final Duration duration;

  const RotateShakeWidget({
    super.key,
    required this.child,
    this.angle = 0.03, // 约 1.7 度
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<RotateShakeWidget> createState() => _RotateShakeWidgetState();
}

class _RotateShakeWidgetState extends State<RotateShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // TweenSequence 左右旋转（顺/逆时针来回）
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: -widget.angle, end: widget.angle), weight: 1),
      TweenSequenceItem(tween: Tween(begin: widget.angle, end: -widget.angle), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat(); // 无限循环
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: child,
        );
      },
    );
  }
}