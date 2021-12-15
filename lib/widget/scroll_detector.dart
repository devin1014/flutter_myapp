import 'package:flutter/material.dart';

typedef ScrollDetectorListener = void Function(double scrollX, double scrollY);

class ScrollDetector extends StatelessWidget {
  const ScrollDetector({Key? key, this.listener, this.deltaListener, required this.child}) : super(key: key);

  static const deltaOffset = 1;
  final Widget child;
  final ScrollDetectorListener? listener;
  final ScrollDetectorListener? deltaListener;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double touchDownX = 0.0;
      double touchDownY = 0.0;
      double currentX = 0.0;
      double currentY = 0.0;
      return Listener(
          onPointerDown: (event) {
            // Log.i("onPointerDown: ${event.position}");
            touchDownX = currentX = event.position.dx;
            touchDownY = currentY = event.position.dy;
          },
          onPointerMove: (event) {
            // Log.d("onPointerMove: ${event.position}");
            bool notify = false;
            final deltaX = (event.position.dx - currentX);
            if (deltaX.abs() > deltaOffset) {
              currentX = event.position.dx;
              notify = true;
            }
            final deltaY = (event.position.dy - currentY);
            if (deltaY.abs() > deltaOffset) {
              currentY = event.position.dy;
              notify = true;
            }
            if (notify) {
              listener?.call((event.position.dx - touchDownX), (event.position.dy - touchDownY));
              deltaListener?.call(deltaX, deltaY);
            }
          },
          onPointerUp: (event) {
            // Log.i("onPointerUp: ${event.position}");
            touchDownX = currentX = 0;
            touchDownY = currentY = 0;
          },
          onPointerCancel: (event) {
            // Log.w("onPointerCancel: ${event.position}");
            touchDownX = currentX = 0;
            touchDownY = currentY = 0;
          },
          child: child);
    });
  }
}
