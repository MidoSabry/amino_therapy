import 'dart:io';

import '../../data/constants/shared_preferences_constants.dart';
import '../local_storage/secure_storage/secure_storage_service.dart';
import 'client/dio_client.dart';
import 'network_lost/network_info.dart';

class MainRepository {
  final DioClient remoteData;
  // final LocalData localData;
  final NetworkInfo networkInfo;
  Map<String, String> headers = {};

  MainRepository({
    required this.remoteData,
    // required this.localData,
    required this.networkInfo,
  }) {
    _initializeHeaders();
  }

  Future<void> _initializeHeaders() async {
    String token =
        await SecureStorageService().read(
          key: SharPrefConstants.userLoginTokenKey,
        ) ??
        '';
    headers = {
      'Accept': 'text/plain',
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
}
