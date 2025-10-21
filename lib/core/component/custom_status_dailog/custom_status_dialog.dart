import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/assets_helper/app_svg_icon.dart';
import '../../data/constants/app_colors.dart';
import '../../data/constants/global_obj.dart';
import '../../global/enums/global_enum.dart';
import '../custom_bottom_sheet/custom_bottom_sheet.dart';
import '../custom_dialog/custom_dialog.dart';
import '../image/p_image.dart';
import '../text/p_text.dart';

Future<dynamic> showCustomStatusDialog<C extends Cubit<S>, S>({
  BuildContext? context,
  Widget? body,
  C? cubit, // 👈 allow passing cubit

  bool isFullSheetWidget = false,
  bool withYesNoActions = false,
  String? okButtonTitle,
  String? yesButtonTitle,
  String? noButtonTitle,
  VoidCallback? okButtonAction,
  VoidCallback? yesButtonAction,
  VoidCallback? noButtonAction,
  bool hasCubit = false,
  bool isBottomSheet = true,
  bool isDismissible = false,
  String? message,
  MessageType messageType = MessageType.success,
}) async {
  final ctx = context ?? Get.navigatorState!.context;
  final Widget finalBody =
      body ??
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: PImage(
                    source: getIcon(messageType),
                    height: 30,
                    width: 30,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 6),

                PText(
                  title: getLabel(messageType).tr(),
                  fontColor: getColor(messageType),
                  fontWeight: FontWeight.w700,
                  size: PSize.text18,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PText(
            title: message ?? '',
            fontWeight: FontWeight.w700,
            size: PSize.text18,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
        ],
      );

  return isBottomSheet
      ? await showCustomBottomSheet(
        context: ctx,
        isDismissible: isDismissible,
        hasCubit: hasCubit,
        okButtonAction: okButtonAction,
        yesButtonAction: yesButtonAction,
        noButtonAction: noButtonAction,
        okButtonTitle: okButtonTitle,
        yesButtonTitle: yesButtonTitle,
        noButtonTitle: noButtonTitle,
        withYesNoActions: withYesNoActions,

        isFullSheetWidget: isFullSheetWidget,
        body: finalBody,
      )
      : await showCustomDialog(
        context: ctx,
        isDismissible: isDismissible,
        hasCubit: hasCubit,
        okButtonAction: okButtonAction,
        yesButtonAction: yesButtonAction,
        noButtonAction: noButtonAction,
        okButtonTitle: okButtonTitle,
        yesButtonTitle: yesButtonTitle,
        noButtonTitle: noButtonTitle,
        withYesNoActions: withYesNoActions,
        isFullSheetWidget: isFullSheetWidget,
        body: finalBody,
      );
}

Color getColor(MessageType type) {
  switch (type) {
    case MessageType.success:
      return AppColors.success;
    case MessageType.error:
      return AppColors.error;
    case MessageType.warning:
      return AppColors.newWarningColor;
    case MessageType.info:
      return Colors.black54;
    default:
      return Colors.black;
  }
}

String getIcon(MessageType type) {
  switch (type) {
    case MessageType.success:
      return AppSvgIcons.success;
    case MessageType.error:
      return AppSvgIcons.error;
    case MessageType.warning:
      return AppSvgIcons.warning;
    default:
      return AppSvgIcons.success;
  }
}

String getLabel(MessageType type) {
  switch (type) {
    case MessageType.success:
      return "success";
    case MessageType.error:
      return "error";
    case MessageType.warning:
      return "warning";
    case MessageType.info:
      return "information";
    default:
      return "";
  }
}
