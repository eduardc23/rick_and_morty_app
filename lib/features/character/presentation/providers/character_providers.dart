import 'dart:async';

import 'package:rick_and_morty_app/core/error/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/character.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/character_filter.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/pagination_info.dart';
import 'package:rick_and_morty_app/features/character/domain/providers/character_providers.dart';

import '../../../../core/utils/debouncer.dart';
import 'character_list_state.dart';

part 'character_providers.g.dart';

/// Notificador que gestiona los filtros de búsqueda de personajes.
/// 
/// Utiliza un [Debouncer] para evitar actualizaciones excesivas del estado
/// durante la escritura rápida en campos de búsqueda.
@riverpod
class CharacterFilterNotifier extends _$CharacterFilterNotifier {
  final _debouncer = Debouncer();

  @override
  CharacterFilter build() {
    // Asegura la limpieza del debouncer cuando el provider se destruye.
    ref.onDispose(_debouncer.dispose);
    return const CharacterFilter();
  }

  void _updateName(String? name) => state = state.copyWith(name: name);

  /// Actualiza el nombre del filtro aplicando un debounce para optimizar las peticiones.
  void updateNameDebounced(String? name) {
    _debouncer.run(() => _updateName(name));
  }
}

/// Proveedor que gestiona el estado de la lista de personajes.
/// 
/// Se encarga de la carga inicial, el filtrado y la paginación infinita.
/// Escucha los cambios en [characterFilterProvider] para recargar la lista automáticamente.
@riverpod
class CharacterList extends _$CharacterList {
  @override
  FutureOr<CharacterListState> build() async {
    // Observa el filtro de búsqueda. Si el filtro cambia, este provider se reinicia.
    final filter = ref.watch(characterFilterProvider);

    final response = await _fetch(filter, 1);

    return CharacterListState(response: response, currentPage: 1);
  }

  /// Realiza la petición al caso de uso para obtener una página específica.
  Future<PaginatedResponse<Character>> _fetch(
    CharacterFilter filter,
    int page,
  ) {
    return ref
        .read(getCharactersUseCaseProvider)
        .call(page: page, name: filter.name);
  }

  /// Carga la siguiente página de personajes y mezcla los resultados con el estado actual.
  /// 
  /// Controla estados de carga, límites de tasa (rate limiting) y si existen más páginas.
  Future<void> fetchNextPage() async {
    final current = state.value;

    // Evita peticiones si no hay datos iniciales, ya se está cargando,
    // hay un bloqueo de tasa o no hay más páginas disponibles.
    if (current == null) return;
    if (current.isLoadingMore || current.isRateLimited) return;
    if (!current.response.info.hasNextPage) return;

    // Indica que se está cargando la siguiente página.
    state = AsyncData(current.copyWith(isLoadingMore: true));

    final filter = ref.read(characterFilterProvider);
    final nextPage = current.currentPage + 1;

    try {
      final response = await _fetch(filter, nextPage);

      final latestState = state.value;
      if (latestState == null) return;

      // Fusiona los nuevos resultados con los existentes.
      final merged = PaginatedResponse(
        info: response.info,
        results: [...latestState.response.results, ...response.results],
      );

      state = AsyncData(
        latestState.copyWith(
          response: merged,
          currentPage: nextPage,
          isLoadingMore: false,
        ),
      );
    } on RateLimitFailure catch (e) {
      // Maneja errores de Rate Limit, estableciendo el tiempo de bloqueo.
      final latestState = state.value;
      if (latestState != null) {
        state = AsyncData(
          latestState.copyWith(
            isLoadingMore: false,
            blockedUntil: DateTime.now().add(e.retryAfter),
          ),
        );
      }
      rethrow;
    } catch (e, _) {
      // Manejo genérico de errores para asegurar que el indicador de carga se oculte.
      final latestState = state.value;
      if (latestState != null) {
        state = AsyncData(latestState.copyWith(isLoadingMore: false));
      }
      rethrow;
    }
  }
}
