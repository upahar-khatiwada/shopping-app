import 'dart:async';
import 'package:flutter/material.dart';

class DeBouncerClass {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DeBouncerClass({required this.milliseconds});

  void run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
