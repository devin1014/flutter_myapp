import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/common/db/provider/model_provider.dart';
import 'package:flutter_router_demo/module/home/card.dart';
import 'package:flutter_router_demo/module/home/content.dart';
import 'package:flutter_router_demo/module/home/hero.dart';
import 'package:flutter_router_demo/module/home/model/root.dart';
import 'package:flutter_router_demo/module/home/news.dart';
import 'package:flutter_router_demo/module/home/single.dart';
import 'package:flutter_router_demo/module/home/story.dart';
import 'package:flutter_router_demo/module/home/tv.dart';
import 'package:flutter_router_demo/module/home/tv_show.dart';
import 'package:flutter_router_demo/util/logger.dart';
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_router_demo/widget/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const edgePadding = 12.0;
  static const itemTitleHeight = 40.0;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeRoot? _homeRoot;

  @override
  void initState() {
    super.initState();
    _loadData("data/home_landing.json");
  }

  void _loadData(String path) async {
    final HomeRoot homeRoot;
    final provider = DatabaseProvider();
    await provider.open(delete: true);
    final caches = await provider.get(path);
    if (caches.isNotEmpty) {
      final cache = caches.first;
      Log.i("cache: ${cache!.length}\n$cache");
      Map<String, dynamic> object = Parser.parse(cache);
      homeRoot = HomeRoot.fromJson(object);
    } else {
      Map<String, dynamic> object = await Parser.parseAssets(path);
      homeRoot = HomeRoot.fromJson(object);

      ///NOTE:object.toJson().toString(), missing ''!
      // final data = homeRoot.toJson().toString();
      final data = json.encode(object);
      Log.i("root: ${data.length}\n$data");
      provider.insert(path, data);
    }
    setState(() {
      _homeRoot = homeRoot;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_homeRoot == null) {
      return const Center(child: LoadingPage.expand());
    } else {
      List<Widget> list = [
        SliverToBoxAdapter(child: ExtendedImage.network(_homeRoot!.banner.mobileImage, fit: BoxFit.cover)),
        SliverToBoxAdapter(child: HomeHeroPage(_homeRoot!.heroList)),
      ];
      for (var item in _homeRoot!.contentList) {
        switch (item.type) {
          case HomeItem.itemContentCarousel:
            list.add(_buildItemTitle(item.title));
            list.add(SliverToBoxAdapter(child: HomeContentPage(item)));
            break;
          case HomeItem.itemHeadlines:
            list.add(_buildItemTitle(item.title));
            list.add(HomeNewsPage(item));
            break;
          case HomeItem.itemNbaTvCarousel:
            list.add(SliverToBoxAdapter(child: HomeTvPage(item)));
            break;
          case HomeItem.itemCollectionCards:
            list.add(_buildItemTitle(item.title));
            list.add(SliverToBoxAdapter(child: HomeCardPage(item)));
            break;
          case HomeItem.itemTaxonomyCards:
            list.add(_buildItemTitle(item.title));
            list.add(SliverToBoxAdapter(child: HomeTvShowPage(item)));
            break;
          case HomeItem.itemSingleItem:
            list.add(_buildItemTitle(""));
            list.add(SliverToBoxAdapter(child: HomeSinglePage(item)));
            break;
          case HomeItem.itemStories:
            list.add(_buildItemTitle("Story"));
            list.add(const SliverToBoxAdapter(child: HomeStoryPage()));
            break;
          default:
            break;
        }
      }
      return CustomScrollView(
        slivers: list,
      );
    }
  }

  Widget _buildItemTitle(String title) {
    return SliverToBoxAdapter(
      child: Container(
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
