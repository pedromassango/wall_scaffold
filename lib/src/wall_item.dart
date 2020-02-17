import 'package:flutter/material.dart';

class WallItem {
  final Text title;
  final Widget icon;

  const WallItem({
    @required this.title,
    this.icon,
  }) : assert(title != null);
}