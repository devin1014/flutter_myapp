import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    // return NestedScrollView(
    //   headerSliverBuilder: (context, innerBoxScrolled) {
    //     return <Widget>[
    //       const SliverToBoxAdapter(child: HomeHeroPage()),
    //       const SliverToBoxAdapter(child: HomeStoryPage()),
    //     ];
    //   },
    //   body: const HomeContentPage(),
    // );
    return Container(
      color: Colors.white,
      child: const HomeContentPage(),
    );
  }
}
