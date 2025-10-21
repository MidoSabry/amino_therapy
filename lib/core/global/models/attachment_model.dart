// ignore_for_file: public_member_api_docs, sort_constructors_first
class Attachment {
  int? fileId;
  String fileName;
  String fileBinary;
  String? fileHeaderName;
  Attachment({
    this.fileId,
    required this.fileName,
    required this.fileBinary,
    this.fileHeaderName,
  });

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      fileId: map['fileId'] ?? map['ID'] ?? -1,
      fileName: map['fileName'] ?? map['FileName'] ?? '',
      fileBinary: map['fileBinary'] ?? map['FileBinary'] ?? '',
      fileHeaderName: map['fileHeaderName'] ?? map['FileHeaderName'] ?? '',
    );
  }

  Map<String, dynamic> toMap({bool isResignation = false}) {
    return {
      // if(fileId!=1)"fileId": fileId,
      "fileName": fileName,
      "fileBinary": fileBinary,
      if(isResignation)"fileHeaderName": fileHeaderName ?? "",
    };
  }

  @override
  String toString() =>
      'Attachment(fileName: $fileName, fileBinary: $fileBinary, fileHeaderName: $fileHeaderName)';
}
