
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/assets_helper/app_svg_icon.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../button/p_button.dart';
import '../custom_bottom_sheet/custom_bottom_sheet.dart';
import '../image/p_image.dart';
import '../text/p_text.dart';

class SubmitAndCancelButtons<C extends Cubit<S>, S> extends StatelessWidget {
  const SubmitAndCancelButtons({
    super.key,
    this.onSubmit,
    this.onCancel,
    this.cubit,
  });

  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final C? cubit;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PButton<C, S>(
            isFirstButton: true,
            isButtonAlwaysExist: false,
            hasCubit: true,
            onPressed: onSubmit,
            isFitWidth: true,
            title: 'send',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PButton<C, S>(
            isFirstButton: false,
            fillColor: AppColors.dangerColor,
            isButtonAlwaysExist: false,
            hasCubit: true,
            onPressed: () async {
              await showCustomBottomSheet<C, S>(
                isDismissible: false,
                cubit: cubit,
                body: const CancelContentForBottomSheet(),

                withYesNoActions: true,
                yesButtonTitle: 'yes',
                noButtonTitle: 'no',
                hasCubit: true,
                yesButtonAction: onCancel,
              );
            },
            isFitWidth: true,
            title: 'cancel_button',
          ),
        ),
      ],
    );
  }
}

class CancelContentForBottomSheet extends StatelessWidget {
  const CancelContentForBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              title: 'cancell'.tr(),
              size: PSize.text16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 8),
        PText(
          title: 'doYouWantToCancel'.tr(),
          size: PSize.text16,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
