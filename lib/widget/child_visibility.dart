import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// Force size child widget width.
///
class ChildVisibility extends SingleChildRenderObjectWidget {
  const ChildVisibility({
    Key? key,
    required Widget child,
    this.maxWidth = double.infinity,
    this.screenVisibleCount = 2.5,
    this.padding = 0,
    this.separator = 0,
  }) : super(key: key, child: child);

  final double screenVisibleCount;
  final double padding;
  final double separator;
  final double maxWidth;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderChildVisibility(context, this);
}

class _RenderChildVisibility extends RenderShiftedBox {
  _RenderChildVisibility(
    context,
    this._flexLayout, {
    RenderBox? child,
  })  : _screenWidth = MediaQuery.of(context).size.width,
        super(child);

  final double _screenWidth;
  final ChildVisibility _flexLayout;

  @override
  void performLayout() {
    final maxWidth =
        constraints.maxWidth == double.infinity ? min(_screenWidth, _flexLayout.maxWidth) : constraints.maxWidth;
    double width = (maxWidth - _flexLayout.padding - _flexLayout.separator * _flexLayout.screenVisibleCount) /
        _flexLayout.screenVisibleCount;
    double height = constraints.maxHeight;
    child!.layout(
      BoxConstraints.tightFor(width: width, height: height),
      parentUsesSize: true,
    );
    size = constraints.constrain(Size(child!.size.width, child!.size.height));
  }
}
