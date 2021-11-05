import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/home.dart';
import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:flutter_router_demo/widget/horizontal_list_view.dart';

import 'model/root.dart';

class HomeCardPage extends StatefulWidget {
  const HomeCardPage(HomeItem homeItem, {Key? key})
      : _homeItem = homeItem,
        super(key: key);

  final HomeItem _homeItem;

  @override
  State<StatefulWidget> createState() => _HomeCardPageState();
}

class _HomeCardPageState extends State<HomeCardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget._homeItem.value!.list;
    return SizedBox(
      height: 220,
      child: HorizontalListViewBuilder.build(
        padding: true,
        itemVisibleCount: 2,
        itemCount: list.length,
        itemDividerWidth: HomePage.edgePadding,
        itemBuilder: (context, index) => _buildItem(list[index] as CardCarousel),
      ),
    );
  }

  Widget _buildItem(CardCarousel carousel) {
    return SizedBox(
      width: 160,
      child: Stack(
        children: [
          ExtendedImage.network(carousel.image),
          Container(
            color: const Color(0xaaafafaf),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              carousel.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
