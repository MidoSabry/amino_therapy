import 'package:dartz/dartz.dart';

abstract class DownloadFileRepository {
  Future<Either<dynamic, dynamic>> download({required String endPoint,required int id});
}
