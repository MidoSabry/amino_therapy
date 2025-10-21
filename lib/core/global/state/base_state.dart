// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amino_therapy/core/global/enums/request_status.dart';
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class InitialState extends BaseState {
  const InitialState({this.count});
  final int? count;
}

class LoadingState extends BaseState {
  final DateTime timestamp;
  LoadingState() : timestamp = DateTime.now();
  @override
  List<Object> get props => [timestamp]; // always unique
}
// class LoadingState extends BaseState {}

class LoadingCalendarArrowState extends BaseState {}

class NotificationReadingLoadingState extends BaseState {}

class ErrorState extends BaseState {
  const ErrorState(this.data);
  final dynamic data;
}

class LoadedState<T> extends BaseState {
  const LoadedState(
    this.data, {
    this.mappedData,
    this.canPop = false,
    this.isHidden = true,
  });

  final T? data;
  final bool? canPop;
  final dynamic mappedData;
  final bool isHidden;

  @override
  List<Object?> get props => [data, mappedData, canPop, isHidden];

  LoadedState<T> copyWith({
    T? data,
    bool? canPop,
    dynamic mappedData,
    bool? isHidden,
  }) {
    return LoadedState<T>(
      data ?? this.data,
      mappedData: mappedData ?? this.mappedData,
      canPop: canPop ?? this.canPop,
      isHidden: isHidden ?? this.isHidden,
    );
  }
}

class RequestsLoadedState<T> extends BaseState {
  const RequestsLoadedState(
    this.data, {
    this.totalCount,
    required this.status,
    required this.offset,
  });

  final T? data;
  final RequestStatus status;
  final int offset;
  final int? totalCount;

  @override
  List<Object?> get props => [data, status, offset, totalCount];
}

class NotificationDeletedState<T> extends BaseState {
  const NotificationDeletedState(this.data, this.id);
  final String id;
  final T? data;
}

class NotificationReadState<T> extends BaseState {
  const NotificationReadState(this.data, this.id);
  final String id;
  final T? data;
}

class NotificationCountState extends BaseState {
  final int count;
  const NotificationCountState(this.count);
}

class EmptyState<T> extends BaseState {
  const EmptyState(this.data);

  final T? data;
}

class ButtonEnabledState extends BaseState {
  final DateTime timestamp;
  ButtonEnabledState() : timestamp = DateTime.now();
  @override
  List<Object> get props => [timestamp]; // always unique
}

class ButtonDisabledState extends BaseState {
  final DateTime timestamp;
  ButtonDisabledState() : timestamp = DateTime.now();
  @override
  List<Object> get props => [timestamp]; // always unique
}

class ButtonLoadingState extends BaseState {
  final bool isFirstButtonLoading;
  const ButtonLoadingState({this.isFirstButtonLoading = true});
}

class FavouriteAddOrDeletedState<T> extends BaseState {
  const FavouriteAddOrDeletedState(this.data, this.id, this.index);
  final int index;
  final String id;
  final T? data;
}

class FormLoadedState<T> extends BaseState {
  const FormLoadedState(this.data, {this.mappedData, this.canPop = false});
  final T? data;
  final bool? canPop;
  final dynamic mappedData;
}

class LoadedStateSubCategoryItems<T> extends BaseState {
  const LoadedStateSubCategoryItems(
    this.data, {
    this.mappedData,
    this.canPop = false,
  });
  final T? data;
  final bool? canPop;
  final dynamic mappedData;
}

/// Special states for form handling
class FormInvalidState extends BaseState {
  final Map<String, String> errors;
  const FormInvalidState(this.errors);
}

class TripTypeOnChangeState extends BaseState {
  final String tripTypeId;
  const TripTypeOnChangeState(this.tripTypeId);

  @override
  List<Object> get props => [tripTypeId];
}

class FormStateCase<T> extends BaseState {
  const FormStateCase({this.isFormEnabled = true});
  final bool? isFormEnabled;
}

class DataHiddenState extends BaseState {
  final bool isHidden;
  const DataHiddenState(this.isHidden);

  @override
  List<Object> get props => [isHidden];
}

class EnteredSuccessState<T> extends BaseState {
  const EnteredSuccessState(this.data);
  final T? data;
}
