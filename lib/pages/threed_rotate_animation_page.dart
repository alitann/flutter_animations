import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreeDRotateAnimationPage extends StatefulWidget {
  const ThreeDRotateAnimationPage({super.key});

  @override
  State<ThreeDRotateAnimationPage> createState() =>
      _ThreeDRotateAnimationPageState();
}

const widthAndHeight = 120.0;

class _ThreeDRotateAnimationPageState extends State<ThreeDRotateAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _xAnimationController;
  late AnimationController _yAnimationController;
  late AnimationController _zAnimationController;

  late Tween<double> _animation;

  @override
  void dispose() {
    _xAnimationController.dispose();
    _yAnimationController.dispose();
    _zAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _xAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));

    _yAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));

    _zAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _xAnimationController
      ..reset()
      ..repeat();

    _yAnimationController
      ..reset()
      ..repeat();

    _zAnimationController
      ..reset()
      ..repeat();

    return Scaffold(
      appBar: AppBar(
        title: const Text('3D rotate animation'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: widthAndHeight),
            AnimatedBuilder(
              animation: Listenable.merge([
                _xAnimationController,
                _yAnimationController,
                _zAnimationController,
              ]),
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xAnimationController))
                    ..rotateY(_animation.evaluate(_yAnimationController))
                    ..rotateZ(_animation.evaluate(_zAnimationController)),
                  child: Stack(
                    children: [
                      //Left side
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        child: Container(
                          color: Colors.green,
                          height: widthAndHeight,
                          width: widthAndHeight,
                        ),
                      ),
                      // Back side
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(Vector3(0, 0, -widthAndHeight)),
                        child: Container(
                          color: Colors.blue,
                          height: widthAndHeight,
                          width: widthAndHeight,
                        ),
                      ),
                      //Front
                      Container(
                        color: Colors.red,
                        height: widthAndHeight,
                        width: widthAndHeight,
                      ),
                      //Right side
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-(pi / 2)),
                        child: Container(
                          color: Colors.yellow,
                          height: widthAndHeight,
                          width: widthAndHeight,
                        ),
                      ),
                      //Top side
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-(pi / 2)),
                        child: Container(
                          color: Colors.brown,
                          height: widthAndHeight,
                          width: widthAndHeight,
                        ),
                      ),
                      //Bottom side
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi / 2),
                        child: Container(
                          color: Colors.orange,
                          height: widthAndHeight,
                          width: widthAndHeight,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
