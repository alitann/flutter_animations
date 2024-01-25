import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  const NavigatorButton({
    required this.title,
    required this.navigationPage,
    super.key,
  });
  final String title;
  final Widget navigationPage;

  void _navigateToAnimation(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _navigateToAnimation(
          context,
          navigationPage,
        );
      },
    );
  }
}
