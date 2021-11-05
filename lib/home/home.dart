import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/card.dart';
import 'package:flutter_router_demo/home/content.dart';
import 'package:flutter_router_demo/home/hero.dart';
import 'package:flutter_router_demo/home/model/root.dart';
import 'package:flutter_router_demo/home/news.dart';
import 'package:flutter_router_demo/home/single.dart';
import 'package:flutter_router_demo/home/tv.dart';
import 'package:flutter_router_demo/home/tv_show.dart';
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
    Map<String, dynamic> object = await Parser.parseAssets(path);
    final homeRoot = HomeRoot.fromJson(object);
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
