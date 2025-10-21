import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'dart:math';

import '../../data/constants/app_colors.dart';
import '../../services/localization/app_localization.dart';
import '../text/p_text.dart';
import '../../global/enums/global_enum.dart';
import 'dart:ui' as ui;

class CustomCircleChart extends StatelessWidget {
  final double current;
  final double total;
  final String title;
  final bool isSar;
  final Color progressColor;
  final bool isHidden;

  const CustomCircleChart({
    super.key,
    required this.current,
    required this.total,
    required this.title,
    this.isSar = false,
    required this.progressColor,
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = current / total;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          painter: _ProgressAndRemainingPainter(
            percent: percent,
            progressColor: progressColor,
            remainingColor: AppColors.greyColor2,
          ),
          child: SizedBox(
            width: isSar ? 110 : 100,
            height: isSar ? 110 : 100,
            child: Center(
              child: Directionality(
                textDirection:
                    AppLocalization.isArabic
                        ? ui.TextDirection.rtl
                        : ui.TextDirection.ltr,
                child:
                    isSar
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PText(
                              title:
                                  '${isHidden ? '****' : current.toStringAsFixed(0)} ${'sar'.tr()} ',
                              size: PSize.text14,
                              fontWeight: FontWeight.w500,
                            ),
                            PText(
                              title:
                                  '${isHidden ? '****' : total.toStringAsFixed(0)} ${'sar'.tr()} ',
                              size: PSize.text12,
                              fontColor: AppColors.hintTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PText(
                              title: current.toString(),
                              size: PSize.text14,
                              fontWeight: FontWeight.bold,
                            ),
                            PText(
                              title: 'from'.tr(),
                              size: PSize.text14,
                              fontColor: AppColors.hintTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                            PText(
                              title: total.toString(),
                              size: PSize.text14,
                              fontColor: AppColors.hintTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        PText(title: title, fontWeight: FontWeight.w500, size: PSize.text16),
      ],
    );
  }
}

class _ProgressAndRemainingPainter extends CustomPainter {
  final double percent;
  final Color progressColor;
  final Color remainingColor;
  final double gapSize;

  _ProgressAndRemainingPainter({
    required this.percent,
    required this.progressColor,
    required this.remainingColor,
    this.gapSize = pi / 18, // 10 degrees gap
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 6.0;
    double radius = (size.width - strokeWidth) / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint progressPaint =
        Paint()
          ..strokeWidth = strokeWidth
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final Paint remainingPaint =
        Paint()
          ..strokeWidth = strokeWidth
          ..color = remainingColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    const double totalAngle = 2 * pi;

    // If fully completed, draw full progress circle with no gaps
    if (percent >= 1.0) {
      canvas.drawArc(
        rect,
        -pi / 2, // start at top
        totalAngle,
        false,
        progressPaint,
      );
      return;
    }

    final double gap = gapSize;
    final double availableAngle = totalAngle - 2 * gap;

    final double progressSweep = availableAngle * percent;
    final double remainingSweep = availableAngle * (1 - percent);

    final double startAngleProgress = -pi / 4 + gap;
    final double startAngleRemaining = startAngleProgress + progressSweep + gap;

    if (percent > 0) {
      canvas.drawArc(
        rect,
        startAngleProgress,
        progressSweep,
        false,
        progressPaint,
      );
    }

    if (percent < 1.0) {
      canvas.drawArc(
        rect,
        startAngleRemaining,
        remainingSweep,
        false,
        remainingPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
