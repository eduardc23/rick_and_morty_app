import 'package:flutter/material.dart';

class StatusDot extends StatelessWidget {
  const StatusDot({super.key, required this.status, this.size = 8});

  final String status;
  final double size;

  Color _colorFor(ColorScheme colors) {
    switch (status.toLowerCase()) {
      case 'alive':
        return colors.primary;
      case 'dead':
        return colors.error;
      default:
        return colors.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: _colorFor(colors), shape: BoxShape.circle),
    );
  }
}
