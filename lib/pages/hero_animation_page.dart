import 'package:animations/models/person.dart';
import 'package:animations/pages/hero_animation_detail_page.dart';
import 'package:flutter/material.dart';

class HeroAnimationPage extends StatefulWidget {
  const HeroAnimationPage({super.key});

  @override
  State<HeroAnimationPage> createState() => _HeroAnimationPageState();
}

class _HeroAnimationPageState extends State<HeroAnimationPage> {
  List<Person> people = [
    const Person(name: 'John', age: 34, emoji: '🙋‍♂️'),
    const Person(name: 'Kate', age: 24, emoji: '🙋‍♀️'),
    const Person(name: 'Michael', age: 54, emoji: '🥷'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero animation'),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: people.length,
          itemBuilder: (context, index) {
            final person = people[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        HeroAnimationDetailPage(person: person),
                  ),
                );
              },
              title: Text(person.name),
              subtitle: Text('${person.age} years old'),
              leading: Hero(
                tag: person.name,
                child: Text(
                  person.emoji,
                  style: const TextStyle(fontSize: 50),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
