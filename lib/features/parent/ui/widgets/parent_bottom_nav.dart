import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/data/constants/app_colors.dart';
import '../../../../core/component/image/p_image.dart';
import '../../../../core/data/assets_helper/app_svg_icon.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomBottomNavigation({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      onTap: navigationShell.goBranch,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      showUnselectedLabels: true,
      unselectedFontSize: 14,
      selectedFontSize: 14,
      selectedItemColor: AppColors.primaryColor,
      backgroundColor: AppColors.whiteColor,

      items: [
        BottomNavigationBarItem(
          icon: const PImage(
            source: AppSvgIcons.home,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: AppColors.greyColor,
          ),
          activeIcon: const PImage(
            source: AppSvgIcons.home,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: AppColors.primaryColor,
          ),
          label: 'home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const PImage(
            source: AppSvgIcons.file,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: AppColors.greyColor,
          ),
          activeIcon: const PImage(
            source: AppSvgIcons.file,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: AppColors.primaryColor,
          ),
          label: 'requests'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const PImage(
            source: AppSvgIcons.user,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: AppColors.greyColor,
          ),
          activeIcon: const PImage(
            source: AppSvgIcons.user,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: AppColors.primaryColor,
          ),
          label: 'profile'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const PImage(
            source: AppSvgIcons.menu,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: AppColors.greyColor,
          ),
          activeIcon: const PImage(
            source: AppSvgIcons.menu,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: AppColors.primaryColor,
          ),
          label: 'menu'.tr(),
        ),
      ],
    );
  }
}
