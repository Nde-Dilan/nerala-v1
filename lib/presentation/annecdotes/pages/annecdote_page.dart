// models/anecdote.dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/models/anecdotes/anecdote_model.dart';
import 'package:other_screens/presentation/annecdotes/widgets/anecdote_widgets.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:share_plus/share_plus.dart';

Logger _log = Logger("anecdote_page");

// screens/anecdote_detail_screen.dart
class AnecdoteDetailScreen extends StatelessWidget {
  final Anecdote anecdote;

  const AnecdoteDetailScreen({
    super.key,
    required this.anecdote,
  });

  @override
  Widget build(BuildContext context) {
    return PieCanvas(
      child: Scaffold(
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
                  keywords: anecdote.keywords,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: PieMenu(
          theme: PieTheme(
            buttonTheme: PieButtonTheme(
              backgroundColor: seedColorPalette.shade100,
              iconColor: seedColorPalette.shade700,
            ),
            buttonThemeHovered: PieButtonTheme(
              backgroundColor: seedColor,
              iconColor: Colors.white,
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Long press for options',
                  style: TextStyle(color: seedColorPalette.shade700),
                ),
                backgroundColor: seedColorPalette.shade100,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          actions: [
            PieAction(
              tooltip: const Text('Favorite'),
              onSelect: () => _log.info('favorited'),
              child: const Icon(Icons.favorite),
            ),
            PieAction(
              tooltip: const Text('Start Session'),
              onSelect: () {
                AppNavigator.push(context, HomePage());
              },
              child: const Icon(HugeIcons.strokeRoundedAllBookmark),
            ),
          ],
          child: FloatingActionButton(
            backgroundColor: seedColor,
            child: Icon(HugeIcons.strokeRoundedMenu02),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  void _shareAnecdote(BuildContext context) {
    // Implement share functionality
    Share.share('Hello! Here is a story I read from the Nerala app:\n\n'
        '${anecdote.title}\n\n'
        '${anecdote.content.length > 140 ? anecdote.content.substring(0, 150) : anecdote.content}...\n\n'
        'You can learn more here : https://nerala-production.vercel.app/ \n\n'
        'Join me on Nerala, and let’s learn about our culture in a fun and engaging way!');
  }
}


