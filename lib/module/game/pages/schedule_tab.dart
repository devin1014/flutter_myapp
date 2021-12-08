import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/game/pages/schedule_list.dart';
import 'package:flutter_router_demo/util/date.dart';
import 'package:provider/provider.dart';

class ScheduleTabPage extends StatefulWidget {
  const ScheduleTabPage({
    Key? key,
    required this.dates,
    required this.currentIndex,
  }) : super(key: key);

  final List<DateTime> dates;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => _ScheduleTabPageState();
}

class _ScheduleTabPageState extends State<ScheduleTabPage> {
  _ScheduleTabPageState();

  static const _tabItemWidth = 54.0;
  late PageController _pageController;
  late ScrollController _scrollController;
  final GlobalKey _anchorKey = GlobalKey();
  double _tabWidth = 0;
  double _offsetX = 0;
  final dateTagNotifier = ValueNotifier<String>("");
  final pagePositionNotifier = ValueNotifier(0);

  void _onPageChanged() {
    if (_offsetX == 0) {
      final renderBox = _anchorKey.currentContext?.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      _offsetX = (renderBox.size.width + offset.dx - _tabItemWidth) / 2.0;
      _tabWidth = renderBox.size.width;
    }

    void _scroll(ScrollController scroll, double offset) {
      scroll.animateTo(offset, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }

    final index = pagePositionNotifier.value;

    _scroll(_scrollController, index.toDouble() * _tabItemWidth - _offsetX);

    _scroll(_pageController, index.toDouble() * _tabWidth);
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dateTagNotifier.value = "${now.month} ${now.year}";
    pagePositionNotifier.value = widget.currentIndex;
    pagePositionNotifier.addListener(_onPageChanged);
    _pageController = PageController(initialPage: widget.currentIndex);
    _scrollController = ScrollController(initialScrollOffset: widget.currentIndex * _tabItemWidth);
    _scrollController.addListener(() {
      final index = _scrollController.offset ~/ _tabItemWidth;
      final _date = widget.dates.first.add(Duration(days: index));
      final _ym = "${_date.month} ${_date.year}";
      if (dateTagNotifier.value != _ym) {
        dateTagNotifier.value = _ym;
      }
    });
    //_pageController.addListener(() {});
  }

  @override
  void dispose() {
    pagePositionNotifier.removeListener(_onPageChanged);
    pagePositionNotifier.dispose();
    dateTagNotifier.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => dateTagNotifier,
      child: Column(
        children: [
          Consumer<ValueNotifier<String>>(builder: (context, model, child) {
            return _buildCalendarArea(model);
          }),
          _buildDateListArea(),
          _buildPageViewArea(),
        ],
      ),
    );
  }

  final calendarDateTextStyle = const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  Widget _buildCalendarArea(ValueNotifier<String> model) {
    return ChangeNotifierProvider(
      create: (_) => dateTagNotifier,
      child: Consumer<ValueNotifier<String>>(builder: (context, model, child) {
        return SizedBox(
            height: 36,
            child: Stack(
              children: [
                Center(
                  child: Text(model.value, style: calendarDateTextStyle),
                ),
                const Positioned(right: 12, top: 6, child: Icon(Icons.today))
              ],
            ));
      }),
    );
  }

  Widget _buildDateListArea() {
    return ChangeNotifierProvider(
        create: (_) => pagePositionNotifier,
        child: Consumer<ValueNotifier<int>>(builder: (context, model, child) {
          return SizedBox(
            width: double.infinity,
            height: 54,
            child: ListView.builder(
                key: _anchorKey,
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: widget.dates.length,
                itemExtent: _tabItemWidth,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      model.value = index;
                    },
                    child: _buildTimeTab(widget.dates[index], index == model.value),
                  );
                }),
          );
        }));
  }

  Widget _buildPageViewArea() {
    return ChangeNotifierProvider(
      create: (_) => pagePositionNotifier,
      child: Consumer<ValueNotifier<int>>(builder: (context, model, child) {
        return Expanded(
          child: PageView.builder(
              itemCount: widget.dates.length,
              controller: _pageController,
              onPageChanged: (index) {
                model.value = index;
              },
              physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
              itemBuilder: (context, index) => SchedulePage(dateTime: widget.dates[index])),
        );
      }),
    );
  }

  Widget _buildTimeTab(DateTime dateTime, bool selected) {
    final decoration = selected
        ? const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.blue, width: 3)))
        : const BoxDecoration();
    return DecoratedBox(
      decoration: decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            getWeekDay(dateTime.weekday),
            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              dateTime.day.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
