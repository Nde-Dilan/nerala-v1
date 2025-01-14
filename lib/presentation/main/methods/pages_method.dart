import "package:carousel_slider/carousel_slider.dart";

import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/models/main/category_model.dart';
import 'package:other_screens/data/models/main/fun_fact_model.dart';
import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:other_screens/presentation/annecdotes/pages/annecdote_page.dart';
import 'package:other_screens/presentation/learning/pages/home_category.dart';
import 'package:other_screens/presentation/main/widgets/stats_card.dart';
import 'package:other_screens/presentation/pricing/pages/pricing_page.dart';

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
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CountdownTimer(),
          GestureDetector(
              onTap: () {
                AppNavigator.push(context, PremiumPage());
              },
              child: Image.asset("assets/icons/pricing/crown.png")),
          const Text(
            'Hi,',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            formatUsername(username),
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: seedColor),
          ),
          const Text(
            'Olia ?',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      StatsCard(stats: stats),
    ],
  );
}

Widget buildCarousel(List<FunFact> funFacts) {
  return CarouselSlider.builder(
    itemCount: funFacts.length,
    itemBuilder: (context, index, realIndex) {
      return buildCarouselItem(funFacts[index],context);
    },
    options: CarouselOptions(
      height: 200,
      autoPlay: true,
      enlargeCenterPage: true,
      autoPlayInterval: const Duration(seconds: 5),
    ),
  );
}

Widget buildCarouselItem(FunFact funFact,BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      color: seedColorPalette.shade100,
      borderRadius: BorderRadius.circular(16),
    ),
    child: GestureDetector(
      onTap: (){
         final anecdote = Anecdote(
                    title: 'Le Lièvre et la Tortue : Une Fable Nouvelle',
                    subtitle: 'Une Fable Nouvelle',
                    content:
                        'Dans une forêt dense où le soleil jouait avec les feuilles...',
                    coverImage: 'assets/images/cover.png',
                    thumbnailImage: 'assets/images/thumbnail.png',
                    category: 'Family members',
                  );
                  // Navigate to "LOG IN" screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnecdoteDetailScreen(
                                anecdote: anecdote,
                              )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            funFact.imagePath,
            height: 100,
          ),
          const SizedBox(height: 8),
          Text(
            funFact.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
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
                    categoryName: category.title, quoteText: category.quoteText, categoryImage: category.imagePath, levels: category.numberOfLevels,
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
