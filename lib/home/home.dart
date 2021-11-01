import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/model/root.dart';
import 'package:flutter_router_demo/home/news.dart';
import 'package:flutter_router_demo/util/logger.dart';
import 'package:flutter_router_demo/util/parser.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadData("data/home_landing.json");
  }

  HomeItem? _newItem;

  void _loadData(String path) async {
    Future.delayed(const Duration(seconds: 2), () {});
    Map<String, dynamic> object = await Parser.parseAssets(path);
    // final homeRoot = HomeRoot.fromJson(object);
    // Log.i("list: ${homeRoot.list.length}");
    // Log.i("item: ${homeRoot.list[0]}");
    Map<String, dynamic> news = (object['appHomeMainFeed'] as List<dynamic>)[2];
    final newsItem = HomeItem.fromJson(news);
    // CarouselInfo result = CarouselInfo.fromJson(news['value']);
    Log.i("size: ${newsItem.value?.list.length}");
    for (var element in newsItem.value!.list) {
      Log.i("e: $element}");
    }
    setState(() {
      _newItem = newsItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeNewsPage(_newItem);
  }
}
