import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/enums/character_status.dart';
import '../mappers/status_color_mapper.dart';

class StatusDot extends StatelessWidget {
  const StatusDot({
    super.key,
    required this.status,
    this.size = AppSizes.dotSizeSmall,
    this.colorMapper = const DefaultStatusColorMapper(),
  });

  final CharacterStatus status;
  final double size;
  final StatusColorMapper colorMapper;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorMapper.map(status, colors),
        shape: BoxShape.circle,
      ),
    );
  }
}