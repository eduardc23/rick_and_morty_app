import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_info.freezed.dart';

/// Información de paginación del dominio.
/// 
/// Contiene los metadatos necesarios para gestionar la carga infinita
/// y la navegación entre páginas de resultados.
@freezed
abstract class PaginationInfo with _$PaginationInfo {
  const factory PaginationInfo({
    /// Cantidad total de elementos disponibles.
    required int count,
    /// Cantidad total de páginas disponibles.
    required int pages,
    /// URL de la siguiente página, si existe.
    String? next,
    /// URL de la página anterior, si existe.
    String? prev,
  }) = _PaginationInfo;

  const PaginationInfo._();

  /// Indica si existe una página siguiente disponible.
  bool get hasNextPage => next != null;
  
  /// Indica si existe una página anterior.
  bool get hasPreviousPage => prev != null;
}

/// Respuesta paginada genérica para cualquier tipo de entidad.
@freezed
abstract class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    /// Información sobre la paginación.
    required PaginationInfo info,
    /// Lista de resultados de tipo [T].
    required List<T> results,
  }) = _PaginatedResponse<T>;
}
