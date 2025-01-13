
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


 final List<Choice> choices = [
      const Choice(
        value: 'basic',
        label: 'Basic Plan',
        backgroundColor: Color(0xFF7ED957), // Green color from your theme
        imageUrl: 'assets/icons/mock-data/papa.png',
      ),
      const Choice(
        value: 'premium',
        label: 'Premium Package',
        backgroundColor: Color(0xFF93FF69), // Lighter green
        imageUrl: 'assets/icons/mock-data/papa.png',
      ),
      const Choice(
        value: 'family',
        label: 'Family Bundle',
        backgroundColor: Color(0xFF6BBF4B), // Darker green
        imageUrl: 'assets/icons/mock-data/papa.png',
      ),
      const Choice(
        value: 'enterprise',
        label: 'Enterprise Solution',
        backgroundColor: Color(0xFF5DAD3F), // Even darker green
        imageUrl: 'assets/icons/mock-data/papa.png',
      ),
    ];