import 'package:animations/pages/animated_container_page.dart';
import 'package:animations/pages/hero_animation_page.dart';
import 'package:animations/pages/polygon_animation_page.dart';
import 'package:animations/pages/rotate_animations_page.dart';
import 'package:animations/pages/threed_rotate_animation_page.dart';
import 'package:animations/pages/tween_animation_page.dart';
import 'package:animations/widgets/navigate_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations'),
        elevation: 12,
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: <Widget>[
                NavigatorButton(
                  title: 'Rotate animations',
                  navigationPage: RotateAnimationsPage(),
                ),
                NavigatorButton(
                  title: '3D Rotate animation',
                  navigationPage: ThreeDRotateAnimationPage(),
                ),
                NavigatorButton(
                  title: 'Hero animation',
                  navigationPage: HeroAnimationPage(),
                ),
                NavigatorButton(
                  title: 'Animated container',
                  navigationPage: AnimatedContainerPage(),
                ),
                NavigatorButton(
                  title: 'Tween animation',
                  navigationPage: TweenAnimationPage(),
                ),
                NavigatorButton(
                  title: 'Polygon paint and animations',
                  navigationPage: PolygonAnimationPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
