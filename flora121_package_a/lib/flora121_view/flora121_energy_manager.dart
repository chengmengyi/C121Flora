import 'dart:math';
import 'dart:collection';
import 'package:flutter/material.dart';

/// 飞行队列管理器
typedef FlyCallback = Future<void> Function();

class FlyQueueManager {
  static final FlyQueueManager _instance = FlyQueueManager._internal();
  factory FlyQueueManager() => _instance;
  FlyQueueManager._internal();

  final Queue<FlyCallback> _queue = Queue();
  bool _isRunning = false;

  void add(FlyCallback callback) {
    _queue.add(callback);
    _runNext();
  }

  void _runNext() async {
    if (_isRunning || _queue.isEmpty) return;
    _isRunning = true;

    final task = _queue.removeFirst();
    await task();

    _isRunning = false;
    _runNext();
  }
}

/// 单个能量点
class EnergyItem extends StatefulWidget {
  final Offset start;
  final Offset flowerBottom;
  final VoidCallback onCollected;
  final double size;
  final Widget child;
  final double containerWidth;
  final double containerHeight;

  const EnergyItem({
    Key? key,
    required this.start,
    required this.flowerBottom,
    required this.onCollected,
    required this.child,
    required this.containerWidth,
    required this.containerHeight,
    this.size = 66,
  }) : super(key: key);

  @override
  State<EnergyItem> createState() => _EnergyItemState();
}

class _EnergyItemState extends State<EnergyItem> with TickerProviderStateMixin {
  late AnimationController _breathController;
  late AnimationController _flyController;

  late Animation<double> _breathAnim;
  late Animation<double> _flyT;
  late Animation<double> _flyScale;
  late Animation<double> _flyOpacity;

  bool _isFlying = false;
  late Offset _currentStart;
  late Offset _currentEnd;
  late Offset _controlPoint;

