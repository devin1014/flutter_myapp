import 'package:flutter/material.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int row, int column);

class TableWidget extends StatefulWidget {
  const TableWidget.builder({
    Key? key,
    required this.rowSize,
    required this.rowHeight,
    required this.columnSize,
    required this.columnWidth,
    required this.builder,
  }) : super(key: key);

  final int rowSize;
  final double rowHeight;
  final int columnSize;
  final double columnWidth;
  final ItemWidgetBuilder builder;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final Map<int, ScrollController> controllerManager = {};

  bool scrolling = false;
  double currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: null,
      itemExtent: widget.rowHeight,
      itemCount: widget.columnSize,
      itemBuilder: (context, rowIndex) {
        final ScrollController controller = ScrollController(initialScrollOffset: currentPosition);
        return NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              // Log.i("ScrollStartNotification: ${notification.metrics.pixels}");
              // Log.i("ControllerManager: ${controllerManager.length}");
            } else if (notification is ScrollEndNotification) {
              // Log.i("ScrollEndNotification: ${notification.metrics.pixels}");
              // Log.i("ControllerManager: ${controllerManager.length}");
            } else if (notification is ScrollUpdateNotification) {
              // Log.d("ScrollUpdateNotification: ${notification.metrics.pixels}");
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
            widget.builder,
            controllerManager,
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
    this.builder,
    this.controllerManager,
    this.controller,
  );

  final int row;
  final double itemWidth;
  final double itemHeight;
  final int itemCount;
  final ItemWidgetBuilder builder;
  final ScrollController controller;
  final Map<int, ScrollController> controllerManager;

  @override
  State<StatefulWidget> createState() => _RowState();
}

class _RowState extends State<_Row> {
  bool scrolling = false;

  @override
  void initState() {
    super.initState();
    widget.controllerManager[widget.row] = widget.controller;
  }

  @override
  void dispose() {
    widget.controllerManager.remove(widget.row);
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
