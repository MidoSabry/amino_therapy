import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/services/base_network/general_response_model.dart';
import '../../../../../core/services/base_network/network_repository.dart';
import '../../domain/download_file_repository/download_file_repository.dart';
import '../model/download_file_response_model.dart';

class DownloadFileRepositoryImpl extends MainRepository
    implements DownloadFileRepository {
  DownloadFileRepositoryImpl({
    required super.remoteData,
    required super.networkInfo,
  });

  @override
  Future<Either> download({required String endPoint, required int id}) async {
    try {
      var newEndpoint =
          endPoint.contains('?') ? endPoint : '$endPoint?fileId=$id';
      final result = await remoteData.get(
        endPoint: newEndpoint,
        headers: headers,
        model: GeneralResponseModel(model: const DownloadFileResponseModel()),
      );
      return result;
    } catch (e) {
      // If an error occurs, return the error wrapped in Left
      return Left(
        GeneralResponseModel(
          statusCode: "unknown".tr(),
          englishMessage: e.toString(),
          arabicMessage: e.toString(),
        ),
      );
    }
  }
}
