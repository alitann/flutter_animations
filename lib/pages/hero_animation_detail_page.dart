import 'package:animations/models/person.dart';
import 'package:flutter/material.dart';

class HeroAnimationDetailPage extends StatelessWidget {
  const HeroAnimationDetailPage({required this.person, super.key});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(begin: 0, end: 1)
                          .chain(CurveTween(curve: Curves.fastOutSlowIn)),
                    ),
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: fromHeroContext.widget,
                );
            }
          },
          tag: person.name,
          child: Text(
            person.emoji,
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
