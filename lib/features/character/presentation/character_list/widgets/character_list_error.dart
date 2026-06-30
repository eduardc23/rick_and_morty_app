import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/core/constants/app_constants.dart';
import 'package:rick_and_morty_app/core/error/failure_message_extension.dart';
import '../../providers/character_providers.dart';

class CharacterListError extends ConsumerWidget {
  final Object error;

  const CharacterListError({super.key, required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error.toUserMessage(), textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton(
            onPressed: () => ref.invalidate(characterListProvider),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
