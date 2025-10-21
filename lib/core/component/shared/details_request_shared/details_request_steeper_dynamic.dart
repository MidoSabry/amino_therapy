
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../data/constants/app_colors.dart';
import '../../../global/enums/global_enum.dart';
import '../../../global/enums/request_status.dart';
import '../../../global/global_func.dart';
import '../../../global/models/approvals_model.dart';
import '../../custom_status_card/status_card.dart';
import '../../text/p_text.dart';

class DynamicStepper extends StatelessWidget {
  final List<Approvals> steps;

  const DynamicStepper({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PText(
          title: 'approvals'.tr(),
          size: PSize.text16,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 2.h),
        steps.isNotEmpty
            ? Column(
              children: List.generate(steps.length, (index) {
                final step = steps[index];
                final isLast = index == steps.length - 1;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vertical Dotted Line + Avatar
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: PText(
                              title: getInitials(step.actionBy ?? ''),
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w500,
                              size: PSize.text14,
                            ),
                          ),
                        ),
                        if (!isLast)
                          const DottedLineVertical(
                            height: 40,
                            color: Colors.black,
                          ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    // Name & Role
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 50.w, // set your desired max width
                          child: PText(
                            title: step.needActionFrom ?? '',
                            size: PSize.text14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                          child: PText(
                            title: step.actionBy ?? '',
                            size: PSize.text14,
                            fontColor: AppColors.hintTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    //status card
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: CustomStatusCard(
                        status: step.status ?? RequestStatus.draft,
                      ),
                    ),
                  ],
                );
              }),
            )
            : Align(
              alignment: Alignment.center,
              child: PText(title: 'no_approvals'.tr()),
            ),
      ],
    );
  }
}

class DottedLineVertical extends StatelessWidget {
  final double height;
  final Color color;

  const DottedLineVertical({
    super.key,
    required this.height,
    this.color = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2,
      height: height,
      child: CustomPaint(painter: _DottedLinePainter(color)),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;

  _DottedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = size.width;

    double y = 0;
    const double dashHeight = 4;
    const double dashSpace = 4;

    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, y + dashHeight),
        paint,
      );
      y += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
