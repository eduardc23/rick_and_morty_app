import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_model.freezed.dart';
part 'info_model.g.dart';

/// Modelo de datos para la información de paginación de la API.
@freezed
abstract class InfoModel with _$InfoModel {
  const factory InfoModel({
    /// El número total de personajes.
    required int count,
    /// El número total de páginas.
    required int pages,
    /// URL de la siguiente página (si existe).
    String? next,
    /// URL de la página anterior (si existe).
    String? prev,
  }) = _InfoModel;

  factory InfoModel.fromJson(Map<String, dynamic> json) => _$InfoModelFromJson(json);
}
