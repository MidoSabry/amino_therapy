import 'dart:convert';

import '../log/app_log.dart';
class GeneralResponseModel {
  dynamic model;
  String? status;
  String? message;
  String? arabicMessage;
  String? englishMessage;
  String? statusCode;
  String? errorMessage;
  int? totalCount;
  GeneralResponseModel({
    this.model,
    this.status,
    this.arabicMessage,
    this.message,
    this.englishMessage,
    this.statusCode,
    this.errorMessage,
    this.totalCount,
  });

  GeneralResponseModel copyWith({
    dynamic model,
    String? status,
    String? message,
    String? englishMessage,
    String? arabicMessage,
    String? statusCode,
    String? errorMessage,
    int? totalCount,
  }) {
    return GeneralResponseModel(
      totalCount: totalCount ?? this.totalCount,
      model: model ?? this.model,
      status: status ?? this.status,
      arabicMessage: arabicMessage ?? this.arabicMessage,
      englishMessage: englishMessage ?? this.englishMessage,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalCount': totalCount,
      'data': model,
      'status': status,
      'message': message,
      'arabicMessage': arabicMessage,
      'englishMessage': englishMessage,
      'code': statusCode,
      'errorMessage': errorMessage,
    };
  }

  GeneralResponseModel fromMap(Map<String, dynamic> map) {
    try {
      return GeneralResponseModel(
        model:
            (map['data'] is bool
                ? true
                : (map['data'] == null ||
                        (map['data'] is Map && map['data'].isEmpty)
                    ? null
                    : model.fromMap(map))),
        status: map['status'] != null ? map['status'] as String : null,
        arabicMessage:
            map['arabicMessage'] != null
                ? map['arabicMessage'] as String
                : null,
        englishMessage:
            map['englishMessage'] != null
                ? map['englishMessage'] as String
                : null,
        message: map['message'] != null ? map['message'] as String : null,
        totalCount: map['totalCount'] != null ? map['totalCount'] as int : null,
        statusCode: map['code'] != null ? map['code'] as String : null,
        errorMessage:
            map['errorMessage'] != null ? map['errorMessage'] as String : null,
      );
    } catch (e) {
      AppLog.printValue('catch parsing');
      AppLog.printValue(e.toString());
      return GeneralResponseModel();
    }
  }

  String toJson() => json.encode(toMap());

  GeneralResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GeneralResponseModel(data: $model, status: $status, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(covariant GeneralResponseModel other) {
    if (identical(this, other)) return true;

    return other.model == model &&
        other.status == status &&
        other.message == message &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode {
    return model.hashCode ^
        status.hashCode ^
        message.hashCode ^
        statusCode.hashCode;
  }
}
