import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../component/toast/erp_toast.dart';
import '../global/enums/global_enum.dart';
import '../services/log/app_log.dart';

class FileService {
  static const int _maxFileSize = 3 * 1024 * 1024; // 3MB
  static const int _maxFiles = 3; // Max number of files

  /// Pick multiple files (any type: image, pdf, doc, etc.)
  static Future<List<Map<String, String>>> pickFiles({
    bool allowMultiple = true,
    List<String>? allowedExtensions,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        compressionQuality: 40,
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
        withData: false, // 🔑 don’t load file bytes eagerly
      );

      if (result == null || result.files.isEmpty) return [];

      // Process files concurrently
      final pickedFiles = await Future.wait(
        result.files.take(_maxFiles).map((file) async {
          try {
            // Read file bytes asynchronously
            final bytes = await File(file.path!).readAsBytes();
            AppLog.logValueAndTitle('File size after reading', bytes.length);

            // Check file size > 3MB
            if (bytes.length > _maxFileSize) {
              ErpToast().showNotification(
                message: 'fileSizeLimit'.tr(),
                type: MessageType.error,
              );
              return null;
            }

            // Encode base64 in an isolate
            final encoded = await compute(_encodeBase64, bytes);

            return {"fileName": file.name, "fileBinary": encoded};
          } catch (e) {
            ErpToast().showNotification(
              message: "File processing failed: $e",
              type: MessageType.error,
            );
            return null;
          }
        }),
      );

      // Filter out null results
      return pickedFiles.whereType<Map<String, String>>().toList();
    } catch (e) {
      throw Exception("File picking failed: $e");
    }
  }

  /// Convenience method for picking only images
  static Future<List<Map<String, String>>> pickImages({
    bool allowMultiple = true,
  }) {
    return pickFiles(
      allowMultiple: allowMultiple,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'heic', 'webp'],
    );
  }
}

/// Helper function for isolate base64 encoding
String _encodeBase64(Uint8List bytes) {
  return base64Encode(bytes);
}

// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:cleanarchitecture/core/component/toast/erp_toast.dart';
// import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
// import 'package:cleanarchitecture/core/services/log/app_log.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:file_picker/file_picker.dart';
//
// class FileService {
//   static const int _maxFileSize = 3 * 1024 * 1024; // 3MB
//   static const int _maxFiles = 3; // Max number of files
//
//   /// Pick multiple files (any type: image, pdf, doc, etc.)
//   static Future<List<Map<String, String>>> pickFiles({
//     bool allowMultiple = true,
//     List<String>? allowedExtensions,
//   }) async {
//     try {
//       final result = await FilePicker.platform.pickFiles(
//         allowMultiple: allowMultiple,
//         compressionQuality: 40,
//         type: allowedExtensions != null ? FileType.custom : FileType.any,
//         allowedExtensions: allowedExtensions,
//         withData: true,
//       );
//
//       if (result == null || result.files.isEmpty) return [];
//
//       final pickedFiles = <Map<String, String>>[];
//
//       for (final file in result.files) {
//         AppLog.logValueAndTitle('File size after compression', file.size);
//         // Ensure we don’t exceed max number of files
//         if (pickedFiles.length >= _maxFiles) {
//           ErpToast().showNotification(
//             message: "You can only upload up to $_maxFiles files.",
//             type: MessageType.error,
//           );
//           break; // stop processing more files
//         }
//
//         // final fileBytes = file.bytes ?? File(file.path!).readAsBytesSync();
//         Uint8List? bytes = file.bytes;
//         if (bytes == null) {
//           throw Exception("No file content found");
//         }
//         // Check file size > 3MB
//         // if (fileBytes.length > _maxFileSize) {
//         if (bytes.length > _maxFileSize) {
//           ErpToast().showNotification(
//             // message: "${file.name} is larger than 3MB and was skipped.",
//             message: 'fileSizeLimit'.tr(),
//             type: MessageType.error,
//           );
//           continue;
//         }
//
//         pickedFiles.add({
//           "fileName": file.name,
//           "fileBinary": base64Encode(bytes),
//           // "fileBinary": base64Encode(fileBytes),
//         });
//       }
//
//       return pickedFiles;
//     } catch (e) {
//       throw Exception("File picking failed: $e");
//     }
//   }
//
//   /// Convenience method for picking only images
//   static Future<List<Map<String, String>>> pickImages({
//     bool allowMultiple = true,
//   }) {
//     return pickFiles(
//       allowMultiple: allowMultiple,
//       allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'heic', 'webp'],
//     );
//   }
// }
