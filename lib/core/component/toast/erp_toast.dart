// navigatorKey here
import 'package:flutter/material.dart';

import '../../data/assets_helper/app_svg_icon.dart';
import '../../data/constants/app_colors.dart';
import '../../data/constants/global_obj.dart';
import '../../global/enums/global_enum.dart';
import '../image/p_image.dart';
import '../text/p_text.dart';


enum ToastPosition { top, center, bottom }

class ErpToast {
  static final ErpToast _instance = ErpToast._internal();
  factory ErpToast() => _instance;
  ErpToast._internal();

  OverlayEntry? _overlayEntry;

  void showNotification({
    required String message,
    MessageType? type,
    Duration duration = const Duration(seconds: 3),
    ToastPosition position = ToastPosition.top,
  }) {
    // remove previous toast if still showing
    dismiss();

    _overlayEntry = OverlayEntry(
      builder: (_) => ErpWidget(
        message: message,
        type: type ?? MessageType.success,
        duration: duration,
        position: position,
        onDismissed: dismiss,
      ),
    );

    final overlayState = navigatorKey.currentState?.overlay;
    if (overlayState != null) {
      overlayState.insert(_overlayEntry!);
    }
  }

  void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class ErpWidget extends StatefulWidget {
  final String message;
  final MessageType? type;
  final Duration duration;
  final ToastPosition position;
  final VoidCallback? onDismissed;

  const ErpWidget({
    super.key,
    required this.message,
    this.type = MessageType.success,
    this.duration = const Duration(seconds: 3),
    this.position = ToastPosition.top,
    this.onDismissed,
  });

  @override
  State<ErpWidget> createState() => ErpWidgetState();
}

class ErpWidgetState extends State<ErpWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late AnimationController _progressController;

  Color _getColor(MessageType type) {
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

  Widget _getIcon(MessageType type) {
    switch (type) {
      case MessageType.success:
        return const PImage(source: AppSvgIcons.success);
      case MessageType.error:
        return const PImage(source: AppSvgIcons.error);
      case MessageType.warning:
        return const PImage(source: AppSvgIcons.warning);
      default:
        return const PImage(source: AppSvgIcons.success);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 400),
    );
    _progressController = AnimationController(
      vsync: this,
      duration: widget.duration, // same as toast duration
    );

    _slide = Tween<Offset>(
      begin: Offset(0, widget.position == ToastPosition.top ? -1.2 : 1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
    _progressController.forward();
    // Auto dismiss after given duration
    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) {
          if (widget.onDismissed != null) {
            widget.onDismissed!();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressController.dispose();
    super.dispose();
  }

  double? _getTop(BuildContext context) {
    if (widget.position == ToastPosition.top) {
      return MediaQuery.of(context).padding.top + 10;
    }
    return null;
  }

  double? _getBottom(BuildContext context) {
    if (widget.position == ToastPosition.bottom) {
      return MediaQuery.of(context).padding.bottom + 20;
    }
    return null;
  }

  Alignment _getAlignment() {
    switch (widget.position) {
      case ToastPosition.center:
        return Alignment.center;
      case ToastPosition.bottom:
        return Alignment.bottomCenter;
      default:
        return Alignment.topCenter;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (widget.onDismissed != null) {
            widget.onDismissed!();
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: _getAlignment(),
              child: Padding(
                padding: EdgeInsets.only(
                  top: _getTop(context) ?? 0,
                  bottom: _getBottom(context) ?? 0,
                  left: 12,
                  right: 12,
                ),
                child: SlideTransition(
                  position: _slide,
                  child: FadeTransition(
                    opacity: _fade,
                    child: ScaleTransition(
                      scale: _scale,
                      child: GestureDetector(
                        onTap: () {}, // prevent dismiss when tapping toast itself
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          elevation: 10,
                          shadowColor: _getColor(widget.type!).withOpacity(0.4),
                          child: Container(
                            // padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border(
                              //   top: BorderSide(
                              //     color: _getColor(widget.type!),
                              //     width: 2,
                              //   ),
                              // ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              widget.type == MessageType.success
                                  ? CrossAxisAlignment.center
                                  : CrossAxisAlignment.start,
                              children: [
                                AnimatedBuilder(
                                  animation: _progressController,
                                  builder: (context, child) {
                                    return Container(
                                      height: 3,
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width *
                                          _progressController.value,
                                      decoration: BoxDecoration(
                                        color: _getColor(widget.type!),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: _getIcon(widget.type!),
                                      ),
                                      const SizedBox(width: 6),
                                      if (widget.type != MessageType.success)
                                        Expanded(
                                          child: PText(
                                            title: 'عفوا',
                                            fontColor:
                                            _getColor(widget.type!),
                                            fontWeight: FontWeight.w700,
                                            size: PSize.text18,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: PText(
                                    title: widget.message,
                                    fontColor:
                                    widget.type == MessageType.success
                                        ? _getColor(widget.type!)
                                        : AppColors.greyColor1,
                                    fontWeight: FontWeight.w500,
                                    size: PSize.text16,
                                  ),
                                ),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
