import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../global/global_func.dart';
import '../../services/localization/app_localization.dart';
import '../text/p_text.dart';
import 'package:collection/collection.dart';

class MyCustomDropDown extends StatefulWidget {
  final List<String> options;
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? dropdownLabel;
  final String? hintText;
  final Color? dropdownLabelColor;
  final bool? isOptional;
  final bool enableSearch;
  final double? width;
  final double? height;
  final bool isEnabled;
  final ValueChanged<String?>? onChange;
  final FocusNode? focusNode;
  final bool translate;
  final String? defaulResetLabel;
  final bool isFieldRequired;
  final bool enableFilter;
  const MyCustomDropDown({
    super.key,
    required this.options,
    this.controller,
    this.initialValue,
    this.dropdownLabel,
    this.dropdownLabelColor,
    this.hintText,
    this.onChange,
    this.label,
    this.width,

    this.height,

    this.defaulResetLabel,
    this.focusNode,
    this.translate = false,

    this.isEnabled = true,
    this.isOptional = false,
    this.isFieldRequired = false,
    this.enableSearch = true,
    this.enableFilter = true,
  });

  @override
  State<MyCustomDropDown> createState() => _MyCustomDropDownState();
}

class _MyCustomDropDownState extends State<MyCustomDropDown> {
  late final TextEditingController _controller;
  final List<String> options = [];
  @override
  void initState() {
    if (widget.defaulResetLabel != null) {
      options.add(widget.defaulResetLabel!);
    }
    options.addAll(widget.options);
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? _controller.text;
    _controller.text = _controller.text.tr();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  PText(title: widget.label?.tr() ?? '', size: PSize.text16),
                  widget.isFieldRequired
                      ? const PText(
                        title: ' *',
                        size: PSize.text16,
                        fontColor: AppColors.errorCode,
                      )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 10),
                  widget.isOptional!
                      ? Text(
                        "(optional)".tr(),

                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(),
                      )
                      : Container(),
                ],
              ),
            ),
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
              color:
                  isDark
                      ? AppColors.darkFieldBackgroundColor
                      : AppColors.whiteColor, // Background color
              borderRadius: BorderRadius.circular(4), // Corner radius
            ),
            child: DropdownMenu(
              requestFocusOnTap: false,
              focusNode: widget.focusNode,
              enabled: options.isEmpty ? false : widget.isEnabled,
              controller: _controller,
              hintText: widget.hintText?.tr(),

              label:
                  widget.dropdownLabel != null
                      ? PText(
                        title: widget.dropdownLabel?.tr() ?? '',
                        size: PSize.text16,
                        fontColor:
                            widget.dropdownLabelColor ?? AppColors.contentColor,
                      )
                      : null,
              width: widget.width ?? MediaQuery.sizeOf(context).width - 32,
              menuHeight: 300, //Add Fixed height

              onSelected: (String? value) {
                FocusManager.instance.primaryFocus?.unfocus();
                if (widget.onChange != null) {
                  widget.onChange!(value);
                }
                setState(() {
                  _controller.text = value?.tr() ?? '';
                });
              },
              enableSearch: widget.enableSearch,
              enableFilter: widget.enableFilter,
              // initialSelection: selectedValue,
              textStyle: const TextStyle(
                height: 1.6,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.02,
              ),
              trailingIcon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 20,
                color: AppColors.contentColor,
              ),

              leadingIcon: null, // const Icon(Icons.search),
              selectedTrailingIcon: const Icon(
                Icons.keyboard_arrow_up_outlined,
                size: 20,
                color: AppColors.contentColor,
              ),
              menuStyle: MenuStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                backgroundColor: WidgetStateProperty.all(
                  isDark
                      ? AppColors.darkFieldBackgroundColor
                      : AppColors.whiteColor,
                ),
                alignment:
                    AppLocalization.isArabic
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
              ),
              // hintText: widget.hintText?.tr() ?? 'select'.tr(),
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                constraints: BoxConstraints.tight(
                  Size.fromHeight(widget.height ?? 48),
                ),
                hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.contentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),

                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color:
                        isDark
                            ? AppColors.darkBorderColor
                            : AppColors.borderColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        isDark
                            ? AppColors.darkBorderColor
                            : AppColors.borderColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
              // inputDecorationTheme: const InputDecorationTheme(
              //   filled: true,
              //   contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              // ),
              dropdownMenuEntries: List.generate(
                options.length,
                (index) => DropdownMenuEntry(
                  value: options[index],
                  label:
                      widget.translate ? options[index].tr() : options[index],
                  // leadingIcon: Icon(
                  //   Icons.check,
                  //   color: AppColors.primaryColor,
                  // ),
                  trailingIcon:
                      options[index].tr() == _controller.text
                          ? Icon(
                            Icons.check,
                            color:
                                isDark
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor,
                            size: 14,
                          )
                          : null,

                  style: MenuItemButton.styleFrom(
                    // foregroundColor: AppColors.primaryColor50,
                    // padding: EdgeInsets.only(left: 1),
                    foregroundColor:
                        options[index].tr() == _controller.text
                            ? isDark
                                ? AppColors.whiteColor
                                : AppColors.primaryColor
                            : AppColors.contentColor,
                    backgroundColor:
                        isDark
                            ? AppColors.darkFieldBackgroundColor
                            : AppColors.whiteColor,
                    alignment: Alignment.center,
                    textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      height: 1.6,
                      letterSpacing: -0.02,

                      fontWeight:
                          options[index].tr() == _controller.text
                              ? FontWeight.w600
                              : FontWeight.w400,
                      color:
                          options[index].tr() == _controller.text
                              ? AppColors.primaryColor
                              : AppColors.contentColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyCustomDropDownMapOptions extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final String keyTitle;
  final TextEditingController? controller;
  final Map<String, dynamic>? initialValue;
  final String? label;
  final String? dropdownLabel;
  final String? hintText;
  final Color? dropdownLabelColor;
  final bool? isOptional;
  final bool enableSearch;
  final double? width;
  final double? height;
  final bool isEnabled;
  final ValueChanged<Map<String, dynamic>?>? onChange;
  final FocusNode? focusNode;

  final String? defaulResetLabel;
  final bool isFieldRequired;
  final bool enableFilter;
  const MyCustomDropDownMapOptions({
    super.key,
    required this.options,
    required this.keyTitle,
    this.controller,
    this.initialValue,
    this.dropdownLabel,
    this.dropdownLabelColor,
    this.hintText,
    this.onChange,
    this.label,
    this.width,
    this.height,
    this.focusNode,
    this.defaulResetLabel,
    this.isEnabled = true,
    this.isOptional = false,
    this.isFieldRequired = false,
    this.enableSearch = true,
    this.enableFilter = true,
  });

  @override
  State<MyCustomDropDownMapOptions> createState() =>
      _MyCustomDropDownMapOptionsState();
}

class _MyCustomDropDownMapOptionsState
    extends State<MyCustomDropDownMapOptions> {
  late final TextEditingController _controller;
  Map<String, dynamic>? selectedValue;

  @override
  void initState() {
    if (widget.defaulResetLabel != null) {
      widget.options.insert(0, {widget.keyTitle: widget.defaulResetLabel!});
    }

    _controller = widget.controller ?? TextEditingController();
    selectedValue = widget.initialValue;
    if (selectedValue != null) {
      _controller.text = selectedValue![widget.keyTitle] ?? '';
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyCustomDropDownMapOptions oldWidget) {
    if (!areListsEqualDeep(widget.options, oldWidget.options)) {
      selectedValue = null;
      _controller.clear();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  PText(title: widget.label?.tr() ?? '', size: PSize.text16),
                  widget.isFieldRequired
                      ? const PText(
                        title: ' *',
                        size: PSize.text16,
                        fontColor: AppColors.errorCode,
                      )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 10),
                  widget.isOptional!
                      ? Text(
                        "(optional)".tr(),
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(),
                      )
                      : Container(),
                ],
              ),
            ),
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
              color:
                  isDark
                      ? AppColors.darkFieldBackgroundColor
                      : AppColors.whiteColor, // Background color
              borderRadius: BorderRadius.circular(4), // Corner radius
            ),
            child: DropdownMenu(
              requestFocusOnTap: false,
              enableFilter: widget.enableFilter,
              focusNode: widget.focusNode,
              enabled: widget.options.isEmpty ? false : widget.isEnabled,
              controller: _controller,
              initialSelection: selectedValue,

              label:
                  widget.dropdownLabel != null
                      ? Text(
                        widget.dropdownLabel?.tr() ?? '',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              widget.dropdownLabelColor ??
                              AppColors.contentColor,
                        ),
                      )
                      : null,
              width: widget.width ?? MediaQuery.sizeOf(context).width - 32,
              menuHeight: 300, //Add Fixed height
              onSelected: (value) {
                FocusManager.instance.primaryFocus?.unfocus();

                setState(() {
                  selectedValue = value;
                  _controller.text = selectedValue?[widget.keyTitle] ?? '';
                });

                if (widget.onChange != null) {
                  widget.onChange!(value);
                }
              },
              enableSearch: widget.enableSearch,

              textStyle: const TextStyle(
                height: 1.6,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.02,
              ),
              trailingIcon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 20,
                color: AppColors.contentColor,
              ),

              leadingIcon: null, // const Icon(Icons.search),
              selectedTrailingIcon: const Icon(
                Icons.keyboard_arrow_up_outlined,
                size: 20,
                color: AppColors.contentColor,
              ),
              menuStyle: MenuStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(
                  isDark
                      ? AppColors.darkFieldBackgroundColor
                      : AppColors.whiteColor,
                ),
                alignment:
                    AppLocalization.isArabic
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
              ),
              hintText: widget.hintText?.tr() ?? 'select'.tr(),
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                constraints: BoxConstraints.tight(
                  Size.fromHeight(widget.height ?? 48),
                ),
                hintStyle: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.contentColor),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color:
                        isDark
                            ? AppColors.darkBorderColor
                            : AppColors.borderColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        isDark
                            ? AppColors.darkBorderColor
                            : AppColors.borderColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
              dropdownMenuEntries: List.generate(
                widget.options.length,
                (index) => DropdownMenuEntry<Map<String, dynamic>>(
                  value: widget.options[index],

                  label: widget.options[index][widget.keyTitle],
                  // leadingIcon: Icon(
                  //   Icons.check,
                  //   color: AppColors.primaryColor,
                  // ),
                  trailingIcon:
                      widget.options[index][widget.keyTitle] ==
                              selectedValue?[widget.keyTitle]
                          ? Icon(
                            Icons.check,
                            color:
                                isDark
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor,
                            size: 14,
                          )
                          : null,

                  style: MenuItemButton.styleFrom(
                    foregroundColor:
                        widget.options[index][widget.keyTitle] ==
                                selectedValue?[widget.keyTitle]
                            ? isDark
                                ? AppColors.whiteColor
                                : AppColors.primaryColor
                            : AppColors.contentColor,
                    backgroundColor:
                        isDark
                            ? AppColors.darkFieldBackgroundColor
                            : AppColors.whiteColor,
                    alignment: Alignment.center,

                    textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      height: 1.6,
                      letterSpacing: -0.02,
                      fontWeight:
                          widget.options[index][widget.keyTitle] ==
                                  selectedValue?[widget.keyTitle]
                              ? FontWeight.w600
                              : FontWeight.w400,
                      color:
                          widget.options[index][widget.keyTitle] ==
                                  selectedValue?[widget.keyTitle]
                              ? AppColors.primaryColor
                              : AppColors.contentColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

bool areListsEqualDeep(List list1, List list2) {
  return const DeepCollectionEquality().equals(list1, list2);
}
