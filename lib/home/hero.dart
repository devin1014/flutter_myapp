import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/model/model.dart' as home;
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_router_demo/widget/loading.dart';

class HomeHeroPage extends StatefulWidget {
  const HomeHeroPage({Key? key}) : super(key: key);

  static const ratio_16_9 = 16.0 / 9.0;

  @override
  State<StatefulWidget> createState() => _HomeHeroPageState();
}

class _HomeHeroPageState extends State<HomeHeroPage> {
  List<home.Hero>? _list;

  @override
  void initState() {
    super.initState();
    _loadData("data/hero.json");
  }

  void _loadData(String path) async {
    List<dynamic> result = await Parser.parseAssets(path);
    List<home.Hero> list = result.map((e) => home.Hero.fromJson(e)).toList();
    setState(() {
      _list = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: HomeHeroPage.ratio_16_9,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_list == null) {
      return const LoadingPage.expand();
    } else {
      return PageView.builder(
        itemCount: _list!.length,
        itemBuilder: (context, index) => ExtendedImage.network(_list![index].image, fit: BoxFit.cover),
      );
    }
  }
}
