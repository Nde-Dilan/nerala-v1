import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/learning/models/learning_item.dart';
import 'package:other_screens/presentation/pricing/pages/pricing_page.dart';

// Main Category Page
class CategoryPage extends StatefulWidget {
  const CategoryPage(
      {super.key,
      required this.categoryName,
      required this.quoteText,
      required this.categoryImage,
      required this.levels});
  final String categoryName;
  final String categoryImage;
  final int levels;
  final String quoteText;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    //   WidgetsBinding.instance.addPostFrameCallback((_) =>
    // ShowCaseWidget.of(context).startShowCase([_one, _two, _three])
// );
    super.initState();
  }

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
                _buildQuote(widget.quoteText),
                const SizedBox(height: 10),

                Column(
                  spacing: mediaWidth(context) / 14,
                  children: _getLearningItems(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Add this function in the _CategoryPageState class
  List<Widget> _getLearningItems() {
    switch (widget.categoryName.toLowerCase()) {
      case 'family':
        return learningItemsFamily;
      case 'animals':
        return learningItemsAnimals;
      case 'nature':
        return learningItemsNature;
      case 'sports':
        return learningItemsSports;
      case 'entertainment':
        return learningItemsEntertainment;
      case 'school':
        return learningItemsSchool;
      default:
        return []; // Return empty list as fallback
    }
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
                    "${widget.levels} Levels",
                    style: AppTextStyles.h2.copyWith(color: white),
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            widget.categoryImage,
            width: mediaWidth(context) / 4.4,
          ),
        ],
      ),
    );
  }

  Widget _buildQuote(String textQuote) {
    return Text(
      textQuote,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
