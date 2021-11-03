import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/home.dart';
import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:flutter_router_demo/home/model/root.dart';
import 'package:flutter_router_demo/util/logger.dart';
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_router_demo/widget/loading.dart';

class HomeTvShowPage extends StatefulWidget {
  const HomeTvShowPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTvShowState();
}

class _HomeTvShowState extends State<HomeTvShowPage> {
  HomeItem? _contentItem;

  @override
  void initState() {
    super.initState();
    _loadData("data/home_landing.json");
  }

  void _loadData(String path) async {
    Map<String, dynamic> object = await Parser.parseAssets(path);
    Map<String, dynamic> contents = (object['appHomeMainFeed'] as List<dynamic>)[7];
    final item = HomeItem.fromJson(contents);
    Log.i("item: $item");
    Log.i("info: ${item.value}");
    Log.i("latest: ${(item.value!.list[0])}");
    setState(() {
      _contentItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_contentItem == null) const LoadingPage.fixHeight(380);
    final list = _contentItem!.value!.list;
    return SizedBox(
        height: 380,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: HomePage.edgePadding),
          itemCount: list.length,
          itemBuilder: (context, index) => _buildItem(list[index] as TvShowCarousel),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 16);
          },
        ));
  }

  Widget _buildItem(TvShowCarousel carousel) {
    return Container(
      width: 290,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        shape: BoxShape.rectangle,
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2.0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            child: ExtendedImage.network(carousel.imageLandscape ?? carousel.image),
          ),
          SizedBox(
            height: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  carousel.description,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  carousel.latest?.title ?? "",
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
