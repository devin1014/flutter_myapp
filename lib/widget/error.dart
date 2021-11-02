import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
    required this.errMsg,
    this.width,
    this.height,
  }) : super(key: key);

  const ErrorPage.fixHeight({
    Key? key,
    required this.errMsg,
    this.height,
  })  : width = double.infinity,
        super(key: key);

  const ErrorPage.fixWidth({
    Key? key,
    required this.errMsg,
    this.width,
  })  : height = double.infinity,
        super(key: key);

  final double? width;
  final double? height;
  final String errMsg;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(child: Text(errMsg)),
    );
  }
}
