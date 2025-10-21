
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/dashed_border/dashed_border_container.dart';
import '../component/image/p_image.dart';
import '../component/text/p_text.dart';
import '../data/assets_helper/app_svg_icon.dart';
import '../data/constants/app_colors.dart';
import '../global/enums/global_enum.dart';
import '../global/global_func.dart';
import 'file_picker_cubit.dart';

class FilePickerComponent extends StatefulWidget {
  final bool pickImagesOnly;
  final bool allowMultiple;
  final int numberOfAllowedFiles;
  final String? title;
  final void Function(List<Map<String, String>> attachmentList) onFilesChanged;

  final bool isEnabled;

  const FilePickerComponent({
    super.key,
    this.pickImagesOnly = false,
    this.allowMultiple = true,
    required this.onFilesChanged,
    this.title,
    this.numberOfAllowedFiles = 3,

    this.isEnabled = true,
  });

  @override
  State<FilePickerComponent> createState() => _FilePickerComponentState();
}

class _FilePickerComponentState extends State<FilePickerComponent> {
  late final FilePickerCubit filePickerCubit;

  @override
  void initState() {
    filePickerCubit = context.read<FilePickerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilePickerCubit, FilePickerState>(
      listener: (_, state) {
        if (state is FilePickerSuccess) {
          widget.onFilesChanged(state.files);
        }
      },
      builder: (_, state) {
        if (state is FilePickerSuccess) {}
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PText(
              title:
                  state is FilePickerSuccess &&
                      state.files.length == widget.numberOfAllowedFiles
                  ? 'attachments'.tr()
                  : widget.title?.tr() ?? 'add_file'.tr(),
              fontColor: AppColors.black,
              fontWeight: FontWeight.w400,
              size: PSize.text16,
            ),
            const SizedBox(height: 8),
            state is FilePickerSuccess &&
                    state.files.length == widget.numberOfAllowedFiles
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: !widget.isEnabled
                        ? null
                        : () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (0 == widget.numberOfAllowedFiles) {
                              return;
                            } else if (widget.pickImagesOnly) {
                              filePickerCubit.pickImages(
                                allowMultiple: widget.allowMultiple,
                                numberOfAllowedFiles:
                                    widget.numberOfAllowedFiles,
                              );
                            } else {
                              filePickerCubit.pickFiles(
                                allowMultiple: widget.allowMultiple,
                                numberOfAllowedFiles:
                                    widget.numberOfAllowedFiles,
                              );
                            }
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 6.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: DashedBorderContainer(
                          strokeWidth: 1.0,
                          dashWidth: 3.0,
                          gapWidth: 2.0,
                          dashedBorderColor: AppColors.grayColor400,
                          child: Container(
                            margin: const EdgeInsets.all(1),
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const PImage(source: AppSvgIcons.folder),
                                const SizedBox(height: 1),
                                PText(
                                  title: 'clickHereToUploadFiles'.tr(),
                                  fontColor: AppColors.hintTextColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 8),
            if (state is FilePickerLoading) ...[
              // const Center(child: CircularProgressIndicator()),
            ] else if (state is FilePickerError) ...[
              Text(state.message, style: const TextStyle(color: Colors.red)),
            ] else if (state is FilePickerSuccess) ...[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: state.files.map((file) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkFieldBackgroundColor
                          : AppColors.shade2,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkFieldBackgroundColor
                            : AppColors.shade4,
                      ),
                    ),
                    child: Row(
                      children: [
                        const PImage(
                          source: AppSvgIcons.success,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PText(
                            maxLines: 1,
                            title: file["fileName"] ?? "",
                          ),
                        ),
                        const SizedBox(width: 12),
                        widget.isEnabled
                            ? IconButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  final updatedFiles =
                                      List<Map<String, String>>.from(
                                        state.files,
                                      )..remove(file);
                                  filePickerCubit.emitSuccess(updatedFiles);
                                },
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.close,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              )
                            : const SizedBox(height: 48, width: 24),
                      ],
                    ),
                  );
                }).toList(),
              ),
              // ...state.files.map((file) => ListTile(
              //   title: Text(file["fileName"] ?? ""),
              //   subtitle: Text(
              //     "${file["fileBinary"]!.substring(0, 25)}...",
              //     style: const TextStyle(fontSize: 12),
              //   ),
              //   trailing: IconButton(
              //     icon: const Icon(Icons.close),
              //     onPressed: () {
              //       final updatedFiles = List<Map<String, String>>.from(state.files)
              //         ..remove(file);
              //       cubit.emit(FilePickerSuccess(updatedFiles));
              //     },
              //   ),
              // )
              // ),
            ],
          ],
        );
      },
    );
  }
}
