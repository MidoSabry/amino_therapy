import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/component/layout_builder/custom_layout_builder.dart';
import '../widgets/parent_bottom_nav.dart';


class ParentScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final int? index;
  const ParentScreen({super.key, this.index, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return CustomLayoutBuilder(
      bottomNavigationBar: CustomBottomNavigation(
        navigationShell: navigationShell,
      ),
      mobileBody: navigationShell,
    );
  }
}
