import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_router_demo/home/model/model.dart' as home;

class HomeHeroPage extends StatefulWidget {
  const HomeHeroPage({Key? key}) : super(key: key);

  static const ratio_16_9 = 16 / 9;

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
    await Future.delayed(const Duration(microseconds: 3500), () {});
    String data = await rootBundle.loadString(path);
    final list = parse(data);
    setState(() {
      _list = list;
      // Log.i("hero: ${_list!.map((e) => e.image).toList()}");
    });
  }

  static List<home.Hero> parse(String data) {
    Map<String, dynamic> root = json.decode(data);
    List<dynamic> results = root["results"];
    return results.map((e) => home.Hero.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 196,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_list == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      List<home.Hero> list = _list!;
      return AspectRatio(
          aspectRatio: HomeHeroPage.ratio_16_9,
          child: PageView.builder(
              //physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ExtendedImage.network(
                  list[index].image,
                  fit: BoxFit.cover,
                );
              }));
    }
  }
}
