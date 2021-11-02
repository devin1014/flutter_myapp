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
    Future.delayed(const Duration(seconds: 2), () {});
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
      return const SizedBox(
        width: double.infinity,
        height: 164,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return ListView.builder(
        itemCount: _homeItem!.value!.list.length,
        itemExtent: 40,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 40,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(_homeItem!.value!.list[index].title),
                )),
          );
        });
  }
}
