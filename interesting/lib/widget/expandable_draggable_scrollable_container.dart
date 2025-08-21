import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableDraggableScrollableContainer extends StatelessWidget {
  final Widget child;

  const ExpandableDraggableScrollableContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ScrollConfiguration(
        behavior: _DragScrollBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: child,
          ),
        ),
      ),
    );
  }
}

class HorizontalExpandableDraggableScrollableContainer extends StatelessWidget {
  final Widget child;

  const HorizontalExpandableDraggableScrollableContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ScrollConfiguration(
        behavior: _DragScrollBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: child,
        ),
      ),
    );
  }
}

class VerticalExpandableDraggableScrollableContainer extends StatelessWidget {
  final Widget child;

  const VerticalExpandableDraggableScrollableContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ScrollConfiguration(
        behavior: _DragScrollBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: child,
        ),
      ),
    );
  }
}

class _DragScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
  };
}
