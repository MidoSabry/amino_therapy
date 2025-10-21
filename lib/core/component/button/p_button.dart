import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../global/global_func.dart';
import '../../global/state/base_state.dart';
import '../../services/log/app_log.dart';
import '../custom_loader/custom_loader.dart';
import '../text/p_text.dart';
import '../toast/erp_toast.dart';

class ButtonWidget extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? title;
  final FontWeight? fontWeight;
  final PSize? size;
  final List<String>? dropDown;
  final double? borderRadius;
  final MainAxisSize? mainAxisSize;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final Color? textColor;
  final bool isFitWidth;
  final bool isLeftIcon;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Color? fillColor;
  final Color? borderColor;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    this.size,
    this.isFitWidth = false,
    this.isLeftIcon = false,
    this.fontWeight,
    this.borderColor,
    this.borderRadiusGeometry,
    this.mainAxisSize,
    this.title,
    this.icon,
    this.dropDown,
    this.textColor,
    this.fillColor,
    this.borderRadius,
    this.padding,

    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      onHover: (m) {},
      style: ElevatedButton.styleFrom(
        backgroundColor: fillColor,
        disabledBackgroundColor: fillColor ?? AppColors.inactiveButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadiusGeometry ?? BorderRadius.circular(borderRadius ?? 4),
          side: BorderSide(
            color:
                borderColor != null
                    ? borderColor!
                    : fillColor != null
                    ? fillColor!
                    : AppColors.primaryColor,
          ),
        ),
        elevation: elevation,
        padding: padding,
        minimumSize:
            isFitWidth ? const Size.fromHeight(48) : const Size(60, 48),
      ),
      child:
          isLeftIcon
              ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Flexible(
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: PText(
                          title: title!.tr(),
                          size: size ?? PSize.text18,
                          fontColor: textColor ?? AppColors.whiteColor,
                          fontWeight: fontWeight ?? FontWeight.w500,
                        ),
                      ),
                    ),
                  icon ?? const SizedBox.shrink(),
                ],
              )
              : Row(
                mainAxisSize: mainAxisSize ?? MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  title != null
                      ? Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 10,
                            top: 4,
                          ),
                          // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: PText(
                            title: title!.tr(),
                            size: size ?? PSize.text18,
                            fontColor: textColor ?? AppColors.whiteColor,
                            fontWeight: fontWeight ?? FontWeight.w500,
                          ),
                        ),
                      )
                      : const SizedBox.shrink(),
                  (icon != null && title != null)
                      ? const SizedBox(width: 8)
                      : const SizedBox.shrink(),
                  icon ?? const SizedBox.shrink(),
                ],
              ),
    );
  }
}

class PRoundedButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Color backgroundColor;
  final String? title;
  final PSize size;
  final IconData? icon;
  final Color textColor;
  final Color? fillColor;
  final double? borderRadius;
  final FontWeight? fontWeight;

  const PRoundedButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.size = PSize.text12,
    this.title,
    this.icon,
    this.textColor = AppColors.primaryColor,
    this.fillColor,
    this.borderRadius,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    // Color buttonColor = style == PStyle.primary ? Constants.yellow : style == PStyle.secondary ? Constants.violet : Constants.white;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30.0),
            side: BorderSide(color: backgroundColor),
          ),
        ),
        overlayColor: WidgetStateProperty.all(AppColors.backgroundColor),
        backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.only(left: 14, right: 14),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null
              ? Icon(icon, size: 20, color: textColor)
              : const SizedBox.shrink(),
          icon != null ? const SizedBox(width: 2) : const SizedBox.shrink(),
          PText(
            title: title!.tr(),
            size: size,
            fontColor: textColor,
            fontWeight: fontWeight,
          ),
        ],
      ),
    );
  }
}

