import 'package:flutter/material.dart';

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
    return SliverFixedExtentList(
      itemExtent: 40,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return SizedBox(
            height: 40,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(widget._homeItem.value!.list[index].title),
                )),
          );
        },
        childCount: widget._homeItem.value!.list.length,
      ),
    );
  }
}
