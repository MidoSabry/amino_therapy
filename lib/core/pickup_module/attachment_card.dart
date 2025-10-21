
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../di.dart';
import '../component/custom_loader/custom_loader.dart';
import '../component/image/p_image.dart';
import '../component/text/p_text.dart';
import '../data/assets_helper/app_svg_icon.dart';
import '../data/constants/app_colors.dart';
import '../global/enums/global_enum.dart';
import '../global/state/base_state.dart';
import 'download_file_module/cubit/download_file_cubit.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    required this.name,
    this.canDownload = false,
    this.id,
    this.endPoint,
  });
  final String name;
  final String? endPoint;
  final int? id;
  final bool canDownload;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadFileCubit(downloadFileUseCase: getIt()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Icon in circle
            const PImage(source: AppSvgIcons.shadowFile),
            SizedBox(width: 4.w),
            Expanded(
              child: PText(
                title: name,
                size: PSize.text14,
                fontWeight: FontWeight.w500,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            BlocConsumer<DownloadFileCubit, BaseState>(
              listener: (context, state) {},
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (canDownload && id != null) {
                      context.read<DownloadFileCubit>().download(
                        endPoint: endPoint!,
                        id: id!,
                      );
                    }
                  },
                  icon:
                      canDownload
                          ? state is LoadingState
                              ? const CustomLoader(
                                size: 30,
                                loadingShape: LoadingShape.waveSpinner,
                              )
                              : PText(
                                title: 'download'.tr(),
                                fontColor: AppColors.primaryColor,
                              )
                          : const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
