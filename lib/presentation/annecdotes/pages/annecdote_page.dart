// models/anecdote.dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/presentation/annecdotes/widgets/anecdote_widgets.dart';
import 'package:share_plus/share_plus.dart';

class Anecdote {
  final String title;
  final String subtitle;
  final String content;
  final String coverImage;
  final String thumbnailImage;
  final String category;

  const Anecdote({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.coverImage,
    required this.thumbnailImage,
    required this.category,
  });
}

// screens/anecdote_detail_screen.dart
class AnecdoteDetailScreen extends StatelessWidget {
  final Anecdote anecdote;

  const AnecdoteDetailScreen({
    super.key,
    required this.anecdote,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: AnecdoteHeader(
                coverImage: anecdote.coverImage,
                thumbnailImage: anecdote.thumbnailImage,
                category: anecdote.category,
              ),
            ),
            leading: Platform.isIOS
                ? CupertinoButton(
                    child: const Icon(
                      CupertinoIcons.back,
                      color: seedColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: seedColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
            actions: [
              IconButton(
                color: seedColor,
                icon: const Icon(Icons.share),
                onPressed: () => _shareAnecdote(context),
              ),
            ],
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AnecdoteContent(
                title: anecdote.title,
                subtitle: anecdote.subtitle,
                content: anecdote.content,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareAnecdote(BuildContext context) {
    // Implement share functionality
    Share.share('Hello! Here is a story I read from the Nerala app:\n\n'
        '${anecdote.title}\n\n'
        '${anecdote.content}\n\n'
        'Join me on Nerala, and let’s learn about our culture in a fun and engaging way!');
  }
}

// Usage example:
void main() {
  final anecdote = Anecdote(
    title: 'Le Lièvre et la Tortue : Une Fable Nouvelle',
    subtitle: 'Une Fable Nouvelle',
    content: 'Dans une forêt dense où le soleil jouait avec les feuilles...',
    coverImage: 'assets/images/cover.png',
    thumbnailImage: 'assets/images/thumbnail.png',
    category: 'Family members',
  );

  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        // Customize theme here
      ),
      home: AnecdoteDetailScreen(anecdote: anecdote),
    ),
  );
}
