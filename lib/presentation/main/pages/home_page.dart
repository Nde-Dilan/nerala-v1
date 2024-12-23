import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/loading_builder.dart';
import 'package:other_screens/data/models/main/fun_fact_model.dart';
import 'package:other_screens/data/models/main/category_model.dart';
import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_cubit.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_state.dart';
import 'package:other_screens/presentation/main/methods/pages_method.dart';

// Main HomePage Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Category> categories = [
    Category(
      title: 'Family',
      imagePath: 'assets/icons/category/family.png',
      route: '/family',
    ),
    Category(
      title: 'Animals',
      imagePath: 'assets/icons/category/zoo.png',
      route: '/animals',
    ),
    Category(
      title: 'Nature',
      imagePath: 'assets/icons/category/nature.png',
      route: '/nature',
    ),
    Category(
      title: 'Sports',
      imagePath: 'assets/icons/category/sports.png',
      route: '/sports',
    ),
    Category(
      title: 'Entertainment',
      imagePath: 'assets/icons/category/entertainment.png',
      route: '/entertainment',
    ),
    Category(
      title: 'School',
      imagePath: 'assets/icons/category/school.png',
      route: '/school',
    ),
    Category(
      title: 'Entertainment',
      imagePath: 'assets/icons/category/entertainment.png',
      route: '/entertainment',
    ),
    Category(
      title: 'School',
      imagePath: 'assets/icons/category/school.png',
      route: '/school',
    ),
    Category(
      title: 'Entertainment',
      imagePath: 'assets/icons/category/entertainment.png',
      route: '/entertainment',
    ),
    Category(
      title: 'School',
      imagePath: 'assets/icons/category/school.png',
      route: '/school',
    ),
    Category(
      title: 'Entertainment',
      imagePath: 'assets/icons/category/entertainment.png',
      route: '/entertainment',
    ),
    Category(
      title: 'School',
      imagePath: 'assets/icons/category/school.png',
      route: '/school',
    ),
    Category(
      title: 'Entertainment',
      imagePath: 'assets/icons/category/entertainment.png',
      route: '/entertainment',
    ),
    Category(
      title: 'School',
      imagePath: 'assets/icons/category/school.png',
      route: '/school',
    ),
    Category(
      title: 'Entertainment',
      imagePath: 'assets/icons/category/entertainment.png',
      route: '/entertainment',
    ),
    Category(
      title: 'School',
      imagePath: 'assets/icons/category/school.png',
      route: '/school',
    ),
  ];

  final List<FunFact> funFacts = [
    FunFact(
      title: 'Anecdote',
      description: 'Fun facts about Cameroonian languages...',
      imagePath: 'assets/images/anecdotes.png',
    ),
    FunFact(
      title: 'Anecdote',
      description: 'Fun facts 1 about Cameroonian languages...',
      imagePath: 'assets/images/anecdotes.png',
    ),
    FunFact(
      title: 'Anecdote',
      description: 'Fun facts 2 about Cameroonian languages...',
      imagePath: 'assets/images/anecdotes.png',
    ),
    // Add more fun facts here
  ];

  @override
  Widget build(BuildContext context) {
    final mockStats = LearningStats(
      learningRate: 0.75,
      totalWordsLearned: 250,
      totalDaysLearned: 30,
    );
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        body: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
          builder: (context, state) {
            if (state is UserInfoLoading) {
              return Center(child: const DefaultLoadingBuilder());
            }
            if (state is UserInfoLoaded) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: mediaWidth(context) / 10,
                  ),
                  child: Column(
                    spacing: mediaWidth(context) / 8,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaWidth(context) / 18),
                        child: buildHeader(mockStats, state.user.firstName),
                      ),
                      buildCarousel(funFacts),
                      buildCategoriesGrid(categories),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
