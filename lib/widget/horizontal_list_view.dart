import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/widget/child_visibility.dart';

class HorizontalListView extends BoxScrollView {
  HorizontalListView.separated({
    Key? key,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    bool padding = true,
    required IndexedWidgetBuilder itemBuilder,
    double itemDividerWidth = 0.0,
    double itemVisibleCount = 2.5,
    required int itemCount,
    double parentMaxWidth = double.infinity,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  })  : itemExtent = null,
        prototypeItem = null,
        childrenDelegate = SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            final Widget widget;
            if (index.isEven) {
              widget = ChildVisibility(
                  child: itemBuilder(context, itemIndex),
                  screenVisibleCount: itemVisibleCount,
                  padding: padding ? itemDividerWidth : 0.0,
                  separator: itemDividerWidth,
                  maxWidth: parentMaxWidth);
            } else {
              widget = SizedBox(width: itemDividerWidth);
            }
            return widget;
          },
          childCount: _computeActualChildCount(itemCount),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (Widget _, int index) {
            return index.isEven ? index ~/ 2 : null;
          },
        ),
        super(
          key: key,
          scrollDirection: Axis.horizontal,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: EdgeInsets.symmetric(horizontal: padding ? itemDividerWidth : 0.0),
          cacheExtent: cacheExtent,
          semanticChildCount: itemCount,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
        );

  final double? itemExtent;

  final Widget? prototypeItem;

  final SliverChildDelegate childrenDelegate;

  @override
  Widget buildChildLayout(BuildContext context) {
    if (itemExtent != null) {
      return SliverFixedExtentList(
        delegate: childrenDelegate,
        itemExtent: itemExtent!,
      );
    } else if (prototypeItem != null) {
      return SliverPrototypeExtentList(
        delegate: childrenDelegate,
        prototypeItem: prototypeItem!,
      );
    }
    return SliverList(delegate: childrenDelegate);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('itemExtent', itemExtent, defaultValue: null));
  }

  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}

class HorizontalListViewBuilder {
  HorizontalListViewBuilder._();

  static Widget build({
    Key? key,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    bool padding = true,
    required IndexedWidgetBuilder itemBuilder,
    double itemDividerWidth = 0.0,
    double itemVisibleCount = 2.5,
    required int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => HorizontalListView.separated(
              key: key,
              reverse: reverse,
              controller: controller,
              primary: primary,
              physics: physics,
              shrinkWrap: shrinkWrap,
              padding: padding,
              itemBuilder: itemBuilder,
              itemDividerWidth: itemDividerWidth,
              itemVisibleCount: itemVisibleCount,
              itemCount: itemCount,
              parentMaxWidth: constraints.maxWidth,
              cacheExtent: cacheExtent,
              dragStartBehavior: dragStartBehavior,
              keyboardDismissBehavior: keyboardDismissBehavior,
              restorationId: restorationId,
              clipBehavior: clipBehavior,
            ));
  }
}
