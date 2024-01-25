import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  const AnimatedContainerPage({super.key});

  @override
  State<AnimatedContainerPage> createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  bool _isZoomedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated container'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
              curve: Curves.bounceInOut,
              width: _isZoomedIn ? 200 : MediaQuery.of(context).size.width,
              duration: const Duration(milliseconds: 500),
              child: Image.asset('assets/images/wallpaper.jpg'),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isZoomedIn = !_isZoomedIn;
              });
            },
            child: Text(
              _isZoomedIn ? 'Zoom out' : 'Zoom in',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
