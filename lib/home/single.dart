import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/home.dart';
import 'package:flutter_router_demo/util/logger.dart';
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_router_demo/widget/loading.dart';

import 'model/carousel.dart';
import 'model/root.dart';

class HomeSinglePage extends StatefulWidget {
  const HomeSinglePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSingleState();
}

class _HomeSingleState extends State<HomeSinglePage> {
  HomeItem? _contentItem;

  @override
  void initState() {
    super.initState();
    _loadData("data/home_landing.json");
  }

  void _loadData(String path) async {
    Map<String, dynamic> object = await Parser.parseAssets(path);
    Map<String, dynamic> contents = (object['appHomeMainFeed'] as List<dynamic>)[8];
    final item = HomeItem.fromJson(contents);
    Log.i("item: $item");
    Log.i("item: ${item.value}");
    setState(() {
      _contentItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_contentItem == null) return const LoadingPage.fixHeight(height: 302);
    BaseCarousel carousel = _contentItem!.value!.list[0];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomePage.edgePadding),
      child: Container(
        width: double.infinity,
        height: 302,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
          shape: BoxShape.rectangle,
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2.0)],
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(width: 330, height: 190, child: ExtendedImage.network(carousel.image, fit: BoxFit.cover)),
            Positioned(
              left: 16,
              top: 200,
              right: 16,
              child: Text(
                carousel.title,
                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Positioned(
              bottom: 10,
              right: 16,
              child: Icon(Icons.ios_share, color: Colors.grey, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
