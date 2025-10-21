
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/assets_helper/app_svg_icon.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../custom_bottom_sheet/custom_bottom_sheet.dart';
import '../image/p_image.dart';
import '../text/p_text.dart';

class DeleteRequestButton extends StatelessWidget {
  final VoidCallback? deleteButtonAction;
  const DeleteRequestButton({super.key, this.deleteButtonAction});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const PImage(source: AppSvgIcons.delete),
      onPressed: () {
        showCustomBottomSheet(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PImage(
                    source: AppSvgIcons.logout,
                    color: AppColors.black,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  PText(
                    title: 'delete'.tr(),
                    size: PSize.text16,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              PText(
                title: 'areYouSureToDeleteRequest'.tr(),
                size: PSize.text16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          withYesNoActions: true,
          yesButtonTitle: 'delete',
          noButtonTitle: 'cancel',
          yesButtonAction: deleteButtonAction,
        );
      },
    );
  }
}
