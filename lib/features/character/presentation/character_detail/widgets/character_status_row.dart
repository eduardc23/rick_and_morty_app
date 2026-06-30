import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/enums/character_status.dart';
import '../../character_list/widgets/status_dot.dart';

class CharacterStatusRow extends StatelessWidget {
  const CharacterStatusRow({super.key, required this.status});

  final CharacterStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        StatusDot(status: status, size: AppSizes.dotSize),
        const SizedBox(width: AppSpacing.sm),
        Text(
          status.toString(),
          style: TextStyle(
            fontSize: AppFontSize.bodyLarge,
            fontWeight: FontWeight.w600,
            color: colors.onSurface,
          ),
        ),
      ],
    );
  }
}
