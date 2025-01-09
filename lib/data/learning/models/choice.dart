
// / lib/models/choice.dart
import 'package:flutter/material.dart';

class Choice {
  final String value;
  final String label;
  final String? imageUrl;
  final Color? backgroundColor;

  const Choice({
    required this.value,
    required this.label,
    this.imageUrl,
    this.backgroundColor,
  });
}
