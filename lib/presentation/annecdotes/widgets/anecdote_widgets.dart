
// widgets/anecdote_header.dart
import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

class AnecdoteHeader extends StatelessWidget {
  final String coverImage;
  final String thumbnailImage;
  final String category;

  const AnecdoteHeader({
    super.key,
    required this.coverImage,
    required this.thumbnailImage,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cover Image
        Image.asset(
          coverImage,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        // Thumbnail overlay
        Positioned(
          left: 16,
          bottom: -30,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: white, width: 4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                thumbnailImage,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// widgets/anecdote_content.dart
class AnecdoteContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String content;

  const AnecdoteContent({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
          ),
        ],
      ),
    );
  }
}
