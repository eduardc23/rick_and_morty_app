import 'package:flutter/cupertino.dart';

class PaginationScrollController extends ScrollController {
  PaginationScrollController({
    required this.onThresholdReached,
    this.threshold = 200,
  });

  final VoidCallback onThresholdReached;

  final double threshold;

  void init() => addListener(_listener);

  void _listener() {
    if (!hasClients) return;
    if (position.extentAfter < threshold) onThresholdReached();
  }

  @override
  void dispose() {
    removeListener(_listener);
    super.dispose();
  }
}
