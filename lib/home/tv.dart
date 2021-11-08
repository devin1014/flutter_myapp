import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/common/db/provider/model_provider.dart';
import 'package:flutter_router_demo/home/model/carousel.dart';

import 'model/root.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage(HomeItem homeItem, {Key? key})
      : _homeItem = homeItem,
        super(key: key);

  final HomeItem _homeItem;

  @override
  State<StatefulWidget> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();

    Future.sync(() async {
      final provider = SingleProgramProvider();
      await provider.open();
      final list = widget._homeItem.value!.list;
      for (var element in list) {
        provider.insert((element as VideoCarousel).program);
      }
    });
  }

  static const _edgePadding = EdgeInsets.symmetric(horizontal: 12);

  @override
  Widget build(BuildContext context) {
    final list = widget._homeItem.value!.list;
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
