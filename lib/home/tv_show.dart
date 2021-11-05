import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/home.dart';
import 'package:flutter_router_demo/home/model/carousel.dart';
import 'package:flutter_router_demo/home/model/root.dart';
import 'package:flutter_router_demo/widget/horizontal_list_view.dart';

class HomeTvShowPage extends StatefulWidget {
  const HomeTvShowPage(HomeItem homeItem, {Key? key})
      : _homeItem = homeItem,
        super(key: key);

  final HomeItem _homeItem;

  @override
  State<StatefulWidget> createState() => _HomeTvShowState();
}

class _HomeTvShowState extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget._homeItem.value!.list;
    return SizedBox(
        height: 380,
        child: HorizontalListViewBuilder.build(
          padding: true,
          itemDividerWidth: HomePage.edgePadding,
          itemCount: list.length,
          itemVisibleCount: 1.25,
          itemBuilder: (context, index) => _buildItem(list[index] as TvShowCarousel),
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
