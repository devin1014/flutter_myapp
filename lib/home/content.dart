import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_router_demo/widget/error.dart';
import 'package:flutter_router_demo/widget/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/root.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  HomeItem? _contentItem;

  @override
  void initState() {
    super.initState();
    _loadData("data/home_landing.json");
  }

  void _loadData(String path) async {
    Map<String, dynamic> object = await Parser.parseAssets(path);
    Map<String, dynamic> contents = (object['appHomeMainFeed'] as List<dynamic>)[0];
    final item = HomeItem.fromJson(contents);
    setState(() {
      _contentItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_contentItem == null) {
      return const LoadingPage.fixHeight(height: 164);
    } else if (_contentItem!.value == null || _contentItem!.value!.list.isEmpty) {
      return const ErrorPage(errMsg: "NoData");
    } else {
      final list = _contentItem!.value!.list;
      return SizedBox(
        width: double.infinity,
        height: 233,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: "tap: $index}");
                },
                child: _buildHomeContent(list[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 40);
            }),
      );
    }
  }

  Widget _buildHomeContent(BaseCarousel carousel) {
    return Container(
        width: 282,
        height: 233,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
          shape: BoxShape.rectangle,
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2.0)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 157,
              child: _buildHomeContentTopView(carousel),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
              child: Text(
                carousel.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            )
          ],
        ));
  }

  Widget _buildHomeContentTopView(BaseCarousel carousel) {
    Widget _buildRunTimeHour(BaseCarousel item) {
      if (item is VideoCarousel) {
        return Row(
          children: [
            const Icon(Icons.play_circle_outline, color: Colors.white, size: 36),
            const SizedBox(width: 10),
            Text(
              item.program.runtimeHours,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        );
      } else if (item is GameCarousel) {
        return const Icon(Icons.play_circle_outline, color: Colors.white, size: 36);
      } else {
        return const SizedBox.shrink();
      }
    }

    return Stack(
      children: [
        ExtendedImage.network(carousel.image, cache: true),
        Positioned(
          left: 10,
          bottom: 10,
          child: _buildRunTimeHour(carousel),
        )
      ],
    );
  }
}
