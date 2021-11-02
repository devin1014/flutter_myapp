import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_router_demo/home/model/model.dart';
import 'package:flutter_router_demo/util/image.dart';

class HomeStoryPage extends StatefulWidget {
  const HomeStoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeStoryPageState();
}

class _HomeStoryPageState extends State<HomeStoryPage> {
  static const edgeHorPadding = 12.0;
  List<Story>? _storyList;

  @override
  void initState() {
    super.initState();
    _loadData("data/story_167.json");
  }

  void _loadData(String path) async {
    await Future.delayed(const Duration(microseconds: 3500), () {});
    String data = await rootBundle.loadString(path);
    List<dynamic> result = json.decode(data);
    final mapped = result.map((e) => Story.fromJson(e));
    setState(() {
      _storyList = mapped.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 164,
      alignment: Alignment.centerLeft,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_storyList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: edgeHorPadding),
        itemCount: _storyList!.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 124,
            height: 164,
            child: InkWell(
              onTap: () {
                //TODO:
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ExtendedImage.network(ImageUtil.getStory(_storyList![index].image)),
                  Container(
                    color: Colors.yellow,
                    width: 124,
                    height: 48,
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      _storyList![index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: edgeHorPadding);
        },
      );
    }
  }
}
