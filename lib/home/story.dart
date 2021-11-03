import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/model/model.dart';
import 'package:flutter_router_demo/util/image.dart';
import 'package:flutter_router_demo/util/parser.dart';
import 'package:flutter_router_demo/widget/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeStoryPage extends StatefulWidget {
  const HomeStoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeStoryPageState();
}

class _HomeStoryPageState extends State<HomeStoryPage> {
  static const edgeHorPadding = 12.0;
  static const widgetHeight = 164.0;
  List<Story>? _storyList;

  @override
  void initState() {
    super.initState();
    _loadData("data/story_167.json");
  }

  void _loadData(String path) async {
    List<dynamic> result = await Parser.parseAssets(path);
    final list = result.map((e) => Story.fromJson(e)).toList();
    setState(() {
      _storyList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_storyList == null) {
      return const LoadingPage.fixHeight(height: widgetHeight);
    } else {
      return SizedBox(
        height: widgetHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: edgeHorPadding),
          itemCount: _storyList!.length,
          itemBuilder: (context, index) => _buildItem(_storyList![index]),
          separatorBuilder: (context, index) => const SizedBox(width: edgeHorPadding),
        ),
      );
    }
  }

  Widget _buildItem(Story story) {
    return SizedBox(
        width: 124,
        height: widgetHeight,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ExtendedImage.network(ImageUtil.getStory(story.image), fit: BoxFit.cover),
            Container(
              color: Colors.yellow,
              height: 48,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(6),
              child: Text(story.name, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "click: ${story.name}");
              },
              child: const SizedBox.expand(),
            )
          ],
        ));
  }
}
