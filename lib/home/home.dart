import 'package:flutter/material.dart';
import 'package:flutter_router_demo/home/story.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static const ratio_16_9 = 16 / 9;

  final images = [
    "images/home/image1.png",
    "images/home/image2.png",
    "images/home/image3.jpg",
    "images/home/image4.png",
  ];

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
            aspectRatio: HomePage.ratio_16_9,
            child: PageView.builder(
                //physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return Image.asset(widget.images[index], fit: BoxFit.cover);
                })),
        const HomeStoryPage()
      ],
    );
  }
}
