import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/learning/models/learning_item.dart';
import 'package:other_screens/presentation/learning/widgets/level_item.dart';
import 'package:other_screens/presentation/pricing/pages/pricing_page.dart';

// Main Category Page
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: scaffoldBgColor,
        leading: BackButton(),
        title: Text(
          widget.categoryName,
          style: AppTextStyles.h2,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              AppNavigator.push(context, PremiumPage());
            },
            child: Image.asset("assets/icons/pricing/crown.png"),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: allPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                _buildHeroSection(),
                const SizedBox(height: 9),
                _buildQuote(),
                const SizedBox(height: 10),
                Column(
                  spacing: mediaWidth(context) / 14,
                  children: learningItems,
                ),
                // SizedBox(
                //     height: mediaHeight(context) / 2,
                //     child: buildLearningItems(learningItems)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String categoryName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: pricingCardback,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: allPadding,
                  decoration: BoxDecoration(
                      color: darkColor,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "4 Levels",
                    style: AppTextStyles.h2.copyWith(color: white),
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            "assets/icons/category-page/header-images/family.png",
            width: mediaWidth(context) / 4.4,
          ),
        ],
      ),
    );
  }

  Widget _buildQuote() {
    return const Text(
      'A family is like a forest, when you are outside, it is dense; when you are inside, you see that each tree has its place.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget buildLearningItems(List<LevelItem> learningItems) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: learningItems.length,
      itemBuilder: (context, index) {
        return LevelItem(
          levelName: 'Family Seed',
          levelImage: "assets/icons/category/family.png",
        );
      },
    );
  }
}

// Subscription Toggle Widget
class SubscriptionToggle extends StatelessWidget {
  final bool isYearlySelected;
  final ValueChanged<bool> onToggle;

  const SubscriptionToggle({
    super.key,
    required this.isYearlySelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildOption('Year', isYearlySelected, true),
          _buildOption('Month', !isYearlySelected, false),
        ],
      ),
    );
  }

  Widget _buildOption(String text, bool isSelected, bool isYearly) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onToggle(isYearly),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? pricingCardback : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
