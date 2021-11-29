import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/home/model/carousel.dart';
import 'package:flutter_router_demo/routers.dart';
import 'package:flutter_router_demo/widget/horizontal_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/root.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage(HomeItem homeItem, {Key? key})
      : _homeItem = homeItem,
        super(key: key);

  final HomeItem _homeItem;

  @override
  State<StatefulWidget> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget._homeItem.value!.list;
    return SizedBox(
        width: double.infinity,
        height: 233,
        child: HorizontalListViewBuilder.build(
          itemCount: list.length,
          padding: true,
          itemDividerWidth: 12,
          itemVisibleCount: 1.25,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "tap: $index");
                if (list[index] is LinkCarousel) {
                  Routers.router.navigateTo(
                    context,
                    Routers.webView,
                    routeSettings: RouteSettings(arguments: list[index].link),
                  );
                } else {
                  Routers.router.navigateTo(context, Routers.videoPlayer);
                }
              },
              child: _buildHomeContent(list[index]),
            );
          },
        ));
    // }
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
