import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({super.key, required this.child});

  /// child widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topLeft,
        constraints: const BoxConstraints(maxWidth: 600),
        child: child,
      ),
    );
  }
}
