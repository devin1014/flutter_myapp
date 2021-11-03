import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/home.dart';
import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:flutter_router_demo/util/logger.dart';
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_router_demo/widget/loading.dart';

import 'model/root.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  HomeItem? _contentItem;

  @override
  void initState() {
    super.initState();
    _loadData("data/home_landing.json");
  }

  void _loadData(String path) async {
    Map<String, dynamic> object = await Parser.parseAssets(path);
    Map<String, dynamic> contents = (object['appHomeMainFeed'] as List<dynamic>)[6];
    final item = HomeItem.fromJson(contents);
    setState(() {
      _contentItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_contentItem == null) const LoadingPage.fixHeight(220);
    final list = _contentItem!.value!.list;
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: HomePage.edgePadding),
        itemCount: list.length,
        itemBuilder: (context, index) => _buildItem(list[index] as CardCarousel),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
      ),
    );
  }

  Widget _buildItem(CardCarousel carousel) {
    return SizedBox(
      width: 160,
      child: Stack(
        children: [
          ExtendedImage.network(carousel.image),
          Container(
            color: const Color(0xaaafafaf),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              carousel.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