/// Generic button that reacts to [Cubit] state changes
class PButton<C extends Cubit<S>, S> extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? title;
  final PSize? size;
  final FontWeight? fontWeight;
  final List<String>? dropDown;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Widget? icon;
  final Color? textColor;
  final MainAxisSize? mainAxisSize;
  final bool hasCubit;
  final bool isFitWidth;
  final Color? fillColor;

  final Color? borderColor;
  final bool isButtonAlwaysExist;
  final bool isLeftIcon;
  final Widget? loadingWidget;
  final bool isFirstButton;

  const PButton({
    super.key,
    required this.onPressed,
    this.size,
    this.borderRadiusGeometry,
    this.isFitWidth = false,
    this.isLeftIcon = false,
    this.hasCubit = true,
    this.mainAxisSize,
    this.title,
    this.icon,
    this.dropDown,
    this.textColor,
    this.fillColor,

    this.borderRadius,
    this.padding,
    this.elevation,
    this.borderColor,
    this.isButtonAlwaysExist = true,
    this.loadingWidget,
    this.isFirstButton = true,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasCubit) {
      /// No Cubit → Just a static button
      return ButtonWidget(
        key: key,
        onPressed: onPressed,
        dropDown: dropDown,
        isLeftIcon: isLeftIcon,
        elevation: elevation,
        fillColor: fillColor,
        icon: icon,
        borderRadiusGeometry: borderRadiusGeometry,
        mainAxisSize: mainAxisSize,
        isFitWidth: isFitWidth,
        padding: padding,
        size: size,
        borderRadius: borderRadius,
        textColor: textColor,
        borderColor: borderColor,
        title: title,
      );
    }

    /// With Cubit → Dynamic button
    return BlocConsumer<C, S>(
      listener: (context, state) {
        AppLog.printValueAndTitle('Button state', state);
        if (state is ErrorState) {
          // ErpToast().showNotification(
          //   message: state.data?.message ?? 'error'.tr(),
          //   duration: const Duration(seconds: 2),
          //   type: MessageType.error,
          // );
        } else if (state is LoadedState) {
          try {
            if ((state.data?.message ?? '').toString().isNotEmpty) {
              ErpToast().showNotification(
                message: state.data?.message ?? 'Success',
                duration: const Duration(seconds: 1),
                type: MessageType.success,
              );
            }
          } catch (e) {}
        }
      },

      /// Only rebuild when button visual state changes
      buildWhen:
          (previous, current) =>
              current is ButtonLoadingState ||
              current is ButtonDisabledState ||
              current is ErrorState ||
              current is ButtonEnabledState ||
              current is LoadedState,
      builder: (context, state) {
        /// Show a loader instead of the button (if required)
        if (state is ButtonLoadingState &&
            (isFirstButton == state.isFirstButtonLoading) &&
            !isButtonAlwaysExist) {
          return loadingWidget ??
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      (!isFirstButton)
                          ? isDark
                              ? AppColors.darkInactiveButtonColor
                              : AppColors.whiteColor
                          : isDark
                          ? AppColors.darkInactiveButtonColor
                          : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(borderRadius ?? 4),
                  border: Border.all(
                    color:
                        isDark
                            ? AppColors.darkInactiveButtonColor
                            : AppColors.primaryColor,
                  ),
                ),
                constraints: const BoxConstraints(minWidth: 60, minHeight: 48),
                child: CustomLoader(
                  loadingShape: LoadingShape.fadingCircle,
                  color:
                      (!isFirstButton)
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                  size: 40,
                ),
              );
        }

        /// Regular Button
        return ButtonWidget(
          key: key,
          borderRadiusGeometry: borderRadiusGeometry,
          onPressed:
              ((state is ButtonDisabledState && isFirstButton) ||
                      state is ButtonLoadingState)
                  ? null
                  : onPressed,
          dropDown: dropDown,
          elevation: elevation,
          mainAxisSize: mainAxisSize,
          borderColor:
              (state is ButtonDisabledState && isFirstButton)
                  ? isDark
                      ? AppColors.darkInactiveButtonColor
                      : AppColors.inactiveButtonColor
                  : (state is ButtonLoadingState &&
                      (isFirstButton != state.isFirstButtonLoading))
                  ? isDark
                      ? AppColors.darkInactiveButtonColor
                      : AppColors.inactiveButtonColor
                  : borderColor,
          fillColor:
              (state is ButtonDisabledState && isFirstButton)
                  ? isDark
                      ? AppColors.darkInactiveButtonColor
                      : AppColors.inactiveButtonColor
                  : (state is ButtonLoadingState &&
                      (isFirstButton != state.isFirstButtonLoading))
                  ? isDark
                      ? AppColors.darkInactiveButtonColor
                      : AppColors.inactiveButtonColor
                  : fillColor,
          icon: icon,
          isFitWidth: isFitWidth,
          padding: padding,
          size: size,
          borderRadius: borderRadius,
          textColor: textColor,
          title: title,
          fontWeight: fontWeight ?? FontWeight.w500,
        );
      },
    );
  }
}
