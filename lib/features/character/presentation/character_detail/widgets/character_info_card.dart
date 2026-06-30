import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/enums/character_gender.dart';
import '../../../domain/entities/enums/character_species.dart';
import '../../../domain/entities/value_objects/character_id.dart';
import 'character_info_row.dart';

class CharacterInfoCard extends StatelessWidget {
  const CharacterInfoCard({
    super.key,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.id,
  });

  final CharacterSpecies species;
  final CharacterGender gender;
  final String origin;
  final String location;
  final CharacterId id;

  @override
  Widget build(BuildContext context) {
    final rows = <({String label, String value})>[
      (label: 'Species', value: species.toString()),
      (label: 'Gender', value: gender.toString()),
      (label: 'Origin', value: origin),
      (label: 'Last location', value: location),
      (label: 'ID', value: id.toString()),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        children: [
          for (final row in rows)
            CharacterInfoRow(label: row.label, value: row.value),
        ],
      ),
    );
  }
}
