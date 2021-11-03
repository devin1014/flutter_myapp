import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_router_demo/widget/loading.dart';

import 'model/root.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  HomeItem? _contentItem;

  @override
  void initState() {
    super.initState();
    _loadData("data/home_landing.json");
  }

  void _loadData(String path) async {
    Map<String, dynamic> object = await Parser.parseAssets(path);
    Map<String, dynamic> contents = (object['appHomeMainFeed'] as List<dynamic>)[5];
    final item = HomeItem.fromJson(contents);
    setState(() {
      _contentItem = item;
    });
  }

  static const _edgePadding = EdgeInsets.symmetric(horizontal: 12);

  @override
  Widget build(BuildContext context) {
    if (_contentItem == null) return const LoadingPage.fixHeight(196);
    final list = _contentItem!.value!.list;
    return Container(
      height: 530,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            padding: _edgePadding,
            alignment: Alignment.centerLeft,
            child: const Text("Watch TV 24/7", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          const Padding(padding: _edgePadding, child: Divider(color: Colors.white)),
          const Expanded(child: Center(child: FlutterLogo(size: 64))),
          const Padding(
            padding: _edgePadding,
            child: Text("LIVE", style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: _edgePadding,
            child: Text("GameTime Live", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: _edgePadding,
            child: Text("On now", style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
          const SizedBox(height: 24),
          _buildTvProgram(list[0] as VideoCarousel),
          _buildTvProgram(list[1] as VideoCarousel),
        ],
      ),
    );
  }

  Widget _buildTvProgram(VideoCarousel carousel) {
    return SizedBox(
      width: double.infinity,
      height: 74,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: ExtendedImage.network(carousel.image, fit: BoxFit.cover),
          ),
          const Positioned(
            left: 12,
            bottom: 12,
            child: Icon(Icons.play_circle_outline, color: Colors.white, size: 24),
          ),
          Positioned(
            left: 124,
            top: 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                carousel.title,
                style: const TextStyle(fontSize: 14, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
