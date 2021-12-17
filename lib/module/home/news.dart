import 'package:flutter/material.dart';
import 'package:flutter_router_demo/router/routers.dart';

import 'model/carousel.dart';
import 'model/root.dart';

class HomeNewsPage extends StatefulWidget {
  const HomeNewsPage(HomeItem homeItem, {Key? key})
      : _homeItem = homeItem,
        super(key: key);

  final HomeItem _homeItem;

  @override
  State<StatefulWidget> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNewsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget._homeItem.value!.list;
    return SliverFixedExtentList(
      itemExtent: 40,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            onTap: () {
              if (list[index] is LinkCarousel) {
                Routers.navigateTo(context, path: Routers.webView, query: "url=${list[index].link}");
              }
            },
            child: SizedBox(
              height: 40,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(list[index].title),
                  )),
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }
}
