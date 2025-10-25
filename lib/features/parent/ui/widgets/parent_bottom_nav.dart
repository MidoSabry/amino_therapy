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
          icon: Icon(Icons.home_outlined, color: AppColors.greyColor),
          activeIcon: Icon(Icons.home_outlined, color: AppColors.primaryColor),
          label: 'home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_open_outlined, color: AppColors.greyColor),
          activeIcon: Icon(
            Icons.file_open_outlined,
            color: AppColors.primaryColor,
          ),
          label: 'reserves'.tr(),
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined, color: AppColors.greyColor),
          activeIcon: Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.primaryColor,
          ),
          label: 'cart'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined, color: AppColors.greyColor),
          activeIcon: Icon(
            Icons.person_outline_outlined,
            color: AppColors.primaryColor,
          ),
          label: 'profile'.tr(),
        ),
      ],
    );
  }
}
