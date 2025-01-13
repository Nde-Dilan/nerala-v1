// lib/widgets/question_header.dart
import 'package:flutter/material.dart';

class QuestionHeader extends StatelessWidget {
  final String title;
  final String instruction;
  final String? subtitle;
  final Widget? leading;
  final double avatarSize;
  final Color backgroundColor;

  const QuestionHeader({
    super.key,
    required this.title,
    required this.instruction,
    this.subtitle,
    this.leading,
    this.avatarSize = 40.0,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                radius: avatarSize / 2,
                backgroundColor: Colors.blue.withValues(alpha:0.1),
                child: leading,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    instruction,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// lib/widgets/audio_player.dart







// lib/widgets/choice_card.dart

// lib/widgets/draggable_letters_grid.dart