import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/home/home.dart';
import 'package:flutter_router_demo/routers.dart';

import 'model/carousel.dart';
import 'model/root.dart';

class HomeSinglePage extends StatefulWidget {
  const HomeSinglePage(HomeItem homeItem, {Key? key})
      : _homeItem = homeItem,
        super(key: key);

  final HomeItem _homeItem;

  @override
  State<StatefulWidget> createState() => _HomeSingleState();
}

class _HomeSingleState extends State<HomeSinglePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BaseCarousel carousel = widget._homeItem.value!.list[0];
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
        child: InkWell(
          onTap: () {
            if (carousel is LinkCarousel) {
              Routers.router.navigateTo(
                context,
                Routers.webView,
                routeSettings: RouteSettings(arguments: carousel.link),
              );
            }
          },
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
      ),
    );
  }
}
