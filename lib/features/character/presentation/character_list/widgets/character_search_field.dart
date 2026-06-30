import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';

class CharacterSearchField extends StatelessWidget {
  const CharacterSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search by name',
        prefixIcon: Icon(Icons.search, color: colors.onSurfaceVariant),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.searchVertical),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.searchField),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
