import "package:carousel_slider/carousel_slider.dart";

import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/models/main/category_model.dart';
import 'package:other_screens/data/models/main/fun_fact_model.dart';
import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:other_screens/data/stories/stories.dart';
import 'package:other_screens/domain/auth/repository/stories_repository.dart';
import 'package:other_screens/presentation/annecdotes/pages/annecdote_page.dart';
import 'package:other_screens/presentation/learning/pages/home_category.dart';

final storyRepo = StoriesRepositoryImpl();

const basePath = "assets/storyAssets/";

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
  return CarouselSlider.builder(
    itemCount: storiesList.length,
    itemBuilder: (context, index, realIndex) {
      return buildCarouselItem(index, context);
    },
    options: CarouselOptions(
      height: 200,
      autoPlay: true,
      enlargeCenterPage: true,
      autoPlayInterval: const Duration(seconds: 5),
    ),
  );
}

Widget buildCarouselItem(int index, BuildContext context) {
  // Get story data with type safety
  final Map<String, dynamic> story =
      Map<String, dynamic>.from(storiesList[index]);

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      color: seedColorPalette.shade100,
      borderRadius: BorderRadius.circular(16),
    ),
    child: GestureDetector(
      onTap: () async {
        final stories = await storyRepo.getStories();
        final anecdote = stories[index];

        // Safely access values with null checks and type casting
        final String thumbnailUrl = story['thumbnailUrl']?.toString() ?? '';
        final String imageUrl = story['imageUrl']?.toString() ?? '';

        // Update anecdote properties
        anecdote.coverImage = basePath + thumbnailUrl;
        anecdote.thumbnailImage = basePath + thumbnailUrl;

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
            basePath + (story['imageUrl']?.toString() ?? ''),
            height: 100,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              story['body']!.toString().length > 140
                  ? '${story['body']?.toString().substring(0, 50)}...'
                  : story['body']?.toString() ?? '',
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
        return buildCategoryItem(categories[index], context);
      },
    ),
  );
}

Widget buildCategoryItem(Category category, BuildContext context) {
  return GestureDetector(
    // onTap: () => Navigator.pushNamed(context, category.route),
    onTap: () {
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
