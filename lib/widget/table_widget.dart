import 'package:flutter/material.dart';

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
  const TableWidget.builder({
    Key? key,
    required this.rowSize,
    required this.columnSize,
    required this.itemHeight,
    required this.itemWidth,
    this.tableView,
    required this.itemBuilder,
    this.labelBuilder,
  })  : rowLabelWidth = itemWidth,
        rowLabelHeight = itemHeight,
        columnLabelWidth = itemWidth,
        columnLabelHeight = itemHeight,
        super(key: key);

  const TableWidget.labelBuilder({
    Key? key,
    required this.rowSize,
    required this.columnSize,
    required this.rowLabelWidth,
    required this.rowLabelHeight,
    required this.columnLabelWidth,
    required this.columnLabelHeight,
    this.tableView,
    required this.itemBuilder,
    this.labelBuilder,
  })  : itemWidth = rowLabelWidth,
        itemHeight = columnLabelHeight,
        super(key: key);

  final int rowSize;
  final int columnSize;
  final double itemWidth;
  final double itemHeight;
  final double rowLabelWidth;
  final double rowLabelHeight;
  final double columnLabelWidth;
  final double columnLabelHeight;
  final Widget? tableView;
  final ItemWidgetBuilder itemBuilder;
  final ItemWidgetBuilder? labelBuilder;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final Map<int, ScrollController> controllerManager = {};

  bool scrolling = false;
  double currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final ScrollController horScrollController = ScrollController();
    final ScrollController verScrollController = ScrollController();
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (isHorizontalScrolling(notification.metrics.axisDirection) && notification is ScrollUpdateNotification) {
          horScrollController.jumpTo(notification.metrics.pixels);
        } else if (isVerticalScrolling(notification.metrics.axisDirection) &&
            notification is ScrollUpdateNotification) {
          verScrollController.jumpTo(notification.metrics.pixels);
        }
        return false;
      },
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                width: widget.columnLabelWidth,
                height: widget.rowLabelHeight,
                child: widget.tableView,
              ),
              Expanded(child: _buildColumnLabel(verScrollController)),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                _buildRowLabel(horScrollController),
                Expanded(child: _buildTable()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowLabel(ScrollController scrollController) {
    return SizedBox(
      height: widget.rowLabelHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          controller: scrollController,
          itemExtent: widget.rowLabelWidth,
          itemCount: widget.rowSize,
          itemBuilder: (context, columnIndex) => widget.labelBuilder!(context, -1, columnIndex)),
    );
  }

  Widget _buildColumnLabel(ScrollController scrollController) {
    return SizedBox(
        width: widget.columnLabelWidth,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          controller: scrollController,
          itemExtent: widget.columnLabelHeight,
          itemCount: widget.columnSize,
          itemBuilder: (context, rowIndex) => widget.labelBuilder!(context, rowIndex, -1),
        ));
  }

  bool isHorizontalScrolling(AxisDirection axis) => axis == AxisDirection.left || axis == AxisDirection.right;

  bool isVerticalScrolling(AxisDirection axis) => axis == AxisDirection.up || axis == AxisDirection.down;

  Widget _buildTable() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: null,
      itemExtent: widget.itemHeight,
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
            widget.itemWidth,
            widget.itemHeight,
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        //FIXME: this code hus bug!
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
