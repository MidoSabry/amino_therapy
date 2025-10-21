import 'package:dartz/dartz.dart';

import '../download_file_repository/download_file_repository.dart';


class DownloadFileUseCase {
  final DownloadFileRepository downloadFileRepository;
  DownloadFileUseCase({required this.downloadFileRepository});

  Future<Either> download({required String endPoint,required int id}) async {
    return await downloadFileRepository.download(endPoint:endPoint,id: id);
  }

}
