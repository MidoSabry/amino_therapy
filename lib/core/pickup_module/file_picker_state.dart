part of 'file_picker_cubit.dart';

abstract class FilePickerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilePickerInitial extends FilePickerState {}

class FilePickerLoading extends FilePickerState {}

class FilePickerSuccess extends FilePickerState {
  final List<Map<String, String>> files;

  FilePickerSuccess(this.files);

  @override
  List<Object?> get props => [files];
}

class FilePickerError extends FilePickerState {
  final String message;

  FilePickerError(this.message);

  @override
  List<Object?> get props => [message];
}
