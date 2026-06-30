import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_info.freezed.dart';

@freezed
abstract class PaginationInfo with _$PaginationInfo {
  const factory PaginationInfo({
    required int count,
    required int pages,
    String? next,
    String? prev,
  }) = _PaginationInfo;

  const PaginationInfo._();

  bool get hasNextPage => next != null;
  bool get hasPreviousPage => prev != null;
}

@freezed
abstract class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required PaginationInfo info,
    required List<T> results,
  }) = _PaginatedResponse<T>;
}
