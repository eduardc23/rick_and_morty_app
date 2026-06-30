import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../network/dio_exception_mapper.dart';

part 'network_providers.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio();
}

@riverpod
DioExceptionMapper dioExceptionMapper(Ref ref) {
  return DioExceptionMapper();
}
