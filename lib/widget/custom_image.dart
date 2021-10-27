import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  CustomImage(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.ratio,
    required this.placeHolderUri,
    this.errorHolderUri,
  }) : super(key: key);

  double? width;
  double? height;
  double? ratio;
  final String url;
  String placeHolderUri;
  String? errorHolderUri;

  @override
  State<StatefulWidget> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  double? _width;
  double? _height;

  @override
  void initState() {
    super.initState();

    if (widget.ratio != null) {
      if (widget.width != null && widget.width! > 0) {
        _width = widget.width;
        _height = _width! / widget.ratio!;
      } else {
        _height = widget.height;
        _width = _height! * widget.ratio!;
      }
    }

    Image.network(
      widget.url,
      frameBuilder: (context ,child,frame,loaded){
        return FlutterLogo();
      },
      errorBuilder: (context, error, stack) {
        return Image.asset("name");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width!,
      height: _height,
      child: Stack(
        alignment: Alignment.center,
        children: [],
      ),
    );
  }
}
