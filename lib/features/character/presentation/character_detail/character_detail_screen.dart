import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/character/presentation/character_detail/widgets/character_summary_section.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/character.dart';
import 'widgets/character_detail_header.dart';
import 'widgets/character_info_card.dart';
import 'widgets/character_status_row.dart';


class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CharacterDetailHeader(
              imageUrl: character.image,
              name: character.name,
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CharacterStatusRow(status: character.status),
                  const SizedBox(height: AppSpacing.md),
                  CharacterInfoCard(
                    species: character.species,
                    gender: character.gender,
                    origin: character.originName,
                    location: character.locationName,
                    id: character.id,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  CharacterSummarySection(summary: character.summary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
