import 'package:flutter/material.dart';

@immutable
class Person {
  const Person({required this.name, required this.age, required this.emoji});

  final String name;
  final int age;
  final String emoji;
}
