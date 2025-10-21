import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'file_service.dart';
part 'file_picker_state.dart';

class FilePickerCubit extends Cubit<FilePickerState> {
  FilePickerCubit() : super(FilePickerInitial());

  void emitSuccess(List<Map<String, String>> files) {
    emit(FilePickerSuccess(files));
  }

  void resetPickedFiles() {
    if (state is FilePickerSuccess) {
      (state as FilePickerSuccess).files.clear();
    }
  }

  Future<void> pickFiles({
    bool allowMultiple = true,
    List<String>? allowedExtensions,
    required int numberOfAllowedFiles,
  }) async {
    // Keep old files if already picked
    List<Map<String, String>> oldFiles = [];
    if (state is FilePickerSuccess) {
      oldFiles = (state as FilePickerSuccess).files;
    }

    try {
      final newFiles = await FileService.pickFiles(
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
      );

      // Merge old + new
      final merged = [...oldFiles, ...newFiles];

      // Keep max 3
      final limited = merged.take(numberOfAllowedFiles).toList();

      emit(FilePickerSuccess(limited));
    } catch (e) {
      emit(FilePickerError(e.toString()));
    }
  }

  Future<void> pickImages({
    bool allowMultiple = true,
    required int numberOfAllowedFiles,
  }) async {
    List<Map<String, String>> oldFiles = [];
    if (state is FilePickerSuccess) {
      oldFiles = (state as FilePickerSuccess).files;
    }

    try {
      final newFiles = await FileService.pickImages(
        allowMultiple: allowMultiple,
      );

      final merged = [...oldFiles, ...newFiles];
      final limited = merged.take(numberOfAllowedFiles).toList();

      emit(FilePickerSuccess(limited));
    } catch (e) {
      emit(FilePickerError(e.toString()));
    }
  }

  void clear() => emit(FilePickerInitial());
}
