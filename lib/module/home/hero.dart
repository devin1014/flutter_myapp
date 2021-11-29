import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/home/model/carousel.dart';

class HomeHeroPage extends StatefulWidget {
  static const ratio_16_9 = 16.0 / 9.0;

  const HomeHeroPage(list, {Key? key})
      : _list = list,
        super(key: key);

  final List<BaseCarousel> _list;

  @override
  State<StatefulWidget> createState() => _HomeHeroPageState();
}

class _HomeHeroPageState extends State<HomeHeroPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: HomeHeroPage.ratio_16_9,
        child: PageView.builder(
          itemCount: widget._list.length,
          itemBuilder: (context, index) => ExtendedImage.network(_getImage(widget._list[index]), fit: BoxFit.cover),
        ));
  }

  String _getImage(BaseCarousel carousel) {
    return carousel.hero?.image ?? carousel.image;
  }
}
