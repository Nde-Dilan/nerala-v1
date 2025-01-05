import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/loading_builder.dart';
import 'package:other_screens/data/models/main/fun_fact_model.dart';
import 'package:other_screens/data/models/main/category_model.dart';
import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:other_screens/presentation/auth/pages/login_page.dart';
import 'package:other_screens/presentation/dictionary/pages/dictionary.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_cubit.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_state.dart';
import 'package:other_screens/presentation/main/methods/pages_method.dart';

// Main HomePage Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentPage = 0;
  final double tabBarHeight = 55;

  final List<Widget> _kTabPages = [
    const HomePage(),
    const HomePage(),
    const DictionaryPage(),
    const LoginPage(),
    const LoginPage(),
  ];

  final List<IconData> tabIcons = [
    Icons.person,
    Icons.home,
    Icons.person,
    Icons.settings,
    Icons.settings,
  ];

  final List<String> tabNames = [
    'Profile',
    'Home',
    'Profile',
    'Settings',
    'Settings',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        bottomNavigationBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: UnconstrainedBox(
            child: Container(
              height: tabBarHeight,
              constraints: BoxConstraints(
                maxWidth: mediaWidth(context) - 50.0,
              ),
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xff86f16a),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: seedColor,
                    blurRadius: 8.0,
                    offset: Offset(0, 4.0),
                  ), 
                ],
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  onTap: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  tabs: List.generate(
                    _kTabPages.length,
                    (index) => Tab(
                      icon: Icon(tabIcons[index]),
                      text: tabNames[index],
                    ),
                  ),
                  dividerHeight: 0.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
