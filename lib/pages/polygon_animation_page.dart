import 'dart:math';

import 'package:flutter/material.dart';

class PolygonAnimationPage extends StatefulWidget {
  const PolygonAnimationPage({super.key});

  @override
  State<PolygonAnimationPage> createState() => _PolygonAnimationPageState();
}

class _PolygonAnimationPageState extends State<PolygonAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _sideAnimationContoller;
  late Animation<int> _sideAnimation;

  late AnimationController _radiusAnimationController;
  late Animation<double> _radiusAnimation;

  late AnimationController _rotationAnimationController;
  late Animation<double> _rotationAnimation;

  @override
  void dispose() {
    _sideAnimationContoller.dispose();
    _radiusAnimationController.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _sideAnimationContoller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _sideAnimation = IntTween(
      begin: 3,
      end: 10,
    ).animate(_sideAnimationContoller);

    _radiusAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _radiusAnimation = Tween<double>(
      begin: 20,
      end: 360,
    )
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_radiusAnimationController);

    _rotationAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    )
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_rotationAnimationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sideAnimationContoller.repeat(reverse: true);
    _radiusAnimationController.repeat(reverse: true);
    _rotationAnimationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygon animation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _sideAnimationContoller,
              _radiusAnimationController,
              _rotationAnimationController,
            ]),
            builder: (BuildContext context, Widget? child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_rotationAnimation.value)
                  ..rotateY(_rotationAnimation.value)
                  ..rotateZ(_rotationAnimation.value),
                child: CustomPaint(
                  painter: Polygon(sides: _sideAnimation.value),
                  child: SizedBox(
                    width: _radiusAnimation.value,
                    height: _radiusAnimation.value,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Polygon extends CustomPainter {
  Polygon({required this.sides, super.repaint});

  final int sides;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();

    final center = Offset(size.width / 2, size.height / 2);
    final angle = (2 * pi) / sides;
    final angles = List.generate(sides, (index) => index * angle);
    final radius = size.width / 2;

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}
