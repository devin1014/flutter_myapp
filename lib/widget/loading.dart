import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  const LoadingPage.fixHeight({
    Key? key,
    this.height,
  })  : width = double.infinity,
        super(key: key);

  const LoadingPage.fixWidth({
    Key? key,
    this.width,
  })  : height = double.infinity,
        super(key: key);

  const LoadingPage.expand({
    Key? key,
  })  : width = double.infinity,
        height = double.infinity,
        super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
