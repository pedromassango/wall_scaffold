import 'package:flutter/material.dart';
import 'package:wall_scaffold/src/wall_item.dart';
import 'package:wall_scaffold/src/wall_options_content.dart';

class WallContent extends StatelessWidget {
  final Widget content;
  final List<WallItem> items;
  final int initialIndex;
  final int currentIndex;
  final Function(int) onItemSelected;
  final Color selectedItemColor;
  final Color itemColor;
  final Color backgroundColor;

  WallContent._({
    this.content,
    this.items,
    this.initialIndex,
    this.currentIndex,
    this.onItemSelected,
    this.itemColor,
    this.selectedItemColor,
    this.backgroundColor,
  }) : assert(content != null || items != null);

  //TODO(pedromassango): find a way to provide a custom wall content
  //TODO(pedromassango): find a way to open/close drawer when using a custom wall content
/*  factory WallContent.custom({
    @required Widget content,
    Color backgroundColor,
  }) {
    assert(content != null);
    return WallContent._(
      content: content,
      backgroundColor: backgroundColor,
    );
  }*/

  factory WallContent.withOptions({
    @required List<WallItem> items,
    int initialIndex,
    @required int currentIndex,
    @required Function(int) onItemSelected,
    Color itemColor,
    Color selectedItemColor,
    Color backgroundColor,
  }) {
    return WallContent._(
      items: items,
      initialIndex: initialIndex,
      currentIndex: currentIndex,
      onItemSelected: onItemSelected,
      itemColor: itemColor,
      selectedItemColor: selectedItemColor,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _backgroundColor =
        backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    final child = content ??
        WallOptionsContent(
          items: items,
          initialIndex: initialIndex,
          currentIndex: currentIndex,
          onItemSelected: onItemSelected,
          itemColor: itemColor,
          selectedItemColor: selectedItemColor,
        );
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.constrainHeight(),
          width: constraints.constrainWidth(),
          color: _backgroundColor,
          child: child,
        );
      },
    );
  }
}