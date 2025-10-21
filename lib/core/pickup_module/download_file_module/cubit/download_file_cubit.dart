import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';
import '../../../../../core/global/state/base_state.dart';
import '../../../../../core/services/base_network/general_response_model.dart';

import 'dart:isolate';

import '../../../component/toast/erp_toast.dart';
import '../../../global/enums/global_enum.dart'
    hide ToastPosition;
import '../../../services/localization/app_localization.dart';
import '../data/model/download_file_response_model.dart';
import '../domain/use_case/download_file_use_case.dart';

class DownloadFileCubit extends Cubit<BaseState> {
  final DownloadFileUseCase downloadFileUseCase;

  DownloadFileCubit({required this.downloadFileUseCase})
    : super(const InitialState());

  Future<void> download({required String endPoint, required int id}) async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        ErpToast().showNotification(
          position: ToastPosition.center,
          message: "❌ Storage permission denied",
          type: MessageType.error,
        );
        return;
      }
    }

    emit(LoadingState());

    final response = await downloadFileUseCase.download(
      endPoint: endPoint,
      id: id,
    );

    await response.fold(
      (failure) {
        final res = failure as GeneralResponseModel;
        final errorMessage =
            (AppLocalization.isArabic
                ? res.arabicMessage
                : res.englishMessage) ??
            'unexpectedError';
        emit(ErrorState(errorMessage));
      },
      (r) async {
        try {
          final responseModel = r as GeneralResponseModel;
          final model = responseModel.model as DownloadFileResponseModel;

          final fileName = model.data?.fileName ?? 'file.bin';
          final base64File = model.data?.fileBinary ?? '';
          String savePath;
          if (Platform.isAndroid) {
            savePath = await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOWNLOAD,
            );
          } else {
            final dir = await getApplicationDocumentsDirectory();
            savePath = dir.path;
          }

          // ✅ Setup isolate communication
          final port = ReceivePort();
          final completer = Completer<String>();

          port.listen((message) {
            if (message is List && message.first == 'progress') {
              final received = message[1] as int;
              final total = base64File.length;
              // You could emit a ProgressState if you want
              debugPrint("Progress: $received / $total");
            } else if (message is List && message.first == 'done') {
              completer.complete(message[1] as String);
              port.close();
            } else if (message is List && message.first == 'error') {
              completer.completeError(message[1] as String);
              port.close();
            }
          });

          await Isolate.spawn(DownloadFileCubit._saveFileTask, [
            "$savePath/$fileName",
            base64File,
            port.sendPort,
          ]);

          final filePath = await completer.future;

          // ErpToast().showNotification(
          //   position: ToastPosition.center,
          //   message: 'downloaded_successfully'.tr(),
          //   type: MessageType.success,
          // );

          emit(LoadedState(r));
          OpenFilex.open(filePath);
        } catch (e) {
          emit(ErrorState(e.toString()));
        }
      },
    );
  }

  // ---- Background isolate task ----
  static Future<void> _saveFileTask(List args) async {
    final filePath = args[0] as String;
    final base64Data = args[1] as String;
    final sendPort = args[2] as SendPort;

    try {
      final file = File(filePath);
      final sink = file.openWrite();

      const chunkSize = 1024 * 1024; // 1 MB
      final total = base64Data.length;

      for (int i = 0; i < total; i += chunkSize) {
        final end = (i + chunkSize < total) ? i + chunkSize : total;
        final chunk = base64Data.substring(i, end);
        sink.add(base64Decode(chunk));
      }

      await sink.close();
      sendPort.send(['done', file.path]);
    } catch (e) {
      sendPort.send(['error', e.toString()]);
    }
  }
}
