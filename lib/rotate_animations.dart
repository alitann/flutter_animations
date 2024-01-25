import 'dart:math';

import 'package:flutter/material.dart';

class RotateAnimationsPage extends StatefulWidget {
  const RotateAnimationsPage({super.key});

  @override
  State<RotateAnimationsPage> createState() => _RotateAnimationsPageState();
}

class _RotateAnimationsPageState extends State<RotateAnimationsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late AnimationController _flipAnimationController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: -(pi / 2)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut),
    );

    _flipAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: _flipAnimationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(
          CurvedAnimation(
            parent: _flipAnimationController,
            curve: Curves.bounceOut,
          ),
        );
        _flipAnimationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      _animationController
        ..reset()
        ..forward();
    });

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _flipAnimationController,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateX(_flipAnimation.value),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateZ(_animation.value),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                            child: Container(
                              width: 50,
                              height: 100,
                              color: Colors.blue,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            child: Container(
                              width: 50,
                              height: 100,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
