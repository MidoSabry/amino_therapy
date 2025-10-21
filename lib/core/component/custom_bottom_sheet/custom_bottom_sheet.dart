import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/constants/app_colors.dart';
import '../../data/constants/global_obj.dart';
import '../button/p_button.dart';

Future<dynamic> showCustomBottomSheet<C extends Cubit<S>, S>({
  BuildContext? context,
  required Widget body,
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
  bool isDismissible = true,
}) async {
  final ctx = context ?? Get.navigatorState!.context;

  return showModalBottomSheet(
    context: ctx,
    isDismissible: isDismissible,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    builder: (innerContext) {
      Widget content = Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(innerContext).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: Platform.isAndroid ? 52 : 24,
          ),
          width: MediaQuery.sizeOf(ctx).width,
          color: AppColors.whiteColor,
          child: isFullSheetWidget
              ? body
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      body,

                      const SizedBox(height: 20),
                      withYesNoActions
                          ? Row(
                              children: [
                                Expanded(
                                  child: PButton<C, S>(
                                    hasCubit: hasCubit,
                                    isFirstButton: true,
                                    isButtonAlwaysExist: false,
                                    onPressed:
                                        yesButtonAction ??
                                        () => Navigator.of(ctx).pop(true),
                                    title: yesButtonTitle ?? "yes",
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: PButton<C, S>(
                                    hasCubit: hasCubit,
                                    isButtonAlwaysExist: false,
                                    isFirstButton: false,
                                    borderColor: AppColors.primaryColor,
                                    fillColor: AppColors.whiteColor,
                                    textColor: AppColors.black,
                                    onPressed:
                                        noButtonAction ??
                                        () => Navigator.of(ctx).pop(false),
                                    title: noButtonTitle ?? "no",
                                  ),
                                ),
                              ],
                            )
                          : PButton<C, S>(
                              hasCubit: hasCubit,
                              isButtonAlwaysExist: false,
                              isFirstButton: true,
                              isFitWidth: true,
                              onPressed:
                                  okButtonAction ??
                                  () => Navigator.of(ctx).pop(true),
                              title: okButtonTitle ?? "okay",
                            ),
                    ],
                  ),
                ),
        ),
      );

      // 👇 wrap with BlocProvider if cubit is provided
      if (cubit != null) {
        return BlocProvider.value(value: cubit, child: content);
      }
      return content;
    },
  );
}
