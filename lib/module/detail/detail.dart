import 'package:flutter/material.dart';
import 'package:flutter_router_demo/util/logger.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ScrollController scrollController = ScrollController();
  final anchorViewNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScrollChanged);
    Future.delayed(const Duration(seconds: 5), () {
      anchorViewNotifier.value = true;
    });
  }

  @override
  void dispose() {
    anchorViewNotifier.dispose();
    scrollController.removeListener(_onScrollChanged);
    super.dispose();
  }

  void _onScrollChanged() {
    // Log.d("onScroll: ${scrollController.position.pixels}");
    //TODO: should get appBar height dynamic.
    anchorViewNotifier.value = scrollController.position.pixels > 160;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => anchorViewNotifier,
        child: Stack(
          children: [
            NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                Log.w("innerBoxIsScrolled: $innerBoxIsScrolled");
                //TODO: set value here, state error! notifier when setState or markDirty.
                //TODO: check code.
                // anchorViewNotifier.value = innerBoxIsScrolled;
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      pinned: true,
                      title: const Text("Detail"),
                      expandedHeight: 220,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                            width: double.infinity,
                            color: Colors.black,
                            child: const Center(
                              child: Icon(Icons.play_circle_outline, color: Colors.white, size: 64),
                            )),
                      ),
                    ),
                  )
                ];
              },
              body: Builder(builder: (buildContext) {
                return CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(buildContext)),
                    SliverToBoxAdapter(
                      child: Column(children: [
                        Container(
                            height: 56,
                            color: Colors.blueGrey,
                            alignment: Alignment.center,
                            child: const Text("Title")),
                        Container(
                            height: 56,
                            color: Colors.greenAccent,
                            alignment: Alignment.center,
                            child: const Text("Description")),
                      ]),
                    ),
                    SliverFixedExtentList(
                      itemExtent: 64,
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: ListTile(title: Text(index.toString())),
                          );
                        },
                        childCount: 20,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Positioned(
              right: 12,
              bottom: 24,
              child: Consumer<ValueNotifier<bool>>(builder: (context, model, child) {
                return AnimatedOpacity(
                  opacity: model.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(width: 164, height: 96, color: Colors.red),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
