import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../global/enums/request_status.dart';
import '../text/p_text.dart';

class CustomStatusCard extends StatelessWidget {
  const CustomStatusCard({super.key, required this.status});

  final RequestStatus status;

  Color _statusColor() {
    switch (status) {
      case RequestStatus.done:
        return AppColors.acceptShadow;
      case RequestStatus.draft:
        return Colors.orange;
      case RequestStatus.cancel:
        return Colors.red;
      case RequestStatus.all:
        return Colors.grey;
      case RequestStatus.inprogress:
        return Colors.blue;
      case RequestStatus.refuse:
        return Colors.red;
      case RequestStatus.skip:
        return Colors.orange;
      case RequestStatus.waiting:
        return Colors.blue;
    }
  }

  IconData _statusIcon() {
    switch (status) {
      case RequestStatus.done:
        return Icons.check;
      case RequestStatus.draft:
        return Icons.hourglass_empty;
      case RequestStatus.cancel:
        return Icons.close;
      case RequestStatus.all:
        return Icons.list;
      case RequestStatus.inprogress:
        return Icons.timer;
      case RequestStatus.waiting:
        return Icons.timer;
      case RequestStatus.refuse:
        return Icons.close;
      case RequestStatus.skip:
        return Icons.hourglass_empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      decoration: BoxDecoration(
        color: _statusColor().withOpacity(0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_statusIcon(), color: _statusColor(), size: 16),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Align(
              alignment: Alignment.center,
              child: PText(
                title: status.name.tr(),
                fontColor: _statusColor(),
                fontWeight: FontWeight.w500,
                size: PSize.text12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
