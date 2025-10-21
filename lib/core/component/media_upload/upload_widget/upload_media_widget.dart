import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/assets_helper/app_svg_icon.dart';
import '../../../data/constants/app_colors.dart';
import '../../../global/enums/global_enum.dart';
import '../../../global/global_func.dart';
import '../../../services/file_service_picker/file_service_picker.dart';
import '../../dashed_border/dashed_border_container.dart';
import '../../global_widgets.dart';
import '../../image/p_image.dart';
import '../../image/show_image.dart';
import '../../text/p_text.dart';
import '../upload_bloc/upload_bloc.dart';
import '../upload_bloc/upload_event.dart';
import '../upload_bloc/upload_state.dart';

class UploadWidget extends StatelessWidget {
  final PickerType pickerType;
  final bool? isReport;
  final bool isEnable;
  final int numberOfImages;
  final Function(List<File> selectedImages)? onChange;

  const UploadWidget({
    super.key,
    required this.pickerType,
    this.numberOfImages = 1,
    this.onChange,
    this.isReport = false,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    List<File> selectedFiles = [];
    return BlocConsumer<UploadBloc, UploadState>(
      listener: (context, state) {
        // if (state is UploadFailure) {
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(SnackBar(content: Text(state.error)));
        // }

        if (state is FilesPicked || state is FileRemoved) {
          selectedFiles = (state as dynamic).pickedFiles ?? [];
          if (onChange != null) {
            onChange!(selectedFiles);
          }
        }
      },
      builder: (context, state) {
        if (state is FilesPicked) {
          selectedFiles = state.pickedFiles;
        }
        if (onChange != null) {
          onChange!(selectedFiles);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PText(
              title: 'add_file'.tr(),
              fontColor: AppColors.black,
              fontWeight: FontWeight.w400,
              size: PSize.text16,
            ),
            GestureDetector(
              onTap: !(isEnable)
                  ? null
                  : () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (pickerType != PickerType.file) {
                        _showImagePickerDialog(context);
                      } else {
                        BlocProvider.of<UploadBloc>(context).add(
                          PickFiles(
                            isReport: isReport ?? false,
                            pickerType: pickerType,
                            numberOfImages: numberOfImages,
                          ),
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
                    strokeWidth: 1.0, // thicker border
                    dashWidth: 3.0, // longer dashes
                    gapWidth: 2.0, // bigger gap
                    dashedBorderColor: AppColors.grayColor400,

                    child: Container(
                      margin: const EdgeInsets.all(1),
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          pickerType != PickerType.file
                              ? PImage(
                                  source: AppSvgIcons.camera,
                                  color: isDark
                                      ? AppColors.whiteColor
                                      : AppColors.black,
                                )
                              : const PImage(source: AppSvgIcons.folder),
                          const SizedBox(height: 1),
                          PText(
                            title: pickerType != PickerType.file
                                ? 'clickHereToAddPhotos'.tr(context: context)
                                : 'clickHereToUploadFiles'.tr(context: context),
                            fontColor: AppColors.hintTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...[
              const SizedBox(height: 10),
              BlocBuilder<UploadBloc, UploadState>(
                builder: (context, state) {
                  if (state is Uploading) {
                    return customLoader();
                  } else {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: selectedFiles.map((file) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
                              pickerType != PickerType.file
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Hero(
                                        tag: file.toString(),
                                        child: GestureDetector(
                                          onTap: () {
                                            showImage(
                                              image: '',
                                              isFile: true,
                                              file: file,
                                            );
                                          },
                                          child: Image.file(
                                            file,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const PImage(
                                      source: AppSvgIcons.success,
                                      height: 20,
                                      width: 20,
                                    ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PText(
                                  maxLines: 1,
                                  title: file.path.split('/').last,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<UploadBloc>(
                                    context,
                                  ).add(RemoveFile(file));
                                },
                                child: Icon(
                                  Icons.close,
                                  color: isDark ? Colors.white : Colors.black,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ],
        );
      },
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<UploadBloc>(context),
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: isDarkContext(context)
                  ? AppColors.darkFieldBackgroundColor
                  : AppColors.whiteColor,
              border: const Border(
                top: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
            ),
            child: Wrap(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  horizontalTitleGap: 4,
                  leading: const Icon(Icons.photo_camera_back),
                  title: PText(title: 'اضافة صورة من ملف الصور'.tr()),
                  onTap: () {
                    BlocProvider.of<UploadBloc>(context).add(
                      PickFiles(
                        isReport: isReport ?? false,
                        pickerType: numberOfImages == 1
                            ? PickerType.singleImageGallery
                            : PickerType.multipleImages,
                        numberOfImages: numberOfImages,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  horizontalTitleGap: 4,
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: PText(title: 'افتح الكاميرا'.tr()),
                  onTap: () {
                    BlocProvider.of<UploadBloc>(context).add(
                      PickFiles(
                        isReport: isReport ?? false,
                        pickerType: PickerType.singleImageCamera,
                        numberOfImages: numberOfImages,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
