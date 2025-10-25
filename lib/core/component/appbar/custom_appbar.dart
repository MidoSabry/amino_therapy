import 'package:amino_therapy/core/component/image/p_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/assets_helper/app_svg_icon.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../services/localization/app_localization.dart';
import '../custom_bottom_sheet/custom_bottom_sheet.dart';
import '../text/p_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Widget? filterIconBottomSheetWidget;
  final VoidCallback? bottomSheetWidgetFormButtonAction;
  final VoidCallback? onBackPressed;
  final bool isCenterTitle;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.isCenterTitle = false,
    this.onBackPressed,
    this.filterIconBottomSheetWidget,
    this.actions,
    this.bottomSheetWidgetFormButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> finalActions = [];

    if (actions != null && actions!.isNotEmpty) {
      finalActions.addAll(actions!);
    }

    if (filterIconBottomSheetWidget != null) {
      finalActions.add(
        IconButton(
          icon: const PImage(
            source: AppSvgIcons.filter,
            height: 24,
            width: 24,
            fit: BoxFit.fill,
          ),
          onPressed: () {
            showCustomBottomSheet(
              context: context,
              body: filterIconBottomSheetWidget!,
              okButtonTitle: 'filterResults',
              okButtonAction: bottomSheetWidgetFormButtonAction,
            );
          },
        ),
      );
    }

    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: PImage(
                source: AppLocalization.isArabic
                    ? AppSvgIcons.backRight
                    : AppSvgIcons.backLeft,
                height: 30,
                width: 30,
                fit: BoxFit.fill,
              ),
              onPressed: () {
                if (onBackPressed != null) {
                  onBackPressed!();
                } else {
                  context.pop();
                }
              },
            )
          : null,
      actions: finalActions,
      title: PText(
        title: title.tr(context: context),
        fontColor: AppColors.black,
        fontWeight: FontWeight.w500,
        size: PSize.text18,
      ),
      centerTitle: isCenterTitle,
      titleSpacing: isCenterTitle ? null : 0,
      elevation: 0,
      backgroundColor: AppColors.backgroundScreens,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
