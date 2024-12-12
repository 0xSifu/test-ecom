import 'package:flutter/material.dart';

class BottomNavModel {
  /// Icon that will be use as selected icon in the BottomNavigationBarItem
  final Widget selectedIcon;

  /// Icon that will be use as unselected icon in the BottomNavigationBarItem
  final Widget unselectedIcon;

  /// BottomNavigationBarItem label
  final String label;

  /// Widget that will be use to show the active page
  final Widget Function() pageWidget;

  // url
  final String url;

  BottomNavModel({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.pageWidget,
    required this.url,
  });
}
