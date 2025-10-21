import 'package:flutter/material.dart';

class FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double? minHeight;
  final double? maxHeight;

  FixedHeaderDelegate({required this.child, this.minHeight, this.maxHeight});

  @override
  double get minExtent => minHeight ?? 140;

  @override
  double get maxExtent => maxHeight ?? 140;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      elevation: overlapsContent ? 4 : 0,
      color: Colors.transparent,
      child: SizedBox.expand(child: child),
    );
  }

  @override
  bool shouldRebuild(FixedHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}
