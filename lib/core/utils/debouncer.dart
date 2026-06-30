import 'dart:async';
import 'dart:ui';

import 'app_durations.dart';

class Debouncer {
  Debouncer({this.delay = AppDurations.searchDebounce});

  final Duration delay;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}
