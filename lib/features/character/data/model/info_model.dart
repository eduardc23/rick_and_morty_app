import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_model.freezed.dart';
part 'info_model.g.dart';

@freezed
abstract class InfoModel with _$InfoModel {
  const factory InfoModel({
    required int count,
    required int pages,
    String? next,
    String? prev,
  }) = _InfoModel;

  factory InfoModel.fromJson(Map<String, dynamic> json) => _$InfoModelFromJson(json);
}
