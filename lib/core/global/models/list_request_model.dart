
import 'package:amino_therapy/core/extensions/string_extensions.dart';

class ListRequestModel {
  String? lang;
  String? status;
  String? requestNumber;
  String? requestDate;
  int? offset;
  String? attendanceDate;
  ListRequestModel({
    this.lang,
    this.status,
    this.requestNumber,
    this.requestDate,
    this.offset,
    this.attendanceDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lang': lang,
      if (!status!.isEmptyOrNull) 'status': status,
      if (!requestNumber.isEmptyOrNull) 'requestNumber': requestNumber,
      if (!requestDate.isEmptyOrNull) 'requestDate': requestDate,
      if (offset != null) 'offset': offset,
      if (attendanceDate != null) 'attendanceDate': attendanceDate,
    };
  }

  factory ListRequestModel.fromMap(Map<String, dynamic> map) {
    return ListRequestModel(
      lang: map['lang'] != null ? map['lang'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      requestNumber: map['requestNumber'] != null
          ? map['requestNumber'] as String
          : null,
      requestDate: map['requestDate'] != null
          ? map['requestDate'] as String
          : null,
      offset: map['offset'] != null ? map['offset'] as int : null,
    );
  }
}
