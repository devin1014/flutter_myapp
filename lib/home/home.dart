import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/content.dart';
import 'package:flutter_router_demo/home/hero.dart';
import 'package:flutter_router_demo/home/news.dart';
import 'package:flutter_router_demo/home/single.dart';
import 'package:flutter_router_demo/home/story.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const edgePadding = 12.0;
  static const itemTitleHeight = 40.0;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // _buildItemTitle("Hero"),
        // const SliverToBoxAdapter(child: HomeHeroPage()),
        // _buildItemTitle("Story"),
        // const SliverToBoxAdapter(child: HomeStoryPage()),
        // _buildItemTitle("News"),
        // const HomeNewsPage(),
        // _buildItemTitle("Content"),
        // const SliverToBoxAdapter(child: HomeContentPage()),
        const SliverToBoxAdapter(child: HomeSinglePage()),
      ],
    );
  }

  Widget _buildItemTitle(String title) {
    return SliverToBoxAdapter(
      child: Container(
        // width: double.infinity,
        height: HomePage.itemTitleHeight,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: HomePage.edgePadding),
          child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
