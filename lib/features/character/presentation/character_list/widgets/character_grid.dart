import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/character.dart';
import 'character_card.dart';
import 'empty_state.dart';

class CharacterGrid extends StatelessWidget {
  const CharacterGrid({
    super.key,
    required this.characters,
    required this.onCharacterTap,
    required this.isLoadingMore,
    this.scrollController,
  });

  final List<Character> characters;
  final bool isLoadingMore;
  final ValueChanged<Character> onCharacterTap;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      return const EmptyStateView(message: 'No characters were found');
    }

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final character = characters[index];

              return CharacterCard(
                key: ValueKey(character.id),
                character: character,
                onTap: () => onCharacterTap(character),
              );
            }, childCount: characters.length),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: .6,
            ),
          ),
        ),

        if (isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
      ],
    );
  }
}
