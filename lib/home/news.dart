import 'package:flutter/material.dart';
import 'package:flutter_router_demo/util/parser.dart';

import 'model/root.dart';

class HomeNewsPage extends StatefulWidget {
  const HomeNewsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNewsPage> {
  HomeItem? _homeItem;

  @override
  void initState() {
    super.initState();
    _loadData("data/home_landing.json");
  }

  void _loadData(String path) async {
    Map<String, dynamic> object = await Parser.parseAssets(path);
    Map<String, dynamic> news = (object['appHomeMainFeed'] as List<dynamic>)[2];
    final item = HomeItem.fromJson(news);
    setState(() {
      _homeItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_homeItem == null) {
      return const SliverToBoxAdapter(
        child: SizedBox(
          width: double.infinity,
          height: 164,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return SliverFixedExtentList(
      itemExtent: 40,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return SizedBox(
            height: 40,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(_homeItem!.value!.list[index].title),
                )),
          );
        },
        childCount: _homeItem!.value!.list.length,
      ),
    );
  }
}
