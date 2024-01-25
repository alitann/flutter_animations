import 'dart:math';

import 'package:flutter/material.dart';

class TweenAnimationPage extends StatefulWidget {
  const TweenAnimationPage({super.key});

  @override
  State<TweenAnimationPage> createState() => _TweenAnimationPageState();
}

class _TweenAnimationPageState extends State<TweenAnimationPage> {
  var _color = getRandomColor();
  final _nextColor = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tween color animation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipPath(
              clipper: CircleClipper(),
              child: TweenAnimationBuilder<Color?>(
                onEnd: () {
                  setState(() {
                    _color = getRandomColor();
                  });
                },
                tween: ColorTween(
                  begin: _nextColor,
                  end: _color,
                ),
                duration: const Duration(seconds: 1),
                builder: (BuildContext context, Color? color, Widget? child) {
                  return ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      color ?? Colors.transparent,
                      BlendMode.modulate,
                    ),
                    child: child,
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color getRandomColor() {
  return Color(Random().nextInt(0xffffffff));
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
