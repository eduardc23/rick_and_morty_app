import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../character_list/widgets/status_dot.dart';

class CharacterStatusRow extends StatelessWidget {
  const CharacterStatusRow({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        StatusDot(status: status, size: 10),
        const SizedBox(width: AppSpacing.sm),
        Text(
          status,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colors.onSurface,
          ),
        ),
      ],
    );
  }
}
