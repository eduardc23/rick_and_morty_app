import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/utils/pagination_scroll_controller.dart';
import '../../domain/entities/character.dart';
import '../character_detail/character_detail_screen.dart';
import '../providers/character_providers.dart';
import 'widgets/character_grid.dart';
import 'widgets/character_list_error.dart';
import 'widgets/character_search_field.dart';

class CharacterListScreen extends ConsumerStatefulWidget {
  const CharacterListScreen({super.key});

  @override
  ConsumerState<CharacterListScreen> createState() =>
      _CharacterListScreenState();
}

class _CharacterListScreenState extends ConsumerState<CharacterListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final PaginationScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = PaginationScrollController(
      onThresholdReached: _onLoadMore,
    )..init();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onLoadMore() async {
    try {
      await ref.read(characterListProvider.notifier).fetchNextPage();
    } catch (error) {
      if (mounted) {
        context.showErrorSnackBar(error);
      }
    }
  }

  void _onSearchChanged(String query) {
    ref.read(characterFilterProvider.notifier).updateNameDebounced(query);
  }

  void _onCharacterTap(Character character) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CharacterDetailScreen(character: character),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(characterListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.sm),

            CharacterSearchField(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),

            const SizedBox(height: AppSpacing.md),

            Expanded(
              child: characters.when(
                skipLoadingOnRefresh: false,
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => CharacterListError(error: error),
                data: (state) => CharacterGrid(
                  scrollController: _scrollController,
                  characters: state.response.results,
                  isLoadingMore: state.isLoadingMore,
                  onCharacterTap: _onCharacterTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
