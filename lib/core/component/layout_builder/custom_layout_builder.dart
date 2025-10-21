import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/constants/dimensions.dart';

class CustomLayoutBuilder extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? webBody;
  final Widget? desktopBody;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  const CustomLayoutBuilder({
    super.key,
    required this.mobileBody,
    this.tabletBody,
    this.webBody,
    this.desktopBody,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: Platform.isAndroid ? true : false,
      child: Scaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < DimensionsConstants.mobileScreenWidth) {
              return mobileBody;
            } else if (constraints.maxWidth <
                DimensionsConstants.tabletScreenWidth) {
              return tabletBody ?? mobileBody;
            } else if (constraints.maxWidth <
                DimensionsConstants.desktopScreenWidth) {
              return desktopBody ?? mobileBody;
            } else {
              // return webBody ?? mobileBody;
              return mobileBody;
            }
          },
        ),
      ),
    );
  }
}
