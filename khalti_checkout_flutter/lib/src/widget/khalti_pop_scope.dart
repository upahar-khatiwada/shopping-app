import 'dart:async';

import 'package:flutter/widgets.dart';

// ignore: avoid_positional_boolean_parameters
/// `FutureOr<void> Function(bool, T?)`
typedef PopInvokedWithResultCallback<T> = FutureOr<void> Function(bool, T?);

/// `FutureOr<bool> Function()`
typedef CanPopCallback = FutureOr<bool> Function();

/// A wrapper around [PopScope] widget.
class KhaltiPopScope<T> extends StatelessWidget {
  /// Constructor for [KhaltiPopScope].
  const KhaltiPopScope({
    super.key,
    required this.child,
    this.onPopInvoked,
    this.canPop,
  });

  /// The child widget which is to be wrapped with [KhaltiPopScope].
  final Widget child;

  /// Callback that gets executed when the page is popped.
  final PopInvokedWithResultCallback<T>? onPopInvoked;

  /// Callback that determines whether or not a page can be popped.
  final CanPopCallback? canPop;

  @override
  Widget build(BuildContext context) {
    final isPoppable = canPop == null ? true : canPop!();

    if (isPoppable is Future<bool>) {
      return FutureBuilder<bool>(
        future: isPoppable,
        builder: (_, canPop) {
          return PopScope<T>(
            canPop: canPop.data ?? true,
            onPopInvokedWithResult: onPopInvoked,
            child: child,
          );
        },
      );
    }
    return PopScope(
      canPop: isPoppable,
      onPopInvokedWithResult: onPopInvoked,
      child: child,
    );
  }
}
