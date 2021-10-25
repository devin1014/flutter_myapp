import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const ratio_16_9 = 16 / 9;

  static final images = [
    "images/home/image1.png",
    "images/home/image2.png",
    "images/home/image3.jpg",
    "images/home/image4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 160,
          child: PageView.builder(
              physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.red,
                  width: 200,
                  child: Image.asset(images[index], fit: BoxFit.cover),
                );
              })),
    );
  }
}
