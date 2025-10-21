
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/assets_helper/app_icon.dart';
import '../../global/global_func.dart';
import '../../global/state/base_state.dart';
import '../../services/base_network/general_response_model.dart';
import '../../services/localization/app_localization.dart';
import '../image/p_image.dart';
import '../text/p_text.dart';

class NoItemsFoundIndicatorBuilder extends StatelessWidget {
  final BaseState state;
  const NoItemsFoundIndicatorBuilder({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PImage(
                source: isDark ? AppIcons.emptyStateDark : AppIcons.emptyState,
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),

              // PText(
              //   title:
              //       (state is EmptyState)
              //           ? ((state as EmptyState).data ?? '')
              //           : (state is LoadedState)
              //           ? ((state as LoadedState).data?.message ?? '')
              //           : '',
              // ),
              PText(
                title:
                    ((state is EmptyState)
                        ? ((state as EmptyState).data)
                        : (state is LoadedState)
                        ? AppLocalization.isArabic
                            ? ((state as LoadedState).data
                                    as GeneralResponseModel)
                                .arabicMessage
                            : ((state as LoadedState).data
                                    as GeneralResponseModel)
                                .englishMessage
                        : 'noData'.tr()) ??
                    'noData'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
