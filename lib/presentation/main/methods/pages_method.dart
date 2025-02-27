import "package:carousel_slider/carousel_slider.dart";

import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/auth/repository/auth_repository_impl.dart';
import 'package:other_screens/data/models/anecdotes/anecdote_model.dart';
import 'package:other_screens/data/models/main/category_model.dart';
import 'package:other_screens/data/models/main/fun_fact_model.dart';
import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:other_screens/data/stories/stories.dart';
import 'package:other_screens/domain/auth/entities/user_entity.dart';
import 'package:other_screens/domain/auth/repository/stories_repository.dart';
import 'package:other_screens/presentation/annecdotes/pages/anecdote_page.dart';
import 'package:other_screens/presentation/learning/pages/home_category.dart';
import 'package:other_screens/presentation/main/methods/story_cache.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storyRepo = StoriesRepositoryImpl();


String formatUsername(String username) {
  if (username.isEmpty) return '';

  // Check for spaces and return first word if found
  if (username.contains(' ')) {
    return username.split(' ')[0];
  }
  if (username.length > 9) {
    return username.replaceAllMapped(
        RegExp(r'.{9}'), (match) => '${match.group(0)}\n');
  }
  return username;
}

Widget buildHeader(LearningStats stats, String username, BuildContext context) {
  return Text("");
}

Widget buildCarousel(List<FunFact> funFacts) {
  final stories =
      storiesList.map((storyData) => Anecdote.fromJson(storyData)).toList();

  return CarouselSlider.builder(
    itemCount: stories.length,
    itemBuilder: (context, index, realIndex) {
      return buildCarouselItem(index, context, stories);
    },
    options: CarouselOptions(
      height: 200,
      autoPlay: true,
      enlargeCenterPage: true,
      autoPlayInterval: const Duration(seconds: 5),
    ),
  );
}

Widget buildCarouselItem(
    int index, BuildContext context, List<Anecdote> stories) {
  final anecdote = stories[index];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      color: seedColorPalette.shade100,
      borderRadius: BorderRadius.circular(16),
    ),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnecdoteDetailScreen(anecdote: anecdote),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            basePath + anecdote.thumbnailImage,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error_outline, size: 50);
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              anecdote.content.length > 50
                  ? '${anecdote.content.substring(0, 50)}...'
                  : anecdote.content,
              textAlign: TextAlign.left,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCategoriesGrid(List<Category> categories) {
  return Expanded(
    child: GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return buildCategoryItem(categories[index], context, true);
      },
    ),
  );
}

Widget buildCategoryItem(Category category, BuildContext context, mounted) {
  return GestureDetector(
    // onTap: () => Navigator.pushNamed(context, category.route),
    onTap: () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contex) => CategoryPage(
                    categoryName: category.title,
                    quoteText: category.quoteText,
                    categoryImage: category.imagePath,
                    levels: category.numberOfLevels,
                  )));
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Image.asset(
            category.imagePath,
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          category.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget buildStatItem({
  required IconData icon,
  required String value,
  required String label,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 16),
      const SizedBox(width: 4),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  );
}
