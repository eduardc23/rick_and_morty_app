import 'package:flutter/material.dart';

import '../error/failure_message_extension.dart';

extension UIContextExtension on BuildContext {
  void showErrorSnackBar(Object error) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(error.toUserMessage()),
        backgroundColor: Theme.of(this).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
