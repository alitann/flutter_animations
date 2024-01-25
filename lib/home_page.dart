import 'package:animations/pages/rotate_animations_page.dart';
import 'package:animations/pages/threed_rotate_animation_page.dart';
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
