import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/hero.dart';
import 'package:flutter_router_demo/home/story.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HomeHeroPage(),
          HomeStoryPage(),
        ],
      ),
    );
  }
}
