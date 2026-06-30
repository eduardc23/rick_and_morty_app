import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_providers.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio();
}
