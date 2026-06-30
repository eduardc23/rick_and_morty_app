import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';


class CharacterSummarySection extends StatelessWidget {
  const CharacterSummarySection({super.key, required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: TextStyle(
            fontSize: AppFontSize.titleMedium,
            fontWeight: FontWeight.w700,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          summary,
          style: TextStyle(
            color: colors.onSurfaceVariant,
            height: AppDesignValues.lineHighlightHeight,
          ),
        ),
      ],
    );
  }
}
