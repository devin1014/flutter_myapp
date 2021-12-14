import 'package:flutter/material.dart';
import 'package:flutter_router_demo/util/logger.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int row, int column);

/// * ——  ——  ——  ——  ——  ——  *
/// | 1x1 1x2 1x3 1x4 1x5 1x6 |
/// | 2x1 2x2 2x3 2x4 2x5 2x6 |
/// | 3x1 3x2 3x3 3x4 3x5 3x6 |
/// | 4x1 4x2 4x3 4x4 4x5 4x6 |
/// | 5x1 5x2 5x3 5x4 5x5 5x6 |
/// * ——  ——  ——  ——  ——  ——  *
/// rowSize: 6
/// columnSize: 5
class TableWidget extends StatefulWidget {
  const TableWidget.itemBuilder({
    Key? key,
    required this.rowSize,
    required this.rowHeight,
    required this.columnSize,
    required this.columnWidth,
    required this.itemBuilder,
    this.rowLabelBuilder,
  }) : super(key: key);

  final int rowSize;
  final double rowHeight;
  final int columnSize;
  final double columnWidth;
  final ItemWidgetBuilder itemBuilder;
  final ItemWidgetBuilder? rowLabelBuilder;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final Map<int, ScrollController> controllerManager = {};

  bool scrolling = false;
  double currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final hasRowLabel = widget.rowLabelBuilder != null;
    if (hasRowLabel) {
      return _buildRowLabel();
    } else {
      return _buildTable();
    }
  }

  Widget _buildRowLabel() {
    ScrollController scrollController = ScrollController();
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        Log.i("onNotification: ${notification.metrics.axisDirection}");
        final handled = isHorizontalScrolling(notification.metrics.axisDirection);
        if (handled && notification is ScrollUpdateNotification) {
          scrollController.jumpTo(notification.metrics.pixels);
        }
        return handled;
      },
      child: Column(
        children: [
          SizedBox(
              height: widget.rowHeight,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: scrollController,
                  itemExtent: widget.columnWidth,
                  itemCount: widget.rowSize,
                  itemBuilder: (context, columnIndex) {
                    return SizedBox(
                      width: widget.columnWidth,
                      height: widget.rowHeight,
                      child: widget.rowLabelBuilder!(context, -1, columnIndex),
                    );
                  })),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  bool isHorizontalScrolling(AxisDirection axis) => axis == AxisDirection.left || axis == AxisDirection.right;

  bool isVerticalScrolling(AxisDirection axis) => axis == AxisDirection.up || axis == AxisDirection.down;

  Widget _buildTable() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: null,
      itemExtent: widget.rowHeight,
      itemCount: widget.columnSize,
      itemBuilder: (context, rowIndex) {
        final ScrollController controller = ScrollController(initialScrollOffset: currentPosition);
        return NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              currentPosition = notification.metrics.pixels;
              for (var _controller in controllerManager.values) {
                if (_controller.offset != notification.metrics.pixels) {
                  _controller.jumpTo(notification.metrics.pixels);
                }
              }
            }
            return false;
          },
          child: _Row(
            rowIndex,
            widget.columnWidth,
            widget.rowHeight,
            widget.rowSize,
            widget.itemBuilder,
            controller,
          ),
        );
      },
    );
  }
}

class _Row extends StatefulWidget {
  const _Row(
    this.row,
    this.itemWidth,
    this.itemHeight,
    this.itemCount,
    ItemWidgetBuilder this.builder,
    this.controller,
  );

  final int row;
  final double itemWidth;
  final double itemHeight;
  final int itemCount;
  final Function builder;
  final ScrollController controller;

  @override
  State<StatefulWidget> createState() => _RowState();
}

class _RowState extends State<_Row> {
  bool scrolling = false;

  @override
  void initState() {
    super.initState();
    findTabletState(context).controllerManager[widget.row] = widget.controller;
  }

  @override
  void dispose() {
    findTabletState(context).controllerManager.remove(widget.row);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        final state = findTabletState(context);
        bool notifyParent = (!state.scrolling && !scrolling) || (state.scrolling && scrolling);
        if (notification is ScrollStartNotification && !state.scrolling && !scrolling) {
          scrolling = true;
          state.scrolling = scrolling;
        } else if (notification is ScrollEndNotification && state.scrolling && scrolling) {
          scrolling = false;
          state.scrolling = scrolling;
        }
        return !notifyParent;
      },
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: widget.controller,
        itemExtent: widget.itemWidth,
        itemCount: widget.itemCount,
        itemBuilder: (context, columnIndex) {
          return SizedBox(
            width: widget.itemWidth,
            height: widget.itemHeight,
            child: widget.builder(context, widget.row, columnIndex),
          );
        },
      ),
    );
  }

  _TableWidgetState findTabletState(BuildContext context) {
    final type = context.findAncestorStateOfType();
    if (type is _TableWidgetState) {
      return type;
    } else {
      return findTabletState(type!.context);
    }
  }
}