  @override
  void initState() {
    super.initState();
    _currentStart = widget.start;

    // 呼吸动画
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _breathAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: Random().nextInt(500)), () {
      if (mounted) _breathController.repeat(reverse: true);
    });

    // 飞行动画
    _flyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _flyT = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flyController, curve: Curves.easeInOut),
    );

    _flyController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        widget.onCollected();

        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return;

        final r = Random();
        _currentStart = widget.start +
            Offset(r.nextDouble() * 60 - 30, r.nextDouble() * 60 - 30);
        _currentStart = _clampToContainer(_currentStart);

        _currentEnd = _currentStart;
        _controlPoint = _computeControl(widget.flowerBottom.translate(0, -100), _currentEnd);

        _flyScale = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _flyController, curve: Curves.easeOutBack),
        );
        _flyOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _flyController, curve: Curves.easeIn),
        );

        _isFlying = true;
        _flyController.reset();
        await _flyController.forward();

        _isFlying = false;
        _breathController.repeat(reverse: true);
      }
    });
  }

  Offset _clampToContainer(Offset p) {
    double x = p.dx.clamp(0.0, widget.containerWidth - widget.size);
    double y = p.dy.clamp(0.0, widget.containerHeight - widget.size);
    return Offset(x, y);
  }

  Offset _computeControl(Offset start, Offset end) {
    final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
    final r = Random();
    double dx = (r.nextBool() ? 1 : -1) * (50 + r.nextDouble() * 30);
    double dy = -50 - r.nextDouble() * 30;

    return _clampToContainer(mid.translate(dx, dy));
  }

  Offset _bezier(Offset p0, Offset p1, Offset pc, double t) {
    final x = (1 - t) * (1 - t) * p0.dx + 2 * (1 - t) * t * pc.dx + t * t * p1.dx;
    final y = (1 - t) * (1 - t) * p0.dy + 2 * (1 - t) * t * pc.dy + t * t * p1.dy;
    return Offset(x, y);
  }

  void _startCollect() {
    if (_isFlying) return;

    FlyQueueManager().add(() async {
      _breathController.stop();

      _currentEnd = _clampToContainer(widget.flowerBottom.translate(0, -100));
      _controlPoint = _computeControl(_currentStart, _currentEnd);

      _flyScale = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _flyController, curve: Curves.easeIn),
      );
      _flyOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _flyController, curve: Curves.easeIn),
      );

      _isFlying = true;
      _flyController.reset();
      await _flyController.forward();
    });
  }

  @override
  void dispose() {
    _breathController.dispose();
    _flyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_breathController, _flyController]),
      builder: (context, child) {
        Offset offset;
        double scale;
        double opacity;

        if (_isFlying) {
          final t = _flyT.value;
          offset = _bezier(_currentStart, _currentEnd, _controlPoint, t);
          scale = _flyScale.value;
          opacity = _flyOpacity.value;
        } else {
          offset = _currentStart;
          scale = _breathAnim.value;
          opacity = 1.0;
        }

        return Positioned(
          left: offset.dx,
          top: offset.dy,
          child: GestureDetector(
            onTap: _startCollect,
            child: Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: SizedBox(width: widget.size, height: widget.size, child: widget.child),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 能量图层（环绕点 ±30 随机偏移 + 防重叠）
class EnergyLayer extends StatefulWidget {
  final GlobalKey flowerKey;
  final int count;
  final double energySize;
  final Widget Function(int index) buildEnergy;

  const EnergyLayer({
    Key? key,
    required this.flowerKey,
    required this.count,
    required this.buildEnergy,
    this.energySize = 66,
  }) : super(key: key);

  @override
  State<EnergyLayer> createState() => _EnergyLayerState();
}

class _EnergyLayerState extends State<EnergyLayer> {
  Offset flowerCenter = Offset.zero;
  Offset flowerBottom = Offset.zero;
  List<Offset> baseOffsets = [];
  double containerWidth = 0;
  double containerHeight = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      containerWidth = constraints.maxWidth;
      containerHeight = constraints.maxHeight;

      final box = widget.flowerKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        final parentBox = context.findRenderObject() as RenderBox;
        final globalPos = box.localToGlobal(Offset.zero);
        final localPos = parentBox.globalToLocal(globalPos);
        final size = box.size;

        flowerCenter = Offset(localPos.dx + size.width / 2, localPos.dy + size.height / 2);
        flowerBottom = Offset(localPos.dx + size.width / 2, localPos.dy + size.height);
      }

      if (baseOffsets.isEmpty && flowerBottom != Offset.zero) {
        final List<Offset> rawOffsets = [
          const Offset(0, -120),
          const Offset(-90, -60),
          const Offset(90, -60),
          const Offset(-70, 40),
          const Offset(70, 40),
        ].sublist(0, widget.count);

        final r = Random();
        final double minDistance = widget.energySize; // 最小距离
        List<Offset> tempOffsets = [];

        for (var base in rawOffsets) {
          Offset newOffset;
          int attempts = 0;
          do {
            final dx = base.dx + (r.nextInt(61) - 30).toDouble();
            final dy = base.dy + (r.nextInt(61) - 30).toDouble();
            newOffset = flowerCenter + Offset(dx, dy);
            // 限制在容器内
            newOffset = Offset(
              newOffset.dx.clamp(0.0, containerWidth - widget.energySize),
              newOffset.dy.clamp(0.0, containerHeight - widget.energySize),
            );
            attempts++;
          } while (tempOffsets.any((o) => (o - newOffset).distance < minDistance) && attempts < 10);

          tempOffsets.add(newOffset);
        }
        baseOffsets = tempOffsets;
      }

      if (flowerBottom == Offset.zero || baseOffsets.isEmpty) return SizedBox.shrink();

      return Stack(
        fit: StackFit.expand,
        children: [
          for (int i = 0; i < baseOffsets.length; i++)
            EnergyItem(
              start: baseOffsets[i],
              flowerBottom: flowerBottom,
              size: widget.energySize,
              containerWidth: containerWidth,
              containerHeight: containerHeight,
              child: widget.buildEnergy(i),
              onCollected: () => debugPrint("能量 $i 收集完成"),
            ),
        ],
      );
    });
  }
}