import 'package:flutter/material.dart';

class AutoScrollController {
  double _autoScrollPosition = 0;

  autoScrollPosition(double autoScrollPosition) =>
      _autoScrollPosition = autoScrollPosition;

  final ScrollController scrollController = ScrollController();

  final List<GlobalKey> keys;

  AutoScrollController(this.keys);

  void scrollToKeyByKeyIndex(int index, BuildContext context) {
    _scrollUtil(keys[index], context);
  }

  _scrollUtil(GlobalKey key, BuildContext context) async {
    double dy = PositionsUtils.getPositionByKey(key, 0);

    if (dy >= scrollController.position.maxScrollExtent)
      dy = scrollController.position.maxScrollExtent;

    await scrollController.animateTo(dy - _autoScrollPosition,
        duration: Duration(milliseconds: 1000), curve: Curves.decelerate);
  }
}

class AutoScrollWidget extends StatefulWidget {
  final AutoScrollController controller;
  final List<GlobalKey> keys;
  final Widget child;

  AutoScrollWidget({Key key, this.controller, this.keys, this.child})
      : super(key: key);

  @override
  _AutoScrollWidgetState createState() => _AutoScrollWidgetState();
}

class _AutoScrollWidgetState extends State<AutoScrollWidget> {
  final GlobalKey _autoScrollKey = GlobalKey();

  _getAutoScrollPosition() {
    widget.controller
        .autoScrollPosition(PositionsUtils.getPositionByKey(_autoScrollKey, 0));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _getAutoScrollPosition();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: widget.controller.scrollController,
        child: Container(key: _autoScrollKey, child: widget.child));
  }
}

class PositionsUtils {
  static double getPositionByKey(GlobalKey key, double currentPosition) {
    double dyPosition;

    final RenderBox renderBox = key.currentContext.findRenderObject();

    dyPosition = renderBox.localToGlobal(Offset(0, currentPosition)).dy;

    return dyPosition;
  }
}

class SizesUtils {
  static double getHeight(GlobalKey key) {
    final RenderBox renderBoxRed = key.currentContext.findRenderObject();
    final size = renderBoxRed.size;
    return size.height;
  }
}
