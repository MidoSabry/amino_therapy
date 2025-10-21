import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../button/retry_button.dart';
import '../text/p_text.dart';

class NewPageErrorIndicatorBuilder extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? message;
  const NewPageErrorIndicatorBuilder({super.key, this.onRetry, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PText(title: message ?? 'unexpectedError'.tr()),
          RetryButton(onRetry: onRetry),
        ],
      ),
    );
  }
}
