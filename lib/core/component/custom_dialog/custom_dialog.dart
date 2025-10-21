import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/constants/app_colors.dart';
import '../../data/constants/global_obj.dart';
import '../button/p_button.dart';

Future<dynamic> showCustomDialog<C extends Cubit<S>, S>({
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
  bool isDismissible = false,
}) async {
  final ctx = context ?? Get.navigatorState!.context;

  return await showDialog(
    context: ctx,
    barrierDismissible: isDismissible,

    builder: (_) {
      Widget content = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.whiteColor,
        ),

        child: isFullSheetWidget
            ? body
            : Column(
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
                                onPressed:
                                    yesButtonAction ??
                                    () => Navigator.of(ctx).pop(true),
                                title: yesButtonTitle ?? "نعم",
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: PButton<C, S>(
                                hasCubit: hasCubit,
                                isButtonAlwaysExist: false,
                                borderColor: AppColors.primaryColor,
                                fillColor: AppColors.whiteColor,
                                textColor: AppColors.black,
                                onPressed:
                                    noButtonAction ??
                                    () => Navigator.of(ctx).pop(false),
                                title: noButtonTitle ?? "لا",
                              ),
                            ),
                          ],
                        )
                      : PButton<C, S>(
                          hasCubit: hasCubit,
                          isButtonAlwaysExist: false,
                          isFitWidth: true,
                          onPressed:
                              okButtonAction ??
                              () => Navigator.of(ctx).pop(true),
                          title: okButtonTitle ?? "okay",
                        ),
                ],
              ),
      );

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.zero,

        backgroundColor: AppColors.whiteColor,

        content: cubit != null
            ? BlocProvider.value(value: cubit, child: content)
            : content,
      );
    },
  );
}
